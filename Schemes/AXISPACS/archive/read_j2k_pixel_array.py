import glymur
from PIL import Image
import numpy as np

# Path to the input .j2k file
input_path = "/persist/PACS/DICOM/100092/718776/1.2.276.0.75.2.5.80.25.3.240605132230996.345051330900.448986017-1.j2k"
output_path = "read_j2k.png"

# Read the JPEG 2000 image using Glymur
jp2 = glymur.Jp2k(input_path)
image_array = jp2[:]

# Convert to PIL Image and save as PNG
image = Image.fromarray(image_array)
image.save(output_path)

print(f"Image saved to {output_path}")
