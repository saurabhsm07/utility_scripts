# Image to PDF Converter

This Python script converts all image files in a specified folder into a single PDF document. It supports various image formats, including PNG, JPG, JPEG, TIFF, BMP, and GIF. The resulting PDF is saved in a user-defined location.

## Features

- **Multi-Format Support**: Converts images from multiple formats into a single PDF.
- **Automatic Sorting**: Sorts images by name before conversion (can be adjusted).
- **RGB Conversion**: Converts images to RGB mode for PDF compatibility.
- **User-Friendly**: Simple command-line interface for easy usage.

## Requirements

- **Python**: Make sure you have Python installed. This script is compatible with Python 3.x.
- **Pillow Library**: The script uses the Pillow library for image processing. You can install it using pip:

   ```bash
   pip install Pillow
   ```

## Usage

### Command-Line Arguments

- `<image_folder>`: **Required.** Specify the path to the folder containing image files to be converted.
- `<output_pdf_path>`: **Required.** Specify the desired output path and filename for the resulting PDF.

### Example Command

To convert images in a folder named `images` to a PDF named `output.pdf`, run the following command:

```bash
python script.py images output.pdf
```

**Example Output**:
```bash
PDF saved successfully to output.pdf
```

### Error Handling

- If the script is run without the required arguments, it will display a usage message:

```bash
Usage: python script.py <image_folder> <output_pdf_path>
```

- If no valid image files are found in the specified folder, the script will inform you:

```bash
No images found in the folder.
```

## How It Works

1. **Input Validation**: The script checks the command-line arguments to ensure that the user provides the necessary inputs.

2. **Image Collection**: It lists all image files in the specified folder that match the supported formats (PNG, JPG, JPEG, TIFF, BMP, GIF).

3. **Sorting**: The collected image files are sorted by name. You can modify this behavior by changing the sorting logic in the script if a different order is required.

4. **Image Processing**: The images are opened and converted to RGB mode to ensure compatibility when creating the PDF.

5. **PDF Creation**: If valid images are found, the script saves them as a single PDF document at the specified output path. If no images are found, a message is printed to inform the user.

## Example

Here’s a quick example demonstrating how to use the script:

1. Create a folder named `images` and place some images in it.
2. Run the following command to convert the images to a PDF named `my_images.pdf`:

   ```bash
   python script.py images/my_images.pdf
   ```

3. After execution, check the specified output path for the resulting PDF file.

## Conclusion

This script provides a straightforward method for converting multiple images into a single PDF document, making it ideal for creating photo albums, document archives, or any collection of images you wish to compile into one file.
