import os
import pandas as pd
from typing import Iterable

AXISPACS_DIR='/scratch90/QTIM/Active/23-0284/EHR/AXISPACS/'


# Columns used to define the combination

# DICOMs
KEY_COLS_DICOMS = [
    "SOPClassDescription",
    "Modality",
    "Manufacturer",
    "ManufacturerModelName",
    "PhotometricInterpretation",
    "SeriesDescription",
]

# J2Ks
KEY_COLS_J2KS = [
    "ImageType",
    "ParsedImageGroup",
    "ReportType",
    "Layer_Name",
    "Procedure",
    "ScanPattern"
]

def _norm(x):
    """Normalize strings: strip, lowercase; None -> empty string."""
    if pd.isna(x):
        return ""
    return str(x).strip().lower()

def make_key_row(row: pd.Series, cols: Iterable[str]) -> tuple:
    return tuple(_norm(row[c]) for c in cols)

def make_key_df(df: pd.DataFrame, cols: Iterable[str]) -> pd.Series:
    """Vectorized key builder that returns a Series of tuple keys."""
    return df.apply(lambda row: make_key_row(row, cols), axis=1)


# --- 1) Build the mapping dict from your labeled CSV ---
labels_dicom = pd.read_csv("/scratch90/QTIM/Active/23-0284/EHR/AXISPACS/col_counts/axispacs_image_types_dicom_manually_curated.csv")  # your table
labels_j2k = pd.read_csv("/scratch90/QTIM/Active/23-0284/EHR/AXISPACS/col_counts/axispacs_image_types_j2k_manually_curated.csv")  # your table
labels_dicom["key"] = make_key_df(labels_dicom, KEY_COLS_DICOMS)
labels_j2k["key"] = make_key_df(labels_j2k, KEY_COLS_J2KS)



# If there are duplicates with conflicting labels_dicom, surface them now:
dupes_dicom = labels_dicom.groupby("key")["QTIM_Modality"].nunique()
conflicts = dupes_dicom[dupes_dicom > 1]
if not conflicts.empty:
    print("Warning: conflicting labels_dicom for some keys:")
    print(labels_dicom[labels_dicom["key"].isin(conflicts.index)]
          .sort_values("key")[KEY_COLS_DICOMS + ["QTIM_Modality"]])

# If there are duplicates with conflicting labels_j2k, surface them now:
dupes_j2k = labels_j2k.groupby("key")["QTIM_Modality"].nunique()
conflicts = dupes_j2k[dupes_j2k > 1]
if not conflicts.empty:
    print("Warning: conflicting labels_j2k for some keys:")
    print(labels_j2k[labels_j2k["key"].isin(conflicts.index)]
          .sort_values("key")[KEY_COLS_J2KS + ["QTIM_Modality"]])




# Build the lookup_dicom dict (last-win or drop duplicates if needed)
# Safer: drop exact duplicate (key, label) rows first
labels_unique_dicom = labels_dicom.drop_duplicates(subset=["key", "QTIM_Modality"])
# If multiple labels remain for same key, keep the most frequent in your labeled table:
labels_unique_dicom = (
    labels_unique_dicom
    .assign(freq=labels_dicom.groupby("key")["key"].transform("count"))
    .sort_values(["key", "freq"], ascending=[True, False])
    .drop_duplicates(subset=["key"], keep="first")
)
lookup_dicom = dict(zip(labels_unique_dicom["key"], labels_unique_dicom["QTIM_Modality"]))

# Build the lookup_j2k dict (last-win or drop duplicates if needed)
# Safer: drop exact duplicate (key, label) rows first
labels_unique_j2k = labels_j2k.drop_duplicates(subset=["key", "QTIM_Modality"])
# If multiple labels remain for same key, keep the most frequent in your labeled table:
labels_unique_j2k = (
    labels_unique_j2k
    .assign(freq=labels_j2k.groupby("key")["key"].transform("count"))
    .sort_values(["key", "freq"], ascending=[True, False])
    .drop_duplicates(subset=["key"], keep="first")
)
lookup_j2k = dict(zip(labels_unique_j2k["key"], labels_unique_j2k["QTIM_Modality"]))



# --- 2) Classify new data by joining on the key (fast & vectorized) ---
def classify_dataframe(df_new: pd.DataFrame, KEY_COLS: Iterable[str], lookup: dict) -> pd.DataFrame:
    df_new = df_new.copy()
    df_new["key"] = make_key_df(df_new, KEY_COLS)
    df_new["QTIM_Modality_pred"] = df_new["key"].map(lookup)
    # Optionally flag unknowns
    df_new["is_unknown_combo"] = df_new["QTIM_Modality_pred"].isna()
    return df_new.drop(columns=["key"])




#
all_dicoms = pd.read_csv(os.path.join(AXISPACS_DIR, 'all_dicoms.csv')) # , nrows=1000)

all_dicom_classified = classify_dataframe(all_dicoms, KEY_COLS_DICOMS, lookup_dicom)
all_dicom_classified.to_csv("/scratch90/QTIM/Active/23-0284/EHR/AXISPACS/all_dicom_classified.csv", index=False)

del(all_dicoms) # free memory
del(all_dicom_classified) # free memory

#
all_j2ks = pd.read_csv(os.path.join(AXISPACS_DIR, 'all_j2ks.csv')) # , nrows=1000)
all_j2k_classified = classify_dataframe(all_j2ks, KEY_COLS_DICOMS, lookup_j2k)
all_j2k_classified.to_csv("/scratch90/QTIM/Active/23-0284/EHR/AXISPACS/all_j2k_classified.csv", index=False)


del(all_j2ks) # free memory
del(all_j2k_classified) # free memory

#
all_files = pd.read_csv(os.path.join(AXISPACS_DIR, 'all_files.csv')) # , nrows=1000)
all_files_dicom = all_files[all_files['file_path'].str.lower().str.find('.dcm') != -1]
all_files_j2k = all_files[all_files['file_path'].str.lower().str.find('.j2k') != -1]


all_files_dicom.shape[0] + all_files_j2k.shape[0] == all_files.shape[0]
del(all_files) # free memory

all_files_dicom_classified = classify_dataframe(all_files_dicom, KEY_COLS_DICOMS, lookup_dicom)
all_files_j2k_classified = classify_dataframe(all_files_j2k, KEY_COLS_DICOMS, lookup_j2k)

del(all_files_dicom) # free memory
del(all_files_j2k) # free memory

all_files_classified = pd.concat([all_files_dicom_classified, all_files_j2k_classified], axis=0)
all_files_classified.to_csv("/scratch90/QTIM/Active/23-0284/EHR/AXISPACS/all_files_classified.csv", index=False)

del(all_files_dicom_classified) # free memory
del(all_files_j2k_classified) # free memory
