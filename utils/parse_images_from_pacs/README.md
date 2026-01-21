# Convert PACS images to PNG or other human readable format

## DICOMParser (New)
```bash
pyenv deactivate
pyenv activate corisdb_curation
# poetry install
cd utils/parse_images_from_pacs
git clone https://github.com/msaifee786/hvf_extraction_script.git
pip install hvf_extraction_script

python opvs.py
```


## Preview (old)

```bash
$IN=
$OUT=
python preview.py $IN $OUT
```


## J2K Parser
> preview.py has code that is replaced by DICOM Parser below for dicoms

```python
import os, pandas as pd
from preview import preview

all_files_preview = pd.read_csv("/scratch90/QTIM/Active/23-0284/EHR/AXISPACS/col_counts/all_files_preview.csv")

OUT = "/scratch90/QTIM/Active/23-0284/EHR/AXISPACS/col_counts"

for IN in all_files_preview['file_path']:
    preview(IN, OUT)
```

## DICOM Parser
```python
import os, pandas as pd, pdb                                                                                                                                                  
from DICOMParser import DICOMParser                                                                                                                                                                                                                                                                                                                     

# base_path = "/scratch90/QTIM/Active/23-0284/EHR/AXISPACS/col_counts/dicoms_preview.csv"                                                                                       

base_path = "/scratch90/QTIM/Active/23-0284/EHR/FORUM/col_counts/dicoms_preview.csv"                                                                                       
                                                                                                                                                                                
df = pd.read_csv(os.path.join(base_path))                                                                                                                                     
df.columns    

# dicom_file = df.iloc[10]

# dicom_group = df[
#     ((df['Manufacturer'] == 'OPTOS')) & \
#     ((df['ManufacturerModelName'] == 'Montage Generator') ) & \
#     ((df['PhotometricInterpretation'] == 'MONOCHROME2') | (pd.isna(df['PhotometricInterpretation']))) & \
#     ((df['SeriesDescription'] == 'Blackford Montage') | (pd.isna(df['SeriesDescription'])))
# ]
# dicom_group = df[
#     ((df['SOPClassDescription'] == 'Ophthalmic Tomography Image Storage')) & \
#     # ((df['SOPClassDescription'] == '') | (pd.isna(df['SOPClassDescription']))) & \

#     # ((df['Manufacturer'] == 'NIL Screenshot')) & \
#     ((df['Manufacturer'] == 'OPTOS') | (pd.isna(df['Manufacturer']))) & \

#     # ((df['ManufacturerModelName'] == '')) & \
#     ((df['ManufacturerModelName'] == 'P200TxE') | (pd.isna(df['ManufacturerModelName']))) & \

#     ((df['PhotometricInterpretation'] == 'MONOCHROME2')) & \
#     # ((df['PhotometricInterpretation'] == '') | (pd.isna(df['PhotometricInterpretation']))) & \

#     # ((df['SeriesDescription'] == ''))
#     ((df['SeriesDescription'] == 'UWF Navigated OCT Line') | (pd.isna(df['SeriesDescription'])))
# ]

dicom_group = df[
    ((df['sopclassdescription'] == 'Ophthalmic Tomography Image Storage')) & \
    # ((df['sopclassdescription'] == '') | (pd.isna(df['sopclassdescription']))) & \

    # ((df['manufacturer'] == 'NIL Screenshot')) & \
    ((df['manufacturer'] == 'OPTOS') | (pd.isna(df['manufacturer']))) & \

    # ((df['manufacturermodelname'] == '')) & \
    ((df['manufacturermodelname'] == 'P200TxE') | (pd.isna(df['manufacturermodelname']))) & \

    ((df['photometricinterpretation'] == 'MONOCHROME2')) & \
    # ((df['photometricinterpretation'] == '') | (pd.isna(df['photometricinterpretation']))) & \

    # ((df['seriesdescription'] == ''))
    ((df['seriesdescription'] == 'UWF Navigated OCT Line') | (pd.isna(df['seriesdescription'])))
]

# dicom_group[['SOPClassDescription','Manufacturer','ManufacturerModelName','PhotometricInterpretation','SeriesDescription']]
dicom_group[['sopclassdescription','manufacturer','manufacturermodelname','photometricinterpretation','seriesdescription']]

dicom_file = dicom_group.iloc[0]
dicom_file = dicom_group.iloc[1]
dicom_file = dicom_group.iloc[2]

parser = DICOMParser.create_parser(dicom_file['file_path'])
# parser.parse()
# parser.ds.ManufacturerModelName
# keys_of_interest = ['Manufacturer', 'Patient ID', 'Model', 'Modality', 'Study Date', 'SOP Class', 'SOP Class Description', 'SOP Instance']
# # keys_of_interest = ['Manufacturer', 'Patient ID', 'Model', 'Modality', 'Study Date', 'SOP Class', 'SOP Class Description', 'SOP Instance', 'Series Description']
# {key:parser.parse()[key] for key in keys_of_interest}
parser.preview('/scratch90/QTIM/Active/23-0284/EHR/AXISPACS/col_counts/dicoms', write_dicom_header=True)


# batch
for row in df.iterrows():
    # pdb.set_trace()
    parser = DICOMParser.create_parser(row[1]['file_path'])
    parser.preview('/scratch90/QTIM/Active/23-0284/EHR/AXISPACS/col_counts/dicoms', write_dicom_header=True)


    
```