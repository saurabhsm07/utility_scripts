import sys
import os
from PIL import Image

def convert_images_to_pdf(image_folder, output_pdf_path):
    # List all image files in the folder
    image_files = [f for f in os.listdir(image_folder) if f.endswith(('png', 'jpg', 'jpeg', 'tiff', 'bmp', 'gif'))]

    # Sort the image files by name (you can adjust this if you need a different order)
    image_files.sort()

    # Open the images and convert them to RGB mode
    images = [Image.open(os.path.join(image_folder, file)).convert('RGB') for file in image_files]

    # Save the images as a single PDF file
    if images:
        images[0].save(output_pdf_path, save_all=True, append_images=images[1:])
        print(f"PDF saved successfully to {output_pdf_path}")
    else:
        print("No images found in the folder.")

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python script.py <image_folder> <output_pdf_path>")
    else:
        image_folder = sys.argv[1]
        output_pdf_path = sys.argv[2]
        convert_images_to_pdf(image_folder, output_pdf_path)

