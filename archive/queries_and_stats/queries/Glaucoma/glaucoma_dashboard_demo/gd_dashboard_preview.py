import os, pandas as pd, pydicom, pdb, numpy, json
from PIL import Image, ImageDraw, ImageFont
from PyPDF2 import PdfReader

os.chdir("/projects/coris_db/postgres/queries_and_stats/queries/Glaucoma/glaucoma_dashboard_demo")
os.getcwd()
from pdf_to_png import pdf_to_png

IN_Cirrus_OCT="/projects/coris_db/postgres/queries_and_stats/queries/Glaucoma/glaucoma_dashboard_demo/preview/raw/Cirrus_OCT"
IN_HFA2x="/projects/coris_db/postgres/queries_and_stats/queries/Glaucoma/glaucoma_dashboard_demo/preview/raw/HFA2x"
IN_HFA3x="/projects/coris_db/postgres/queries_and_stats/queries/Glaucoma/glaucoma_dashboard_demo/preview/raw/HFA3x"
IN_NonMyd="/projects/coris_db/postgres/queries_and_stats/queries/Glaucoma/glaucoma_dashboard_demo/preview/raw/NonMyd"

OUT_Cirrus_OCT="/projects/coris_db/postgres/queries_and_stats/queries/Glaucoma/glaucoma_dashboard_demo/preview/out/Cirrus_OCT"
OUT_HFA2x="/projects/coris_db/postgres/queries_and_stats/queries/Glaucoma/glaucoma_dashboard_demo/preview/out/HFA2x"
OUT_HFA3x="/projects/coris_db/postgres/queries_and_stats/queries/Glaucoma/glaucoma_dashboard_demo/preview/out/HFA3x"
OUT_NonMyd="/projects/coris_db/postgres/queries_and_stats/queries/Glaucoma/glaucoma_dashboard_demo/preview/out/NonMyd"

FONT_DIR="/projects/coris_db/postgres/queries_and_stats/queries/all_devices/Roboto/Roboto-Black.ttf"

file_names_Cirrus_OCT = ['preview/raw/Cirrus_OCT/'+i for i in list(os.listdir(IN_Cirrus_OCT))]
file_names_HFA2x = ['preview/raw/HFA2x/'+i for i in list(os.listdir(IN_HFA2x))]
file_names_HFA3x = ['preview/raw/HFA3x/'+i for i in list(os.listdir(IN_HFA3x))]
file_names_NonMyd = ['preview/raw/NonMyd/'+i for i in list(os.listdir(IN_NonMyd))]

def preview(file_names, IN, OUT):
    for file_path in file_names:
    # for file_path in file_names_HFA2x:
    # for file_path in file_names_HFA3x:
    # for file_path in file_names_NonMyd:
        print(file_path)
        if file_path.find('.dcm') != -1:
            try:
                ds = pydicom.dcmread(os.path.join(os.getcwd(), file_path))
            except:
                pdb.set_trace()
            # Tags
            patient=ds.get((0x0010, 0x0020)).value
            modality=ds.get((0x0008, 0x0060)).value
            sop_class_uid=ds.get((0x0008, 0x0016)).value
            sop_class_desc=str(ds.get((0x0008, 0x0016))).split("UI:")[-1].strip()
            study_instance_uid=ds.get((0x0020, 0x000d)).value
            series_instance_uid=ds.get((0x0020, 0x000e)).value
            sop_instance_uid=ds.get((0x0008, 0x0018)).value
            # pdb.set_trace()
            if sop_class_desc == "Ophthalmic Photography 8 Bit Image Storage" or sop_class_desc == "Secondary Capture Image Storage":
                # Extract pixel data
                # pixel_data = ds.pixel_array
                try:
                    pixel_array = ds.pixel_array
                except Exception as e:
                    print("pixel array issue")
                    pdb.set_trace()
                    print(repr(e))
                # pixel_data = ds.PixelData
                # pdb.set_trace()
                # Create a Pillow image from the pixel data
                image = Image.fromarray(pixel_array)
                draw = ImageDraw.Draw(image) # Initialize the drawing context
                # Choose a font and size
                font = ImageFont.truetype(FONT_DIR, 50)
                # Define sop_class_desc text
                patient_text = f"patient_text: {patient}"
                modality_text = f"modality_text: {modality}"
                sop_class_uid_text = f"sop_class_uid_text: {sop_class_uid}"
                sop_class_desc_text = f"sop_class_desc_text: {sop_class_desc}"
                study_instance_uid_text = f"study_instance_uid_text: {study_instance_uid}"
                series_instance_uid_text = f"series_instance_uid_text: {series_instance_uid}"
                sop_instance_uid_text = f"sop_instance_uid_text: {sop_instance_uid}"
                # Choose the color of the text (RGB format)
                text_color = 255  # white or red (sometimes single channel is just red)
                if not isinstance(ds.pixel_array.shape, tuple):
                    print("isinstance")
                    pdb.set_trace()
                    if ds.pixel_array.shape[2] == 3:
                        text_color = (255, 255, 255)  # White color
                ## text_color = "white"  # White color
                # Write the text onto the image
                draw.text((0, 0), patient_text, fill=text_color, font=font)
                draw.text((0, 100), modality_text, fill=text_color, font=font)
                draw.text((0, 200), sop_class_uid_text, fill=text_color, font=font)
                draw.text((0, 300), sop_class_desc_text, fill=text_color, font=font)
                draw.text((0, 400), study_instance_uid_text, fill=text_color, font=font)
                draw.text((0, 500), series_instance_uid_text, fill=text_color, font=font)
                draw.text((0, 600), sop_instance_uid_text, fill=text_color, font=font)
                ## image.show()
                image.save(os.path.join(OUT, os.path.splitext(os.path.basename(file_path))[0]+".png"))  # To save the image to a file (e.g., PNG format)
            elif sop_class_desc == "Encapsulated PDF Storage":
                output_folder = os.path.join(OUT,"pdf_"+os.path.splitext(os.path.basename(file_path))[0])
                pdf_file = os.path.join(output_folder, os.path.splitext(os.path.basename(file_path))[0]+".pdf")
                if not os.path.exists(output_folder): os.makedirs(output_folder) # make pdf folder
                with open(pdf_file, "wb") as file: file.write(ds.get((0x0042, 0x0011)).value) # Encapsulated Document
                key_fields={'patient':ds.get((0x0010, 0x0020)).value,
                    'modality':ds.get((0x0008, 0x0060)).value,
                    'sop_class_uid':ds.get((0x0008, 0x0016)).value,
                    'sop_class_desc':str(ds.get((0x0008, 0x0016))).split("UI:")[-1].strip(),
                    'study_instance_uid':ds.get((0x0020, 0x000d)).value,
                    'series_instance_uid':ds.get((0x0020, 0x000e)).value,
                    'sop_instance_uid':ds.get((0x0008, 0x0018)).value}
                # pdb.set_trace()
                pdf_to_png(pdf_file, output_folder, key_fields=key_fields)
            elif sop_class_desc == "Grayscale Softcopy Presentation State Storage":
                # with open(os.path.join(OUT,"dcm_header_json"+os.path.splitext(os.path.basename(file_path))[0]+".json"), "w") as file:
                #     dicom_header_json = json.loads(ds.to_json())
                #     file.write(json.dumps(dicom_header_json, indent=4))
                # pdb.set_trace()
                with open(os.path.join(OUT,"dcm_print_header_"+os.path.splitext(os.path.basename(file_path))[0]+".txt"), "w") as file: file.write(str(ds))
            else:
                pdb.set_trace()
                print("NOT Ophthalmic Photography 8 Bit Image Storage \nor \nSecondary Capture Image Storage \nor \nEncapsulated PDF Storage!")
                ds.get((0x0010, 0x0020)).value # patient
                ds.get((0x0008, 0x0060)).value # modality
                ds.get((0x0008, 0x0016)).value # sop_class_uid
                str(ds.get((0x0008, 0x0016))).split("UI:")[-1].strip() # sop_class_desc
                ds.get((0x0020, 0x000d)).value # study_instance_uid
                ds.get((0x0020, 0x000e)).value # series_instance_uid
                ds.get((0x0008, 0x0018)).value # sop_instance_uid
                # ds.pixel_array
        elif file_path.find('.j2k') != -1: # J2K
            try:
                # pdb.set_trace()
                image = Image.open(os.path.join(os.getcwd(), file_path))
            except:
                print(f"missing {file_path}")
                # pdb.set_trace()
                pass
            ## pdb.set_trace()
            ## row = all_devices_1_each[all_devices_1_each['file_path_coris'] == file_path]
            # Initialize the drawing context
            draw = ImageDraw.Draw(image)
            # Choose a font and size
            ## font = ImageFont.truetype(FONT_DIR, 50)
            ## Define sop_class_desc text       
            ## exdevtype_text = f"exdevtype: {row['exdevtype'].iloc[0]}"
            ## exsrno_text = f"exsrno: {row['exsrno'].iloc[0]}"
            ## ptsrno_text = f"ptsrno: {row['ptsrno'].iloc[0]}"
            ## devname_text = f"devname: {row['devname'].iloc[0]}"
            ## devdescription_text = f"devdescription: {row['devdescription'].iloc[0]}"
            ## devtype_text = f"devtype: {row['devtype'].iloc[0]}"
            ## devproc_text = f"devproc: {row['devproc'].iloc[0]}"
            ## dicomaetitle_text = f"dicomaetitle: {row['dicomaetitle'].iloc[0]}"
            ## devsrno_text = f"devsrno: {row['devsrno'].iloc[0]}"
            # Choose the color of the text (RGB format)
            ## text_color = (255, 255, 255)  # White color
            # text_color = 255  # black and whites
            ## text_color = "white"  # White color
            # Write the text onto the image
            ## draw.text((0, 0), exdevtype_text, fill=text_color, font=font)
            ## draw.text((0, 100), exsrno_text, fill=text_color, font=font)
            ## draw.text((0, 200), ptsrno_text, fill=text_color, font=font)
            ## draw.text((0, 300), devname_text, fill=text_color, font=font)
            ## draw.text((0, 400), devdescription_text, fill=text_color, font=font)
            ## draw.text((0, 500), devtype_text, fill=text_color, font=font)
            ## draw.text((0, 600), devproc_text, fill=text_color, font=font)
            ## draw.text((0, 700), dicomaetitle_text, fill=text_color, font=font)
            ## draw.text((0, 800), devsrno_text, fill=text_color, font=font)
            image.save(os.path.join(OUT, os.path.splitext(os.path.basename(file_path))[0]+".png"))  # To save the image to a file (e.g., PNG format)


preview(file_names_Cirrus_OCT, IN_Cirrus_OCT, OUT_Cirrus_OCT)
preview(file_names_HFA2x, IN_HFA2x, OUT_HFA2x)
preview(file_names_HFA3x, IN_HFA3x, OUT_HFA3x)
preview(file_names_NonMyd, IN_NonMyd, OUT_NonMyd)