import os, snowflake.connector, pandas as pd, pdb

from dotenv import load_dotenv
load_dotenv()

USERNAME=os.getenv('USERNAME')
PASSWORD=os.getenv('PASSWORD')
ACCOUNT=os.getenv('ACCOUNT')
WAREHOUSE=os.getenv('WAREHOUSE')
DATABASE=os.getenv('DATABASE')
SCHEMA=os.getenv('SCHEMA')
DATA_DIR=os.getenv('DATA_DIR')

devices_header=['DEVSRNO','DEVTYPE','DEVVER','DEVNAME','DEVPROC','DEVDESCRITION','DEVRENDER','DEVICON','USRSRNO','DEVTIMESTAMP','TMSTAMP','DEVCONFIG','DICOMAETITLE','DICOMREPORTS','DEVGUID']
exams_header=['EXSRNO','EXID','EXDEVTYPE','PTSRNO','EXDATETIME','EXWHICHEYE','EXPRIDX','EXSECDX','EXOPERATOR','EXATTENDINGMD','EXREFERINGMD','EXDICTATED','LCSRNO','EXNOTE','USRSRNO','EXTIMESTAMP','EXOPERATOR1','EXATTENDINGMD1','EXREFERINGMD1','TMSTAMP','EXISSTUDY','EXDEVPROC','DICOMSTUDYACCESSIONNUMBER','DICOMMODALITIESINSTUDY','DICOMSTUDYID','DICOMREQUESTINGPHYSICIAN','DICOMSTUDYINSTANCEUID','UPLOADTIMESTAMP','DICOMSTUDYDATETIME']
files_header=['FILESRNO','EXSRNO','FILEPATH','FILENAME','FILEPATHNEW','FILENAMENEW','FILENOTE','FILETYPE','FILERENDER','USRSRNO','TMSTAMP','FILEVALID','FILEUP','FILEUPDTTM','FILETAG','FILETMSTMP','FILEINDEX','FILEEYE','FILEDATA','DICOMTAG','DICOMTAGINDEX','DICOMSTUDYUID','DICOMSERIESUID','DICOMSERIESDATETIME','DICOMSERIESNUMBER','DICOMSERIESDESCRIPTION','DICOMMODALITY','DICOMSTUDYID','DICOMSOPINSTANCEUID','DICOMREFERENCESOPINSTANCEUID','STORESRNO','DICOMDOCUMENTTITLE','DICOMACQUISITIONDATETIME','DICOMIMAGETYPE']
patients_header=['PTSRNO','PTID','PTFNAME','PTMNAME','PTLNAME','PTSEX','PTDOB','PTSSN','PTADD1','PTADD2','PTCITY','PTSTATE','PTZIP','PTCOUNTRY','PTPHONE1','PTPHONE2','PTEMAIL','PTWEB','USRSRNO','PTTIMESTAMP','TMSTAMP','PTVALIDSTAT','PTVALIDUSER','PTVALIDDATETIME','DICOMPATIENTNAME']
store_header=['SRNO','PATH','ISCURRENT,', 'TYPE','TMSTAMP']

tables = [
('devices', devices_header),
('exams', exams_header),
('files', files_header),
('patients', patients_header),
('store', store_header)]

def get_data(table, header=[], nrows=10, low=None, high=None):
    """ 
    * nrows == -1 is for all rows
    * nrows == -1 is for all rows
      - paired with low and high for ranges
      - if high == -1, grab everything above low
    """
    conn = snowflake.connector.connect(
        user=USERNAME,
        password=PASSWORD,
        account=ACCOUNT,
        warehouse=WAREHOUSE,
        database=DATABASE,
        schema=SCHEMA
        )
    cursor = conn.cursor()
    query = f"SELECT * FROM {table} limit {nrows};"
    # pdb.set_trace()
    if nrows == -1:
        query = f"SELECT * FROM {table}"
        if table == 'files':
            query = f"SELECT * FROM {table} where FILESRNO >= {low} and FILESRNO <= {high} order by FILESRNO ASC;"
            if high == -1:
                query = f"SELECT * FROM {table} where FILESRNO >= {low} order by FILESRNO ASC;"
    print(query)
    cursor.execute(query)
    results = cursor.fetchall()
    table_df = pd.DataFrame(results, columns=header)
    table_df.head()
    # Close the cursor and connection
    cursor.close()
    conn.close()
    return table_df


# Get Data
## Devices
devices_df = get_data(table=tables[0][0], header=tables[0][1], nrows=-1)
## Exams
exams_df = get_data(table=tables[1][0], header=tables[1][1], nrows=-1)

## Files
# Test
files_df_100 = get_data(table=tables[2][0], header=tables[2][1], nrows=100)
# files_df_1_100 = get_data(table=tables[2][0], header=tables[2][1], nrows=-1, low=1, high=100)
# files_df_101_200 = get_data(table=tables[2][0], header=tables[2][1], nrows=-1, low=101, high=200)

files_df_1_1000000 = get_data(table=tables[2][0], header=tables[2][1], nrows=-1, low=1, high=1000000)
files_df_1000001_2000000 = get_data(table=tables[2][0], header=tables[2][1], nrows=-1, low=1000001, high=2000000)
files_df_2000001_3000000 = get_data(table=tables[2][0], header=tables[2][1], nrows=-1, low=2000001, high=3000000)
files_df_3000001_4000000 = get_data(table=tables[2][0], header=tables[2][1], nrows=-1, low=3000001, high=4000000)
files_df_4000001_5000000 = get_data(table=tables[2][0], header=tables[2][1], nrows=-1, low=4000001, high=5000000)
files_df_5000001_6000000 = get_data(table=tables[2][0], header=tables[2][1], nrows=-1, low=5000001, high=6000000)
files_df_6000001_7000000 = get_data(table=tables[2][0], header=tables[2][1], nrows=-1, low=6000001, high=7000000)
files_df_7000001_8000000 = get_data(table=tables[2][0], header=tables[2][1], nrows=-1, low=7000001, high=8000000)
files_df_8000001_9000000 = get_data(table=tables[2][0], header=tables[2][1], nrows=-1, low=8000001, high=9000000)
files_df_9000001_10000000 = get_data(table=tables[2][0], header=tables[2][1], nrows=-1, low=9000001, high=10000000)
files_df_10000001_ = get_data(table=tables[2][0], header=tables[2][1], nrows=-1, low=10000001, high=-1)

## Patients
patients_df = get_data(table=tables[3][0], header=tables[3][1], nrows=-1)
## Store
store_df = get_data(table=tables[4][0], header=tables[4][1], nrows=-1)

# Write It
## Devices
devices_df.to_csv(os.path.join(DATA_DIR,"devices.csv"), index=None)
## Exams
exams_df.to_csv(os.path.join(DATA_DIR,"exams.csv"), index=None)

## Files
### Test
files_df_100.to_csv(os.path.join(DATA_DIR,"files.csv"), index=None)
# files_df_1_100.to_csv(os.path.join(DATA_DIR,"files.csv"), index=None)
# files_df_101_200.to_csv(os.path.join(DATA_DIR,"files.csv"), index=None, mode='a', header=None) # append to previous file

# Note the mode="a" for all but first write
files_df_1_1000000.to_csv(os.path.join(DATA_DIR,"files.csv"), index=None)
files_df_1000001_2000000.to_csv(os.path.join(DATA_DIR,"files.csv"), index=None, mode='a', header=None)
files_df_2000001_3000000.to_csv(os.path.join(DATA_DIR,"files.csv"), index=None, mode='a', header=None)
files_df_3000001_4000000.to_csv(os.path.join(DATA_DIR,"files.csv"), index=None, mode='a', header=None)
files_df_4000001_5000000.to_csv(os.path.join(DATA_DIR,"files.csv"), index=None, mode='a', header=None)
files_df_5000001_6000000.to_csv(os.path.join(DATA_DIR,"files.csv"), index=None, mode='a', header=None)
files_df_6000001_7000000.to_csv(os.path.join(DATA_DIR,"files.csv"), index=None, mode='a', header=None)
files_df_7000001_8000000.to_csv(os.path.join(DATA_DIR,"files.csv"), index=None, mode='a', header=None)
files_df_8000001_9000000.to_csv(os.path.join(DATA_DIR,"files.csv"), index=None, mode='a', header=None)
files_df_9000001_10000000.to_csv(os.path.join(DATA_DIR,"files.csv"), index=None, mode='a', header=None)
files_df_10000001_.to_csv(os.path.join(DATA_DIR,"files.csv"), index=None, mode='a', header=None)

# split out files
files_df_1_1000000.to_csv(os.path.join(DATA_DIR,"files_1_1000000.csv"), index=None)
files_df_1000001_2000000.to_csv(os.path.join(DATA_DIR,"files_1000001_2000000.csv"), index=None, header=None)
files_df_2000001_3000000.to_csv(os.path.join(DATA_DIR,"files_2000001_3000000.csv"), index=None, header=None)
files_df_3000001_4000000.to_csv(os.path.join(DATA_DIR,"files_3000001_4000000.csv"), index=None, header=None)
files_df_4000001_5000000.to_csv(os.path.join(DATA_DIR,"files_4000001_5000000.csv"), index=None, header=None)
files_df_5000001_6000000.to_csv(os.path.join(DATA_DIR,"files_5000001_6000000.csv"), index=None, header=None)
files_df_6000001_7000000.to_csv(os.path.join(DATA_DIR,"files_6000001_7000000.csv"), index=None, header=None)
files_df_7000001_8000000.to_csv(os.path.join(DATA_DIR,"files_7000001_8000000.csv"), index=None, header=None)
files_df_8000001_9000000.to_csv(os.path.join(DATA_DIR,"files_8000001_9000000.csv"), index=None, header=None)
files_df_9000001_10000000.to_csv(os.path.join(DATA_DIR,"files_9000001_10000000.csv"), index=None, header=None)
files_df_10000001_.to_csv(os.path.join(DATA_DIR,"files_10000001_.csv"), index=None, header=None)

### Read a little for import
files_1000 = pd.read_csv(os.path.join(DATA_DIR,"files.csv"), nrows=1000)
files_1000.to_csv(os.path.join(DATA_DIR,"files_1_1000.csv"), index=None, header=None)


## Patients
patients_df.to_csv(os.path.join(DATA_DIR,"patinets.csv"), index=None)
## Store
store_df.to_csv(os.path.join(DATA_DIR,"store.csv"), index=None)


