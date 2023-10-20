# https://pypi.org/project/orthanc-api-client/
# https://github.com/orthanc-team/python-orthanc-api-client

import os, pandas as pd

os.chdir(os.path.join('postgres','dashboard'))

from dotenv import load_dotenv
load_dotenv()


DNS=os.environ.get('DNS', 'localhost')
PORT=os.environ.get('PORT', '8042')
USERNAME=os.environ.get('USERNAME', '')
PASSWORD=os.environ.get('PASSWORD', '')
OUT_PATH=os.environ.get('OUT_PATH', '')

from orthanc_api_client import (
    OrthancApiClient,
    ResourceType,
    InstancesSet
)
import datetime

# Check connection
OrthancApiClient
orthanc = OrthancApiClient(f'http://{DNS}:{PORT}', user=f'{USERNAME}', pwd=f'{PASSWORD}')
orthanc = OrthancApiClient(f'http://{USERNAME}:{PASSWORD}@{DNS}:{PORT}')

# orthanc.is_alive() True


# Upload files/folders

# orthanc.upload_folder('/home/o/files', ignore_errors=True)
# instances_ids = orthanc.upload_file('/home/o/files/a.dcm')
# instances_ids = orthanc.upload_file('/home/o/files/a.zip')

# list all resources ids
all_patients_ids = orthanc.patients.get_all_ids()
all_studies_ids = orthanc.studies.get_all_ids()
all_series_ids = orthanc.series.get_all_ids()
all_instances_ids = orthanc.instances.get_all_ids()

dashboard_orthanc_ids = pd.DataFrame()
for instance_id in all_instances_ids:
    instance = orthanc.instances.get(instance_id)
    tags = instance.tags
    record = {'orthanc_id': [instance.orthanc_id],
            'PatientID': [tags['PatientID']],
            'StudyInstanceUID': [tags['StudyInstanceUID']],
            'SeriesInstanceUID': [tags['SeriesInstanceUID']],
            'SOPInstanceUID': [tags['SOPInstanceUID']],
            }

    record_frame = pd.DataFrame(record)
    dashboard_orthanc_ids = pd.concat([dashboard_orthanc_ids, record_frame])

dashboard_orthanc_ids.to_csv(os.path.join(OUT_PATH,"dashboard_orthanc_ids.csv"), index=False)
