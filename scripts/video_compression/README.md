# Video Compression Script

This script compresses all video files within a specified input folder using `FFmpeg`, allowing for flexible resolution scaling and format conversion. It processes video files across different formats and stores the compressed outputs in the designated folder, while also offering an option to automate the process or pause for user input.

## Features

- **Resolution Scaling:** Compresses video files to a specified resolution (default: `1420x1080`).
- **Video Format Conversion:** Converts all videos to `.mp4` format, regardless of the original format.
- **User Control:** Option to manually confirm each file's processing or run the script in an automated mode.
- **File Status Tracking:** Keeps track of the processing status (`todo`, `in-progress`, `success`, `failed`, or `skipped`) for each file.
- **Automation Mode:** Option to automatically process files without user confirmation.
  
## Requirements

- **FFmpeg:** Ensure `FFmpeg` is installed and available in your system's path. You can install it via:
   ```bash
   sudo apt-get install ffmpeg
   ```
   or refer to [FFmpeg's official documentation](https://ffmpeg.org/download.html) for other platforms.

## Usage

### Command-Line Arguments

- `--input <source_folder>`: **Required.** Specify the folder containing the video files you want to compress.
- `--output <destination_folder>`: **Required.** Specify the folder where the compressed files will be saved.
- `--automated <1/0>`: **Optional.** Specify `1` for automatic processing (no user input), or `0` to manually confirm each file before processing.
- `--help`: Display the help message and available options.

### Examples

#### 1. Manual Confirmation Mode

To manually confirm each video file before processing, use the `--automated 0` option:

```bash
./compress_videos.sh --input /path/to/source --output /path/to/destination --automated 0
```

In this mode, the script will display each file's processing command and ask if you want to process the file. You can choose `y` (yes) or `n` (no) to continue or skip the file.

**Example Output**:
```bash
Initial video statuses:
/path/to/source/video1.mkv: todo
/path/to/source/video2.mp4: todo

Processing command: ffmpeg -i "/path/to/source/video1.mkv" -vf "scale=1420:1080" -c:v libx265 -crf 27 -y "/path/to/destination/video1.mp4"
Do you want to process this file? (y/n):
```

#### 2. Automated Mode

To process all files automatically without any confirmation, use the `--automated 1` option:

```bash
./compress_videos.sh --input /path/to/source --output /path/to/destination --automated 1
```

In this mode, the script will compress and process all the video files without pausing for user input.

**Example Output**:
```bash
Initial video statuses:
/path/to/source/video1.mkv: todo
/path/to/source/video2.mp4: todo

Processing command: ffmpeg -i "/path/to/source/video1.mkv" -vf "scale=1420:1080" -c:v libx265 -crf 27 -y "/path/to/destination/video1.mp4"
File processed successfully: /path/to/source/video1.mkv
...
```

#### 3. Help Command

To display help information about how to use the script, run:

```bash
./compress_videos.sh --help
```

**Example Output**:
```bash
Usage: ./compress_videos.sh --input <source_folder> --output <destination_folder> --automated <1/0>

Arguments:
  --input <source_folder>        Specify the source folder containing video files
  --output <destination_folder>  Specify the destination folder for compressed videos
  --automated <1/0>              1 for automatic processing, 0 for manual confirmation
  --help                         Display this help message
```

## How It Works

1. **Initialization**: The script scans the input folder recursively for video files of supported formats (`.mp4`, `.mkv`, `.avi`, `.mov`). All files are added to the `video_status` dictionary with the initial status set to `"todo"`.
   
2. **User Confirmation (if automated mode is off)**: For each video file, the script shows the FFmpeg compression command and waits for user confirmation (`y` for yes, `n` for no). If the file is skipped, its status is updated to `"skipped"`.

3. **Video Compression**: If the user agrees (or in automated mode), the video file is processed by FFmpeg. The output video is scaled to the specified resolution (`1420x1080` by default) and saved in the output folder with an `.mp4` extension.

4. **Status Updates**: After each file is processed, the script updates the `video_status` dictionary to reflect whether the process was successful (`"success"`) or failed (`"failed"`). If skipped, the status is `"skipped"`.

5. **Final Status**: After processing all files, the script prints the final status of all videos (successfully processed, failed, or skipped).

## Example

Here’s a quick example demonstrating how to use the script:

1. Create a folder named `source` and place some video files in it.
2. Run the following command to compress the videos and save them to a folder named `destination`:

   ```bash
   ./compress_videos.sh --input source --output destination --automated 0
   ```

3. After execution, check the specified output folder for the compressed video files.

## Conclusion

This script provides a straightforward method for compressing multiple videos into a specified format and resolution, making it ideal for video archiving, storage optimization, or preparing videos for sharing.

