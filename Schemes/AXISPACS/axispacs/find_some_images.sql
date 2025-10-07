SELECT
file_path,
SOPClassDescription,
Manufacturer,
ManufacturerModelName,
PhotometricInterpretation,
SeriesDescription
FROM axispacs.all_dicoms
WHERE qtim_modality_pred = 'OCT Bscan Vol' or qtim_modality_pred = 'Cube'

-- WHERE SOPClassDescription = 'Ophthalmic Tomography Image Storage'
--   AND (Manufacturer = 'OPTOS')
--   AND (ManufacturerModelName = 'P200TxE')
--   AND PhotometricInterpretation = 'MONOCHROME2'
--   AND (SeriesDescription = 'OCT Retina')
  
  limit 10000;