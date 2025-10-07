import os
from exif import Image
from PIL import Image as p_Image

with open("/data/PACS/VisupacImages/26........................e5f58.j2k", 'rb') as image_file:
    my_image = Image(image_file)


img = p_Image.open(os.path.join("/data/PACS/VisupacImages/26........................e5f58.j2k"))

dir(img)


# Random internet sample image
with open("/projects/coris_db/postgres/queries_and_stats/queries/Glaucoma/fundus_09_19_2023/ZeissZX1.jpg", 'rb') as image_file:
    my_image = Image(image_file)




print(my_image.list_all())

imgs = ["/data/PACS/VisupacImages/26........................e5f58.j2k",
"/data/PACS/VisupacImages/26..............................j2k",
"/data/PACS/VisupacImages/26..............................j2k",
"/data/PACS/VisupacImages/26..............................j2k",
"/data/PACS/VisupacImages/26..............................j2k",
"/data/PACS/VisupacImages/26..............................j2k"]
