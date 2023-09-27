# DCMTK:
# dcm2xml [options] dcmfile-in [xmlfile-out]
# dcmdump +sd <dicom_file> > output.bin
# xsltproc [options] stylesheet file [file ...]


# devname = 'HFA3 (x3)'
# devtype = 'VF'
# devdescription = 'Visual Fields'

dcmfilein=
xmlfileout=
binfileout=

dcm2xml $dcmfilein $xmlfileout
dcmdump +sd $dcmfilein > $binfileout


# Seve's Images (OPV)
dcmfileinL=
dcmfileinR=

xmlfileoutL=
xmlfileoutR=

dcm2xml $dcmfileinL $xmlfileoutL
dcm2xml $dcmfileinR $xmlfileoutR

sqlfileoutL=
sqlfileoutR=

xsltproc -o $sqlfileoutL stylesheet file $xmlfileoutL