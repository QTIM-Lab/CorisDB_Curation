DROP VIEW IF EXISTS forum.cirrus_oct;
CREATE OR REPLACE VIEW forum.cirrus_oct AS
    -- SELECT *
    -- SELECT count(*)
    SELECT
    a.file_path,
    a.mrn,
    a.studyinstanceuid,
    a.seriesinstanceuid,
    a.sopinstanceuid,
    t.qtim_modality, -- holy grail
    a.modality,
    a.studydate,
    a.seriesnumber,
    a.instancenumber,
    a.acquisitiondatetime,
    a.sopclassuid,
    a.sopdescription,
    a.imagetype,
    a.mimetypeofencapsulatedocument,
    a.institutionname,
    a.manufacturer,
    a.manufacturermodelname,
    a.laterality,
    a.perframefunctionalgroupssequence,
    a.bitsallocated,
    a.photometricinterpretation,
    a.pixelspacing,
    a.stationname,
    a.seriesdescription,
    a.studytime,
    a.doctype,
    a.averagernflthickness_micrometers,
    a.opticcupvolume_mm_squared,
    a.opticdiskarea_mm_squared,
    a.rimarea_mm_squared,
    a.avgcdr,
    a.verticalcd
    -- FROM forum.all_dicoms as a inner join forum.dicom_image_types as t on
    FROM forum.all_dicoms as a inner join forum.dicom_image_types as t on
    a.sopdescription = t.sopclassdescription AND 
    a.modality = t.modality AND 
    a.manufacturer = t.manufacturer AND 
    a.manufacturermodelname = t.manufacturermodelname AND 
    a.photometricinterpretation = t.photometricinterpretation AND 
    a.seriesdescription = t.seriesdescription
    WHERE
    (t.sopclassdescription='Ophthalmic Photography 8 Bit Image Storage' AND t.modality='OP' AND t.manufacturer='Carl Zeiss Meditec' AND t.manufacturermodelname='CIRRUS HD-OCT 5000' AND t.photometricinterpretation='MONOCHROME2' AND t.seriesdescription='Macular Cube 512x128') OR 
    (t.sopclassdescription='Ophthalmic Tomography Image Storage' AND t.modality='OPT' AND t.manufacturer='Carl Zeiss Meditec' AND t.manufacturermodelname='CIRRUS HD-OCT 5000' AND t.photometricinterpretation='MONOCHROME2' AND t.seriesdescription='Macular Cube 512x128') OR 
    (t.sopclassdescription='Ophthalmic Tomography Image Storage' AND t.modality='OPT' AND t.manufacturer='Carl Zeiss Meditec' AND t.manufacturermodelname='CIRRUS HD-OCT 6000' AND t.photometricinterpretation='MONOCHROME2' AND t.seriesdescription='Macular Cube 512x128') OR 
    (t.sopclassdescription='Ophthalmic Photography 8 Bit Image Storage' AND t.modality='OP' AND t.manufacturer='Carl Zeiss Meditec' AND t.manufacturermodelname='CIRRUS HD-OCT 6000' AND t.photometricinterpretation='MONOCHROME2' AND t.seriesdescription='Macular Cube 512x128') OR 
    (t.sopclassdescription='Ophthalmic Tomography Image Storage' AND t.modality='OPT' AND t.manufacturer='Carl Zeiss Meditec' AND t.manufacturermodelname='CIRRUS HD-OCT 5000' AND t.photometricinterpretation='MONOCHROME2' AND t.seriesdescription='RASTER_21_LINES') OR 
    (t.sopclassdescription='Ophthalmic Photography 8 Bit Image Storage' AND t.modality='OP' AND t.manufacturer='Carl Zeiss Meditec' AND t.manufacturermodelname='CIRRUS HD-OCT 5000' AND t.photometricinterpretation='MONOCHROME2' AND t.seriesdescription='RASTER_21_LINES') OR 
    (t.sopclassdescription='Ophthalmic Tomography Image Storage' AND t.modality='OPT' AND t.manufacturer='Carl Zeiss Meditec' AND t.manufacturermodelname='CIRRUS HD-OCT 5000' AND t.photometricinterpretation='MONOCHROME2' AND t.seriesdescription='HD 5 Line Raster') OR 
    (t.sopclassdescription='Ophthalmic Photography 8 Bit Image Storage' AND t.modality='OP' AND t.manufacturer='Carl Zeiss Meditec' AND t.manufacturermodelname='CIRRUS HD-OCT 5000' AND t.photometricinterpretation='MONOCHROME2' AND t.seriesdescription='HD 5 Line Raster') OR 
    (t.sopclassdescription='Ophthalmic Tomography Image Storage' AND t.modality='OPT' AND t.manufacturer='Carl Zeiss Meditec' AND t.manufacturermodelname='CIRRUS HD-OCT 5000' AND t.photometricinterpretation='MONOCHROME2' AND t.seriesdescription='5 Line Raster') OR 
    (t.sopclassdescription='Ophthalmic Photography 8 Bit Image Storage' AND t.modality='OP' AND t.manufacturer='Carl Zeiss Meditec' AND t.manufacturermodelname='CIRRUS HD-OCT 5000' AND t.photometricinterpretation='MONOCHROME2' AND t.seriesdescription='5 Line Raster') OR 
    (t.sopclassdescription='Ophthalmic Photography 8 Bit Image Storage' AND t.modality='OP' AND t.manufacturer='Carl Zeiss Meditec' AND t.manufacturermodelname='CIRRUS HD-OCT 5000' AND t.photometricinterpretation='MONOCHROME2' AND t.seriesdescription='Macular Cube 200x200') OR 
    (t.sopclassdescription='Ophthalmic Tomography Image Storage' AND t.modality='OPT' AND t.manufacturer='Carl Zeiss Meditec' AND t.manufacturermodelname='CIRRUS HD-OCT 5000' AND t.photometricinterpretation='MONOCHROME2' AND t.seriesdescription='Macular Cube 200x200') OR 
    (t.sopclassdescription='Ophthalmic Tomography Image Storage' AND t.modality='OPT' AND t.manufacturer='Carl Zeiss Meditec' AND t.manufacturermodelname='CIRRUS HD-OCT 6000' AND t.photometricinterpretation='MONOCHROME2' AND t.seriesdescription='HD 5 Line Raster') OR 
    (t.sopclassdescription='Ophthalmic Photography 8 Bit Image Storage' AND t.modality='OP' AND t.manufacturer='Carl Zeiss Meditec' AND t.manufacturermodelname='CIRRUS HD-OCT 6000' AND t.photometricinterpretation='MONOCHROME2' AND t.seriesdescription='HD 5 Line Raster') OR 
    (t.sopclassdescription='Ophthalmic Photography 8 Bit Image Storage' AND t.modality='OP' AND t.manufacturer='Carl Zeiss Meditec' AND t.manufacturermodelname='CIRRUS HD-OCT 4000' AND t.photometricinterpretation='MONOCHROME2' AND t.seriesdescription='Macular Cube 512x128') OR 
    (t.sopclassdescription='Ophthalmic Tomography Image Storage' AND t.modality='OPT' AND t.manufacturer='Carl Zeiss Meditec' AND t.manufacturermodelname='CIRRUS HD-OCT 4000' AND t.photometricinterpretation='MONOCHROME2' AND t.seriesdescription='Macular Cube 512x128') OR 
    (t.sopclassdescription='Ophthalmic Photography 8 Bit Image Storage' AND t.modality='OP' AND t.manufacturer='Carl Zeiss Meditec' AND t.manufacturermodelname='CIRRUS HD-OCT 4000' AND t.photometricinterpretation='MONOCHROME2' AND t.seriesdescription='HD 5 Line Raster') OR 
    (t.sopclassdescription='Ophthalmic Tomography Image Storage' AND t.modality='OPT' AND t.manufacturer='Carl Zeiss Meditec' AND t.manufacturermodelname='CIRRUS HD-OCT 4000' AND t.photometricinterpretation='MONOCHROME2' AND t.seriesdescription='HD 5 Line Raster') OR 
    (t.sopclassdescription='Ophthalmic Tomography Image Storage' AND t.modality='OPT' AND t.manufacturer='Carl Zeiss Meditec' AND t.manufacturermodelname='CIRRUS HD-OCT 6000' AND t.photometricinterpretation='MONOCHROME2' AND t.seriesdescription='RASTER_21_LINES') OR 
    (t.sopclassdescription='Ophthalmic Photography 8 Bit Image Storage' AND t.modality='OP' AND t.manufacturer='Carl Zeiss Meditec' AND t.manufacturermodelname='CIRRUS HD-OCT 6000' AND t.photometricinterpretation='MONOCHROME2' AND t.seriesdescription='RASTER_21_LINES') OR 
    (t.sopclassdescription='Ophthalmic Tomography Image Storage' AND t.modality='OPT' AND t.manufacturer='Carl Zeiss Meditec' AND t.manufacturermodelname='CIRRUS HD-OCT 5000' AND t.photometricinterpretation='MONOCHROME2' AND t.seriesdescription='RASTER_RADIAL') OR 
    (t.sopclassdescription='Ophthalmic Photography 8 Bit Image Storage' AND t.modality='OP' AND t.manufacturer='Carl Zeiss Meditec' AND t.manufacturermodelname='CIRRUS HD-OCT 5000' AND t.photometricinterpretation='MONOCHROME2' AND t.seriesdescription='RASTER_RADIAL') OR 
    (t.sopclassdescription='Ophthalmic Photography 8 Bit Image Storage' AND t.modality='OP' AND t.manufacturer='Carl Zeiss Meditec' AND t.manufacturermodelname='CIRRUS HD-OCT 5000' AND t.photometricinterpretation='MONOCHROME2' AND t.seriesdescription='') OR 
    (t.sopclassdescription='Ophthalmic Tomography Image Storage' AND t.modality='OPT' AND t.manufacturer='Carl Zeiss Meditec' AND t.manufacturermodelname='CIRRUS HD-OCT 5000' AND t.photometricinterpretation='MONOCHROME2' AND t.seriesdescription='') OR 
    (t.sopclassdescription='Ophthalmic Tomography Image Storage' AND t.modality='OPT' AND t.manufacturer='Carl Zeiss Meditec' AND t.manufacturermodelname='CIRRUS HD-OCT 5000' AND t.photometricinterpretation='MONOCHROME2' AND t.seriesdescription='RASTER_SINGLE') OR 
    (t.sopclassdescription='Ophthalmic Photography 8 Bit Image Storage' AND t.modality='OP' AND t.manufacturer='Carl Zeiss Meditec' AND t.manufacturermodelname='CIRRUS HD-OCT 5000' AND t.photometricinterpretation='MONOCHROME2' AND t.seriesdescription='RASTER_SINGLE') OR 
    (t.sopclassdescription='Ophthalmic Photography 8 Bit Image Storage' AND t.modality='OP' AND t.manufacturer='Carl Zeiss Meditec' AND t.manufacturermodelname='CIRRUS HD-OCT 6000' AND t.photometricinterpretation='MONOCHROME2' AND t.seriesdescription='Macular Cube 200x200') OR 
    (t.sopclassdescription='Ophthalmic Tomography Image Storage' AND t.modality='OPT' AND t.manufacturer='Carl Zeiss Meditec' AND t.manufacturermodelname='CIRRUS HD-OCT 6000' AND t.photometricinterpretation='MONOCHROME2' AND t.seriesdescription='Macular Cube 200x200') OR 
    (t.sopclassdescription='Ophthalmic Tomography Image Storage' AND t.modality='OPT' AND t.manufacturer='Carl Zeiss Meditec' AND t.manufacturermodelname='CIRRUS HD-OCT 4000' AND t.photometricinterpretation='MONOCHROME2' AND t.seriesdescription='') OR 
    (t.sopclassdescription='Ophthalmic Photography 8 Bit Image Storage' AND t.modality='OP' AND t.manufacturer='Carl Zeiss Meditec' AND t.manufacturermodelname='CIRRUS HD-OCT 4000' AND t.photometricinterpretation='MONOCHROME2' AND t.seriesdescription='') OR 
    (t.sopclassdescription='Ophthalmic Tomography Image Storage' AND t.modality='OPT' AND t.manufacturer='Carl Zeiss Meditec' AND t.manufacturermodelname='CIRRUS HD-OCT 5000' AND t.photometricinterpretation='MONOCHROME2' AND t.seriesdescription='RASTER_GRID') OR 
    (t.sopclassdescription='Ophthalmic Photography 8 Bit Image Storage' AND t.modality='OP' AND t.manufacturer='Carl Zeiss Meditec' AND t.manufacturermodelname='CIRRUS HD-OCT 5000' AND t.photometricinterpretation='MONOCHROME2' AND t.seriesdescription='RASTER_GRID') OR 
    (t.sopclassdescription='Ophthalmic Photography 8 Bit Image Storage' AND t.modality='OP' AND t.manufacturer='Carl Zeiss Meditec' AND t.manufacturermodelname='CIRRUS HD-OCT 4000' AND t.photometricinterpretation='MONOCHROME2' AND t.seriesdescription='Macular Cube 200x200') OR 
    (t.sopclassdescription='Ophthalmic Tomography Image Storage' AND t.modality='OPT' AND t.manufacturer='Carl Zeiss Meditec' AND t.manufacturermodelname='CIRRUS HD-OCT 4000' AND t.photometricinterpretation='MONOCHROME2' AND t.seriesdescription='Macular Cube 200x200') OR 
    (t.sopclassdescription='Ophthalmic Tomography Image Storage' AND t.modality='OPT' AND t.manufacturer='Carl Zeiss Meditec' AND t.manufacturermodelname='CIRRUS HD-OCT 4000' AND t.photometricinterpretation='MONOCHROME2' AND t.seriesdescription='5 Line Raster') OR 
    (t.sopclassdescription='Ophthalmic Photography 8 Bit Image Storage' AND t.modality='OP' AND t.manufacturer='Carl Zeiss Meditec' AND t.manufacturermodelname='CIRRUS HD-OCT 4000' AND t.photometricinterpretation='MONOCHROME2' AND t.seriesdescription='5 Line Raster') OR 
    (t.sopclassdescription='Ophthalmic Photography 8 Bit Image Storage' AND t.modality='OP' AND t.manufacturer='Carl Zeiss Meditec' AND t.manufacturermodelname='CIRRUS HD-OCT 6000' AND t.photometricinterpretation='MONOCHROME2' AND t.seriesdescription='RASTER_SINGLE') OR 
    (t.sopclassdescription='Ophthalmic Tomography Image Storage' AND t.modality='OPT' AND t.manufacturer='Carl Zeiss Meditec' AND t.manufacturermodelname='CIRRUS HD-OCT 6000' AND t.photometricinterpretation='MONOCHROME2' AND t.seriesdescription='RASTER_SINGLE')
    -- limit 1;

-- select count (*) from cirrus_oct
-- select * from forum.cirrus_oct
-- where qtim_modality like 'OCT%' and qtim_modality not like 'OCT Bscan Vol 128'
-- order by qtim_modality
-- limit 1000;

-- select * from forum.cirrus_oct
-- where file_path like '%1.2.276.0.75.2.2.42.50122019542.20210715081507559.2676572530.2.dcm%'
-- limit 1000;


-- select file_path from forum.cirrus_oct;