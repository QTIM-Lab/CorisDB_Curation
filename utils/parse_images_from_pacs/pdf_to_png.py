import pymupdf  # PyMuPDF
from PIL import Image, ImageDraw, ImageFont
import os, pdb

def pdf_to_png(pdf_path, output_folder, key_fields, FONT_DIR =  os.path.join( os.path.expanduser("~"), '/coris_db/utils/Roboto/Roboto-Black.ttf')):
    # Create the output folder if it doesn't exist
    if not os.path.exists(output_folder):
        os.makedirs(output_folder)
    
    pdf_document = pymupdf.open(pdf_path)
    
    for page_number in range(pdf_document.page_count):
        page = pdf_document[page_number]
        pixmap = page.get_pixmap()
        print(page.get_text())
        image = Image.frombytes("RGB", [pixmap.width, pixmap.height], pixmap.samples)
        # # Draw key_fields
        # draw = ImageDraw.Draw(image) # Initialize the drawing context
        # # Choose a font and size
        # font = ImageFont.truetype(FONT_DIR, 10)
        # # Choose the color of the text (RGB format)
        # text_color = 255  # white or red (sometimes single channel is just red)
        # pdb.set_trace()
        ## text_color = "white"  # White color
        # Write the text onto the image
        # draw.text((0, 0), key_fields['patient'], fill=text_color, font=font)
        # draw.text((0, 25), key_fields['modality'], fill=text_color, font=font)
        # draw.text((0, 50), key_fields['sop_class_uid'], fill=text_color, font=font)
        # draw.text((0, 75), key_fields['sop_class_desc'], fill=text_color, font=font)
        # draw.text((0, 100), key_fields['study_instance_uid'], fill=text_color, font=font)
        # draw.text((0, 125), key_fields['series_instance_uid'], fill=text_color, font=font)
        # draw.text((0, 150), key_fields['sop_instance_uid'], fill=text_color, font=font)
        # pdb.set_trace()
        image_path = os.path.join(output_folder, f"page_{page_number + 1}.png")

        image.save(image_path, "PNG")
        
    pdf_document.close()
