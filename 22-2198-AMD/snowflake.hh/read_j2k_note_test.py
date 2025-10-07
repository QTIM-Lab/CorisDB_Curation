import glymur
from PIL import Image
import numpy as np

# Path to the input .j2k file
input_path = "/persist/PACS/VisupacImages/23651/120457/AxisUCH01_23651_120457_2016051814465283652dccf264bb57449.j2k"
output_path = "read_j2k_note_testing.png"

# Read the JPEG 2000 image using Glymur
jp2 = glymur.Jp2k(input_path)
image_array = jp2[:]

# Convert to PIL Image and save as PNG
image = Image.fromarray(image_array)
image.save(output_path)

print(f"Image saved to {output_path}")
