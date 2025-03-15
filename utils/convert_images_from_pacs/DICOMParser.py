import os, pdb
from io import BytesIO
import base64
import json
import numpy as np
import matplotlib.pyplot as plt
from collections import defaultdict

from pydicom import dcmread
from pathlib import Path

# FOR OPVs - https://github.com/msaifee786/hvf_extraction_script.git
# git clone https://github.com/msaifee786/hvf_extraction_script.git
from hvf_extraction_script.hvf_data.hvf_object import Hvf_Object
from hvf_extraction_script.utilities.file_utils import File_Utils

# PDFs
import pymupdf  # PyMuPDF
from PIL import Image



OPHTHALMOLOGY_SOP_CLASSES = {
    "1.2.840.10008.5.1.4.1.1.77.1.5.1": "Ophthalmic Photography 8 Bit Image Storage",
    "1.2.840.10008.5.1.4.1.1.77.1.5.2": "Ophthalmic Photography 16 Bit Image Storage",
    "1.2.840.10008.5.1.4.1.1.77.1.5.5": "Wide Field Ophthalmic Photography Stereographic Projection Image Storage",
    "1.2.840.10008.5.1.4.1.1.77.1.5.6": "Wide Field Ophthalmic Photography 3D Coordinates Image Storage",
    "1.2.840.10008.5.1.4.1.1.77.1.5.4": "Ophthalmic Tomography Image Storage",
    "1.2.840.10008.5.1.4.1.1.77.1.5.7": "Ophthalmic Optical Coherence Tomography En Face Image Storage",
    "1.2.840.10008.5.1.4.1.1.77.1.5.8": "Ophthalmic Optical Coherence Tomography B-scan Volume Analysis Storage",
    "1.2.840.10008.5.1.4.1.1.78.7": "Ophthalmic Axial Measurements Storage",
    "1.2.840.10008.5.1.4.1.1.78.8": "Intraocular Lens Calculations Storage",
    "1.2.840.10008.5.1.4.1.1.81.1": "Ophthalmic Thickness Map Storage",
    "1.2.840.10008.5.1.4.1.1.82.1": "Corneal Topography Map Storage",
    "1.2.840.10008.5.1.4.1.1.79.1": "Macular Grid Thickness and Volume Report Storage",
    "1.2.840.10008.5.1.4.1.1.80.1": "Ophthalmic Visual Field Static Perimetry Measurements Storage",
    "1.2.840.10008.5.1.4.1.1.78.1": "Lensometry Measurements Storage",
    "1.2.840.10008.5.1.4.1.1.78.2": "Autorefraction Measurements Storage",
    "1.2.840.10008.5.1.4.1.1.78.3": "Keratometry Measurements Storage",
    "1.2.840.10008.5.1.4.1.1.78.4": "Subjective Refraction Measurements Storage",
    "1.2.840.10008.5.1.4.1.1.78.5": "Visual Acuity Measurements Storage",
    "1.2.840.10008.5.1.4.1.1.78.6": "Spectacle Prescription Report Storage",
    "1.2.840.10008.5.1.4.1.1.7": "Secondary Capture Image Storage",
    "1.2.840.10008.5.1.4.1.1.7.2": "Multi-frame True Color Secondary Capture Image Storage",
    "1.2.840.10008.5.1.4.1.1.104.1": "Encapsulated PDF Storage",
    "1.2.840.10008.5.1.4.1.1.66": "Spatial Registration Storage"
}

class DICOMParser:
    """Base class for parsing DICOM files with a built-in factory method."""
    
    model_parsers = {}

    def __init__(self, dicom_path):
        self.dicom_path = Path(dicom_path)
        self.ds = dcmread(self.dicom_path)
        self.manufacturer = self.ds.get("Manufacturer", "Unknown")
        self.model = self.ds.get("ManufacturerModelName", "Unknown")
        self.modality = self.ds.get("Modality", "Unknown")
        self.study_date = self.ds.get("StudyDate", "Unknown")
        self.sop_class = self.ds.get("SOPClassUID", "Unknown")
        self.sop_instance = self.ds.get("SOPInstanceUID", "Unknown")

    @classmethod
    def register_parser(cls, model_name, parser_class):
        cls.model_parsers[model_name] = parser_class

    @classmethod
    def create_parser(cls, dicom_path):
        ds = dcmread(dicom_path)
        model = ds.get("ManufacturerModelName", "Unknown")
        parser_class = cls.model_parsers.get(model, cls)
        return parser_class(dicom_path)
    
    def parse_pdf_pages(self):
        # 'Encapsulated PDF Storage'
        pdf_binary = self.ds.get((0x0042, 0x0011)).value
        pdf_document = pymupdf.open('pdf', pdf_binary)
        png_pages = {}
        for page_number in range(pdf_document.page_count):
            page = pdf_document[page_number]
            pixmap = page.get_pixmap()
            # print(page.get_text())
            image = Image.frombytes("RGB", [pixmap.width, pixmap.height], pixmap.samples)
            buffered = BytesIO()
            image.save(buffered, format="PNG")
            img_str = base64.b64encode(buffered.getvalue()).decode("utf-8")
            png_pages[f'page_{page_number + 1}'] = {
                f'page_html_img_base64':f"data:image/png;base64,{img_str}",
                f'page_PIL':image
            }
        return png_pages


    def parse(self):
        raise NotImplementedError("This should be implemented in a subclass.")
    
    def preview(self, output_path):
        metadata = self.extract_common_metadata()
        with open(os.path.join(output_path, f"{metadata['SOP Instance']}.json"), "w") as file:
            file.write(json.dumps(metadata, indent=4))
        return metadata

    def extract_common_metadata(self):
        """Extract metadata that applies to all DICOMs."""
        return {
            "Manufacturer": self.manufacturer,
            "Model": self.model,
            "Modality": self.modality,
            "Study Date": self.study_date,
            "SOP Class": self.sop_class,
            'SOP Class Description': OPHTHALMOLOGY_SOP_CLASSES[self.sop_class],
            "SOP Instance": self.sop_instance,
        }


### Begin Subclasses by manufacturermodelname ###


class CIRRUS_HD_OCT_5000(DICOMParser):
    """Parser for {
        'manufacturer': 'Carl Zeiss Meditec',
        'manufacturermodelname': 'CIRRUS HD-OCT 5000',
        'modality': 'OP', 'OPT'

        'sopclassuiddescription': 'Ophthalmic Photography 8 Bit Image Storage',
          or 'Encapsulated PDF Storage',
             'Opthalmic Tomography Image Storage',
             'Spatial Registration Storage',
        }
    """

    def parse(self):
        metadata = self.extract_common_metadata()
        if metadata['SOP Class'] == '1.2.840.10008.5.1.4.1.1.77.1.5.1':
            # 'Ophthalmic Photography 8 Bit Image Storage'
            try:
                pixel_array = self.ds.pixel_array
            except Exception as e:
                print("pixel array issue")
                print(repr(e))
            image = Image.fromarray(pixel_array)
            metadata['image_PIL'] = image
            # Laterality
            metadata["Laterality"] = self.ds.get("Laterality", "Unknown")
            # Bits Allocated
            metadata["Bits Allocated"] = self.ds.get("BitsAllocated", "Unknown")
            # Photometric Interpretation
            metadata["Photometric Interpretation"] = self.ds.get("PhotometricInterpretation", "Unknown")
            # Pixel Spacing
            metadata["Pixel Spacing"] = self.ds.get("PixelSpacing", "Unknown")
        elif metadata['SOP Class'] == '1.2.840.10008.5.1.4.1.1.104.1':       
            # 'Encapsulated PDF Storage'     
            metadata['png_pages'] = self.parse_pdf_pages()
        elif metadata['SOP Class'] == '1.2.840.10008.5.1.4.1.1.77.1.5.4':
            # 'Ophthalmic Tomography Image Storage'
            try:
                pixel_array = self.ds.pixel_array
                # pixel_array = np.transpose(pixel_array, (0, 2, 1))  # Now shape is (128, 512, 1024)

            except Exception as e:
                print("pixel array issue")
                print(repr(e))
            bscan_count = pixel_array.shape[0]
            bscan_images = {}
            for i in range(bscan_count):
                bscan_image = Image.fromarray(pixel_array[i, :, :])

                bscan_images[f"bscan{i+1}"] = bscan_image
            metadata['bscan_images'] = bscan_images
            en_face_image = Image.fromarray(np.max(pixel_array, axis=1))  # Collapse the depth axis
            metadata['en_face_image'] = en_face_image

        # Series Description
        metadata["Series Description"] = self.ds.get("SeriesDescription", "Unknown")
        return metadata

    def preview(self, output_path):
        metadata = self.parse()
        # metadata.keys()
        if metadata['SOP Class'] == '1.2.840.10008.5.1.4.1.1.77.1.5.1':
            # pdb.set_trace()
            sop_path = os.path.join(output_path, f"{metadata['SOP Instance']}")
            metadata['image_PIL'].save(os.path.join(output_path, sop_path+".png"))  # To save the image to a file (e.g., PNG format)
        
        elif metadata['SOP Class'] == '1.2.840.10008.5.1.4.1.1.104.1':
            # 'Encapsulated PDF Storage'
            sop_path = os.path.join(output_path, f"{metadata['SOP Instance']}")
            if not os.path.exists(sop_path): os.makedirs(sop_path) # make pdf (png) folder
            for page in metadata['png_pages'].keys():
                metadata['png_pages'][page]['page_PIL'].save(os.path.join(sop_path, f"{page}.png"))
        elif metadata['SOP Class'] == '1.2.840.10008.5.1.4.1.1.77.1.5.4':
            # 'Ophthalmic Tomography Image Storage'
            ## Bscans
            sop_path = os.path.join(output_path, f"{metadata['SOP Instance']}")
            if not os.path.exists(sop_path): os.makedirs(sop_path) # make pdf (png) folder
            for bscan in metadata['bscan_images'].keys():
                metadata['bscan_images'][bscan].save(os.path.join(sop_path, f"{bscan}.png"))
            ## En Face
            metadata['en_face_image'].save(os.path.join(sop_path, f"en_face_from_max_operation_across_bscans.png"))
            
 
        return metadata

# The String is from the ManufacturerModelName field in the DICOM file
DICOMParser.register_parser("CIRRUS HD-OCT 5000", CIRRUS_HD_OCT_5000)



class CIRRUS_HD_OCT_6000(DICOMParser):
    """Parser for {
        'manufacturer': 'Carl Zeiss Meditec',
        'manufacturermodelname': 'CIRRUS HD-OCT 6000',
        'modality': 'OP', 'OPT'

        'sopclassuiddescription': 'Ophthalmic Photography 8 Bit Image Storage',
          or 'Ophthalmic Tomography Image Storage',
             'Encapsulated PDF Storage',
             'Spatial Registration Storage'
        }
    """

    def parse(self):
        metadata = self.extract_common_metadata()
        if metadata['SOP Class'] == '1.2.840.10008.5.1.4.1.1.77.1.5.1':
            # 'Ophthalmic Photography 8 Bit Image Storage'
            try:
                pixel_array = self.ds.pixel_array
            except Exception as e:
                print("pixel array issue")
                print(repr(e))
            image = Image.fromarray(pixel_array)
            metadata['image_PIL'] = image
            # Laterality
            metadata["Laterality"] = self.ds.get("Laterality", "Unknown")
            # Bits Allocated
            metadata["Bits Allocated"] = self.ds.get("BitsAllocated", "Unknown")
            # Photometric Interpretation
            metadata["Photometric Interpretation"] = self.ds.get("PhotometricInterpretation", "Unknown")
            # Pixel Spacing
            metadata["Pixel Spacing"] = self.ds.get("PixelSpacing", "Unknown")
            # Series Description
            metadata["Series Description"] = self.ds.get("SeriesDescription", "Unknown") # will have SFA\GPA



        return metadata

    def preview(self, output_path):
        metadata = self.parse()
        # metadata.keys()
        if metadata['SOP Class'] == '1.2.840.10008.5.1.4.1.1.77.1.5.1':
            # pdb.set_trace()
            sop_path = os.path.join(output_path, f"{metadata['SOP Instance']}")
            metadata['image_PIL'].save(os.path.join(output_path, sop_path+".png"))  # To save the image to a file (e.g., PNG format)
            
        return metadata

# The String is from the ManufacturerModelName field in the DICOM file
DICOMParser.register_parser("CIRRUS HD-OCT 6000", CIRRUS_HD_OCT_6000)


class CLARUS_700(DICOMParser):
    """Parser for {
        'manufacturer': 'Carl Zeiss Meditec',
        'manufacturermodelname': 'CLARUS 700',
        'modality': 'OP',

        'sopclassuiddescription': 'Ophthalmic Photography 8 Bit Image Storage',
        }
    """

    def parse(self):
        metadata = self.extract_common_metadata()
        if metadata['SOP Class'] == '1.2.840.10008.5.1.4.1.1.77.1.5.1':
            # 'Ophthalmic Photography 8 Bit Image Storage'
            try:
                pixel_array = self.ds.pixel_array
            except Exception as e:
                print("pixel array issue")
                print(repr(e))
            # pdb.set_trace()
            arr = pixel_array.astype(np.float32)
            arr[..., 0] = arr[..., 0] + 1.402 * (arr[..., 2] - 128)
            arr[..., 1] = arr[..., 0] - 0.344136 * (arr[..., 1] - 128) - 0.714136 * (arr[..., 2] - 128)
            arr[..., 2] = arr[..., 0] + 1.772 * (arr[..., 1] - 128)
            arr = np.clip(arr, 0, 255).astype(np.uint8)
            image = Image.fromarray(arr)
            metadata['image_PIL'] = image
            # Bits Allocated
            metadata["Bits Allocated"] = self.ds.get("BitsAllocated", "Unknown")
            # Photometric Interpretation
            metadata["Photometric Interpretation"] = f"RGB from {self.ds.get('PhotometricInterpretation', 'Unknown')}" 

        return metadata

    def preview(self, output_path):
        metadata = self.parse()
        # metadata.keys()
        if metadata['SOP Class'] == '1.2.840.10008.5.1.4.1.1.77.1.5.1':
            # pdb.set_trace()
            sop_path = os.path.join(output_path, f"{metadata['SOP Instance']}")
            metadata['image_PIL'].save(os.path.join(output_path, sop_path+".png"))  # To save the image to a file (e.g., PNG format)
              
        return metadata

# The String is from the ManufacturerModelName field in the DICOM file
DICOMParser.register_parser("CLARUS 700", CLARUS_700)


class FORUMGlaucomaWorkplaceParser(DICOMParser):
    """Parser for {
        'manufacturer': 'Carl Zeiss Meditec',
        'manufacturermodelname': 'FORUM Glaucoma Workplace',
        'modality': 'OPV'

        'sopclassuiddescription': 'Encapsulated PDF Storage',
           or 'Ophthalmic Visual Field Static Perimetry Measurements Storage',
        }
    """

    def parse(self):
        metadata = self.extract_common_metadata()
        if metadata['SOP Class'] == '1.2.840.10008.5.1.4.1.1.80.1':
            # 'Ophthalmic Visual Field Static Perimetry Measurements Storage'
            # pdb.set_trace()
            hvf_dicom = File_Utils.read_dicom_from_file(self.dicom_path);
            hvf_obj = Hvf_Object.get_hvf_object_from_dicom(hvf_dicom);
            metadata['HVF Object'] = hvf_obj.serialize_to_json()

        elif metadata['SOP Class'] == '1.2.840.10008.5.1.4.1.1.104.1':            
            metadata['png_pages'] = self.parse_pdf_pages()
        
        # Series Description
        metadata["Series Description"] = self.ds.get("SeriesDescription", "Unknown") # will have SFA\GPA

        return metadata

    def preview(self, output_path):
        metadata = self.parse()
        metadata.keys()
        if metadata['SOP Class'] == '1.2.840.10008.5.1.4.1.1.80.1':
            # pdb.set_trace()
            with open(os.path.join(output_path, f"{metadata['SOP Instance']}.json"), "w") as file:
                sop_path = os.path.join(output_path, f"{metadata['SOP Instance']}.txt")
                File_Utils.write_string_to_file(metadata['HVF Object'], sop_path)
                # file.write(metadata['HVF Object'])
            
        elif metadata['SOP Class'] == '1.2.840.10008.5.1.4.1.1.104.1':
            # 'Encapsulated PDF Storage'
            sop_path = os.path.join(output_path, f"{metadata['SOP Instance']}")
            if not os.path.exists(sop_path): os.makedirs(sop_path) # make pdf (png) folder
            for page in metadata['png_pages'].keys():
                metadata['png_pages'][page]['page_PIL'].save(os.path.join(sop_path, f"{page}.png"))

        return metadata

# The String is from the ManufacturerModelName field in the DICOM file
DICOMParser.register_parser("FORUM Glaucoma Workplace", FORUMGlaucomaWorkplaceParser)



class Humphrey_Field_Analyzer_3(DICOMParser):
    """Parser for {
        'manufacturer': 'Carl Zeiss Meditec',
        'manufacturermodelname': 'Humphrey Field Analyzer 3',
        'modality': 'OP',

        'sopclassuiddescription': 'Ophthalmic Photography 8 Bit Image Storage',
        }
    """

    def parse(self):
        metadata = self.extract_common_metadata()
        if metadata['SOP Class'] == '1.2.840.10008.5.1.4.1.1.77.1.5.1':
            # Dictionary to accumulate sum and count for each (x, y) coordinate
            coord_value_map = defaultdict(lambda: {
                "raw_sum": 0, "abs_sum": 0, "pattern_sum": 0, "abs_perc_sum": 0, "pattern_perc_sum": 0,
                "count": 0
            })
            # pdb.set_trace()
            # Iterate over perimetry test points
            for frame_data in self.ds[(0x0303, 0x1010)].value:
                def get_value(tag, default=np.nan):
                    """Safely get a DICOM tag value, returning NaN if missing."""
                    elem = frame_data.get(tag)
                    return elem.value if elem is not None else default

                x = get_value((0x0303, 0x1013))  # X Coordinate
                y = get_value((0x0303, 0x1014))  # Y Coordinate
                raw_value = get_value((0x0303, 0x1017))  # Raw Threshold Sensitivity (dB)
                abs_value = get_value((0x0303, 0x101d))  # Absolute Value (if available)
                pattern_value = get_value((0x0303, 0x101e))  # Pattern Deviation
                abs_perc = get_value((0x0303, 0x101a))  # Absolute Percentile
                pattern_perc = get_value((0x0303, 0x101c))  # Pattern Percentile

                # Accumulate sum and count for each (x, y) coordinate
                coord_value_map[(x, y)]["raw_sum"] += raw_value
                coord_value_map[(x, y)]["abs_sum"] += abs_value
                coord_value_map[(x, y)]["pattern_sum"] += pattern_value
                coord_value_map[(x, y)]["abs_perc_sum"] += abs_perc
                coord_value_map[(x, y)]["pattern_perc_sum"] += pattern_perc
                coord_value_map[(x, y)]["count"] += 1  # Track number of occurrences

            # Compute averaged values
            unique_x_coords, unique_y_coords = [], []
            unique_raw_values, unique_abs_values = [], []
            unique_pattern_values, unique_abs_percentile, unique_pattern_percentile = [], [], []

            for (x, y), data in coord_value_map.items():
                count = data["count"]

                unique_x_coords.append(x)
                unique_y_coords.append(y)
                unique_raw_values.append(data["raw_sum"]) # / count)
                unique_abs_values.append(data["abs_sum"]) # / count)
                unique_pattern_values.append(data["pattern_sum"]) # / count)
                unique_abs_percentile.append(data["abs_perc_sum"] / count)
                unique_pattern_percentile.append(data["pattern_perc_sum"] / count)

            # Convert to numpy arrays
            unique_x_coords = np.array(unique_x_coords)
            unique_y_coords = np.array(unique_y_coords)
            unique_raw_values = np.nan_to_num(np.array(unique_raw_values, dtype=np.float64), nan=0)
            unique_abs_values = np.nan_to_num(np.array(unique_abs_values, dtype=np.float64), nan=0)
            unique_pattern_values = np.nan_to_num(np.array(unique_pattern_values, dtype=np.float64), nan=0)
            unique_abs_percentile = np.nan_to_num(np.array(unique_abs_percentile, dtype=np.float64), nan=0)
            unique_pattern_percentile = np.nan_to_num(np.array(unique_pattern_percentile, dtype=np.float64), nan=0)

            # Plot setup: 3 rows, 2 columns (first row spans both columns)
            fig, axes = plt.subplots(3, 2, figsize=(12, 16), gridspec_kw={'height_ratios': [1.5, 1, 1]})
            fig.subplots_adjust(hspace=0.4, wspace=0.3)

            # Function to plot text annotations
            def plot_text(ax, values, title):
                ax.scatter(unique_x_coords, unique_y_coords, color="gray", s=1, alpha=0.1)  # Faint reference points
                for x, y, val in zip(unique_x_coords, unique_y_coords, values):
                    ax.text(x, y, f"{int(val)}", fontsize=10, ha='center', va='bottom', fontweight='bold')
                ax.set_xlabel("X Coordinate (Visual Field)")
                ax.set_ylabel("Y Coordinate (Visual Field)")
                ax.set_title(title)
                ax.set_xticks([])
                ax.set_yticks([])
                ax.grid(True, linestyle='--', alpha=0.5)

            # First row (full width)
            plot_text(axes[0, 0], unique_raw_values, "Raw Threshold Sensitivity (dB)")
            axes[0, 1].axis("off")  # Disable the second subplot in the first row

            # Second row
            plot_text(axes[1, 0], unique_abs_values, "Absolute Values")
            plot_text(axes[1, 1], unique_pattern_values, "Pattern Deviation")

            # Third row
            plot_text(axes[2, 0], unique_abs_percentile, "Absolute Percentile")
            plot_text(axes[2, 1], unique_pattern_percentile, "Pattern Percentile")

            # plt.savefig(".....09.png")
            # Convert plot to a PIL Image
            buf = BytesIO()
            plt.savefig(buf, format="PNG", bbox_inches='tight', pad_inches=0.1)
            plt.close(fig)
            buf.seek(0)
            image = Image.open(buf)  # Convert buffer into a PIL image
            # Extract perimetry data from private tags
            # 'Ophthalmic Photography 8 Bit Image Storage'
            # try:
            #     pixel_array = self.ds.pixel_array
            # except Exception as e:
            #     print("pixel array issue")
            #     print(repr(e))
            # image = Image.fromarray(pixel_array[1, :, :])  # First frame of 252...this might be even more raw
            metadata['image_PIL'] = image
            # pdb.set_trace()
            self.ds.get("SeriesDescription", "Unknown")
            # Number of Frames
            metadata["Number of Frames"] = self.ds.get("NumberOfFrames", "Unknown")
            # Laterality
            metadata["Laterality"] = self.ds.get("Laterality", "Unknown")
            # Bits Allocated
            metadata["Bits Allocated"] = self.ds.get("BitsAllocated", "Unknown")
            # Photometric Interpretation
            metadata["Photometric Interpretation"] = self.ds.get("PhotometricInterpretation", "Unknown")

        return metadata

    def preview(self, output_path):
        metadata = self.parse()
        # metadata.keys()
        if metadata['SOP Class'] == '1.2.840.10008.5.1.4.1.1.77.1.5.1':
            # pdb.set_trace()
            sop_path = os.path.join(output_path, f"{metadata['SOP Instance']}")
            metadata['image_PIL'].save(os.path.join(output_path, sop_path+".png"))  # To save the image to a file (e.g., PNG format)
            
        return metadata

# The String is from the ManufacturerModelName field in the DICOM file
DICOMParser.register_parser("Humphrey Field Analyzer 3", Humphrey_Field_Analyzer_3)


class IOLMaster_700(DICOMParser):
    """Parser for {
        'manufacturer': 'Carl Zeiss Meditec',
        'manufacturermodelname': 'IOLMaster 700',
        'modality': 'OP', ['IOL', 'KER', 'OAM'] - these still need to be developed
           

        'sopclassuiddescription': 'Ophthalmic Photography 8 Bit Image Storage',
           or ['Keratometry Measurements Storage',
               'Multi-frame True Color Secondary Capture Image Storage',
               'Encapsulated PDF Storage',
               'Ophthalmic Axial Measurements Storage',
               'Intraocular Lens Calculations Storage'] - these still need to be developed
        }
    """

    def parse(self):
        metadata = self.extract_common_metadata()
        if metadata['SOP Class'] == '1.2.840.10008.5.1.4.1.1.77.1.5.1':
            # 'Ophthalmic Photography 8 Bit Image Storage'
            try:
                pixel_array = self.ds.pixel_array
            except Exception as e:
                print("pixel array issue")
                print(repr(e))
            image = Image.fromarray(pixel_array)
            metadata['image_PIL'] = image
            # Bits Allocated
            metadata["Bits Allocated"] = self.ds.get("BitsAllocated", "Unknown")
            # Photometric Interpretation
            metadata["Photometric Interpretation"] = self.ds.get("PhotometricInterpretation", "Unknown")
            # Pixel Spacing
            metadata["Pixel Spacing"] = self.ds.get("PixelSpacing", "Unknown")
            
        return metadata

    def preview(self, output_path):
        metadata = self.parse()
        # metadata.keys()
        if metadata['SOP Class'] == '1.2.840.10008.5.1.4.1.1.77.1.5.1':
            # pdb.set_trace()
            sop_path = os.path.join(output_path, f"{metadata['SOP Instance']}")
            metadata['image_PIL'].save(os.path.join(output_path, sop_path+".png"))  # To save the image to a file (e.g., PNG format)
            
        return metadata

# The String is from the ManufacturerModelName field in the DICOM file
DICOMParser.register_parser("IOLMaster 700", IOLMaster_700)