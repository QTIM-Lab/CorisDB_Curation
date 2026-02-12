import os
import pandas as pd
from typing import Iterable

TOPCON_OCULOMICS_DIR='/scratch90/QTIM/Active/23-0284/EHR/TOPCON_OCULOMICS/'

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
labels_dicom = pd.read_csv("/scratch90/QTIM/Active/23-0284/EHR/TOPCON_OCULOMICS/col_counts/topcon_image_types_dicom_manually_curated.csv")  # your table
labels_dicom["key"] = make_key_df(labels_dicom, KEY_COLS_DICOMS)



# If there are duplicates with conflicting labels_dicom, surface them now:
dupes_dicom = labels_dicom.groupby("key")["QTIM_Modality"].nunique()
conflicts = dupes_dicom[dupes_dicom > 1]
if not conflicts.empty:
    print("Warning: conflicting labels_dicom for some keys:")
    print(labels_dicom[labels_dicom["key"].isin(conflicts.index)]
          .sort_values("key")[KEY_COLS_DICOMS + ["QTIM_Modality"]])



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


# --- 2) Classify new data by joining on the key (fast & vectorized) ---
def classify_dataframe(df_new: pd.DataFrame, KEY_COLS: Iterable[str], lookup: dict) -> pd.DataFrame:
    df_new = df_new.copy()
    df_new["key"] = make_key_df(df_new, KEY_COLS)
    df_new["QTIM_Modality_pred"] = df_new["key"].map(lookup)
    # Optionally flag unknowns if somehow we don't find our lookup in the labels_dicom which becomes lookup_dicom
    df_new["is_unknown_combo"] = df_new["QTIM_Modality_pred"].isna()
    return df_new.drop(columns=["key"])



#
all_dicoms = pd.read_csv(os.path.join(TOPCON_OCULOMICS_DIR, 'parsed', 'topcon_oculomics_parse_dicom_for_postgres.csv')) # , nrows=1000)

all_dicom_classified = classify_dataframe(all_dicoms, KEY_COLS_DICOMS, lookup_dicom)
all_dicom_classified.to_csv(os.path.join(TOPCON_OCULOMICS_DIR, 'parsed', 'topcon_oculomics_parse_dicom_for_postgres_classified.csv'), index=False)

del(all_dicoms) # free memory
del(all_dicom_classified) # free memory