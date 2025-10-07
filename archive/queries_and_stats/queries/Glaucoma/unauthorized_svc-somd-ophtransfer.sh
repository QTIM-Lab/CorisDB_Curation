# Where
SVC_DIR=/home/svc-somd-ophtransfer
VisupacImagesSLCE="/data/PACS"

ls $SVC_DIR
echo $SVC_DIR

docker run -it --rm \
    -v $SVC_DIR:$SVC_DIR \
    -v $VisupacImagesSLCE/DICOM:$VisupacImagesSLCE/DICOM \
    -e SVC_DIR=$SVC_DIR \
    -e VisupacImagesSLCE=$VisupacImagesSLCE \
    ubuntu:latest bash

# Once in
ls $SVC_DIR
ls $SVC_DIR/snap/snapd-desktop-integration/common # nothing really here
ls $SVC_DIR/logs

ls $SVC_DIR/mnt/VisupacImages
ls $SVC_DIR/dest/VisupacImages | wc -l
ls $SVC_DIR/dest/VisupacImages/DICOM

ls $SVC_DIR/mnt/VisupacImages/DICOM

\\uch.ad.pvt\apps\VisupacImages\23......\1......7\AxisUCH01_23..............j2k
\\uch.ad.pvt\apps\VisupacImages\23......\1......7\{.....}.j2k

ls $SVC_DIR/mnt/VisupacImages/99/522768

find $SVC_DIR/dest/DICOM -name "AxisUCH...........................ae2.j2k"

ls $VisupacImagesSLCE/forum/2021/1/11/.........................10.2.dcm

find $VisupacImagesSLCE/DICOM -name "........................25717.9.dcm"
/data/PACS/DICOM/38749/270667/........................25717.9.dcm

/data/PACS/DICOM/<Exam or Patients Table - PAT_PTSRNO or PTSRNO respectively>/<Exam Table - EXSRNO Col>/<FILENAMENEW>
/data/PACS/DICOM/<PTSRNO>/<EXSRNO>/<FILENAMENEW>
