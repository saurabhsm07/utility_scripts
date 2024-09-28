# utilities
simple utility scripts usefull for everyday use

### Video Compression Script
This script compresses all video files within a specified input folder using FFmpeg, allowing for flexible resolution scaling and format conversion. It processes video files across different formats and stores the compressed outputs in the designated folder, while also offering an option to automate the process or pause for user input.

#### How It Works
- *Initialization*: The script scans the input folder recursively for video files of supported formats (.mp4, .mkv, .avi, .mov). All files are added to the video_status dictionary with the initial status set to "todo". User Confirmation (if automated mode is off): For each video file, the script shows the FFmpeg compression command and waits for user confirmation (y for yes, n for no). If the file is skipped, its status is updated to "skipped".
- *Video Compression*: If the user agrees (or in automated mode), the video file is processed by FFmpeg. The output video is scaled to the specified resolution (1420x1080 by default) and saved in the output folder with an .mp4 extension.
- *Status Updates*: After each file is processed, the script updates the video_status dictionary to reflect whether the process was successful ("success") or failed ("failed"). If skipped, the status is "skipped".
- *Final Status*: After processing all files, the script prints the final status of all videos (successfully processed, failed, or skipped).

#### Features
- *Resolution Scaling*: Compresses video files to a specified resolution (default: 1420x1080).
- *Video Format Conversion*: Converts all videos to .mp4 format, regardless of the original format.
- *User Control*: Option to manually confirm each file's processing or run the script in an automated mode.
- *File Status Tracking*: Keeps track of the processing status (todo, in-progress, success, failed, or skipped) for each file.
- *Automation Mode*: Option to automatically process files without user confirmation.

#### Requirements
- FFmpeg: Ensure FFmpeg is installed and available in your system's path.
  
#### Usage
**Command-Line Arguments**
```
--input <source_folder>: Required. Specify the folder containing the video files you want to compress.
--output <destination_folder>: Required. Specify the folder where the compressed files will be saved.
--automated <1/0>: Optional. Specify 1 for automatic processing (no user input), or 0 to manually confirm each file before processing.
--help: Display the help message and available options.
```
#### Examples
**Manual Confirmation Mode**: To manually confirm each video file before processing, use the `--automated 0` option. In this mode, the script will display each file's processing command and ask if you want to process the file. You can choose y (yes) or n (no) to continue or skip the file:
```
./compress_videos.sh --input /path/to/source --output /path/to/destination --automated 0
```
Example Output:
```
Initial video statuses:
/path/to/source/video1.mkv: todo
/path/to/source/video2.mp4: todo

Processing command: ffmpeg -i "/path/to/source/video1.mkv" -vf "scale=1420:1080" -c:v libx265 -crf 27 -y "/path/to/destination/video1.mp4"
Do you want to process this file? (y/n):
```
<br>

**Automated Mode** : To process all files automatically without any confirmation, use the `--automated 1` option. In this mode, the script will compress and process all the video files without pausing for user input:
```
./compress_videos.sh --input /path/to/source --output /path/to/destination --automated 1
```
Example Output:
```
Initial video statuses:
/path/to/source/video1.mkv: todo
/path/to/source/video2.mp4: todo

Processing command: ffmpeg -i "/path/to/source/video1.mkv" -vf "scale=1420:1080" -c:v libx265 -crf 27 -y "/path/to/destination/video1.mp4"
File processed successfully: /path/to/source/video1.mkv
```

**Help Command**: To display help information about how to use the script, run:
Example Output:
```
Usage: ./compress_videos.sh --input <source_folder> --output <destination_folder> --automated <1/0>

Arguments:
  --input <source_folder>        Specify the source folder containing video files
  --output <destination_folder>  Specify the destination folder for compressed videos
  --automated <1/0>              1 for automatic processing, 0 for manual confirmation
  --help                         Display this help message
```
