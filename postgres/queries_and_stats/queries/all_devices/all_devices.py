import os, pandas, pdb

devices = [1,2,15,4,5,6,7,8,9,10,12,13,14,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,36,37,38,39,40,41,42,43,44,46,47,48,50,51,52,53,54,55,58,59,60,61,62,64,65,66,67,68,69,70,71,73,35,45,49,63,72,74,75,76,77,78,79,80,81]

all_query = ""
for devsrno in devices:
    query = f"""
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = {devsrno} and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = {devsrno} and file_path_coris like '%.j2k%'
    limit 1)
    """
    union_str = "UNION ALL" # joining devices queries together
    if devsrno != 81:
        all_query += query +"\n\n"+ union_str
    else:
        all_query += query +"\n\n"


with open(os.path.join("/projects/coris_db/postgres/queries_and_stats/queries/all_devices","all_devices_sample.sql"), 'w') as file:
    file.write(all_query)
    
    

print(all_query)
