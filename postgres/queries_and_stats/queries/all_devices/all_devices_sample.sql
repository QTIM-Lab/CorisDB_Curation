
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 1 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 1 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 2 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 2 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 15 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 15 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 4 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 4 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 5 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 5 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 6 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 6 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 7 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 7 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 8 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 8 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 9 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 9 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 10 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 10 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 12 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 12 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 13 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 13 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 14 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 14 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 16 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 16 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 17 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 17 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 18 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 18 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 19 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 19 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 20 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 20 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 21 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 21 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 22 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 22 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 23 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 23 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 24 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 24 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 25 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 25 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 26 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 26 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 27 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 27 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 28 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 28 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 29 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 29 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 30 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 30 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 31 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 31 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 32 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 32 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 33 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 33 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 34 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 34 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 36 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 36 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 37 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 37 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 38 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 38 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 39 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 39 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 40 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 40 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 41 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 41 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 42 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 42 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 43 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 43 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 44 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 44 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 46 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 46 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 47 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 47 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 48 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 48 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 50 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 50 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 51 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 51 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 52 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 52 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 53 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 53 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 54 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 54 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 55 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 55 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 58 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 58 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 59 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 59 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 60 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 60 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 61 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 61 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 62 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 62 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 64 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 64 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 65 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 65 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 66 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 66 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 67 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 67 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 68 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 68 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 69 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 69 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 70 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 70 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 71 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 71 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 73 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 73 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 35 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 35 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 45 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 45 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 49 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 49 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 63 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 63 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 72 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 72 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 74 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 74 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 75 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 75 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 76 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 76 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 77 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 77 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 78 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 78 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 79 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 79 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 80 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 80 and file_path_coris like '%.j2k%'
    limit 1)
    

UNION ALL
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 81 and file_path_coris like '%.dcm%'
    limit 1)
    
    UNION ALL -- dcm and j2k for each device
    
    (select
    file_path_coris ,exdevtype ,exsrno ,ptsrno ,devname ,devdescription ,devtype ,devproc ,dicomaetitle ,devsrno from axispacs_snowflake.file_paths_and_meta
    where devsrno = 81 and file_path_coris like '%.j2k%'
    limit 1)
    

