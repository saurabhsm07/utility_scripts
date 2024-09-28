#!/bin/bash

# Display help function
show_help() {
    echo "Usage: $0 --input <source_folder> --output <destination_folder> --automated <1/0>"
    echo
    echo "Arguments:"
    echo "  --input <source_folder>        Specify the source folder containing video files"
    echo "  --output <destination_folder>  Specify the destination folder for compressed videos"
    echo "  --automated <1/0>              1 for automatic processing, 0 for manual confirmation"
    echo "  --help                         Display this help message"
    exit 1
}

# Check for at least 1 argument
if [ "$#" -lt 1 ]; then
    show_help
fi

# Default values
SOURCE_FOLDER=""
DESTINATION_FOLDER=""
AUTOMATED=0

# Parse key-value arguments
while [[ "$#" -gt 0 ]]; do
    case "$1" in
        --input)
            SOURCE_FOLDER="$2"
            shift 2
            ;;
        --output)
            DESTINATION_FOLDER="$2"
            shift 2
            ;;
        --automated)
            AUTOMATED="$2"
            shift 2
            ;;
        --help)
            show_help
            ;;
        *)
            echo "Unknown argument: $1"
            show_help
            ;;
    esac
done

# Check if required arguments are provided
if [ -z "$SOURCE_FOLDER" ] || [ -z "$DESTINATION_FOLDER" ]; then
    echo "Error: --input and --output are required."
    show_help
fi

# Dictionary-like object to track file statuses
declare -A video_status

# Get the list of video files and store them in an array
video_files=($(find "$SOURCE_FOLDER" -type f \( -iname "*.mp4" -o -iname "*.mkv" -o -iname "*.avi" -o -iname "*.mov" \)))

# Initialize the video_status object with all files set to "todo"
for file in "${video_files[@]}"; do
    video_status["$file"]="todo"
done

# Print the initial status of all files
echo "Initial video statuses:"
for key in "${!video_status[@]}"; do
    echo "$key: ${video_status[$key]}"
done

# Iterate over the array of video files
for file in "${video_files[@]}"; do
    # Get the file name only (without the directory path)
    file_name=$(basename "$file")
    
    # Define the output file name (with .mp4 extension)
    output_file="$DESTINATION_FOLDER${file_name%.*}.mp4"
    
    # Show the processing command
    echo "Processing command: ffmpeg -i \"$file\" -vf \"scale=1420:1080\" -c:v libx265 -crf 27 -y \"$output_file\""
    
    # If automated is set to 0, prompt the user for confirmation
    if [[ "$AUTOMATED" -eq 0 ]]; then
        while true; do
            read -p "Do you want to process this file? (y/n): " choice
            case "$choice" in
                y|Y )
                    break
                    ;;
                n|N )
                    echo "Skipping $file"
                    video_status["$file"]="skipped"
                    continue 2
                    ;;
                * )
                    echo "Please answer y (yes) or n (no)."
                    ;;
            esac
        done
    fi
    
    # Mark the video as in-progress
    video_status["$file"]="in-progress"
    
    # Compress the video using FFmpeg
    ffmpeg -i "$file" -vf "scale=1420:1080" -c:v libx265 -crf 27 -y "$output_file"
    
    # Check the status of the ffmpeg command and update the status
    if [ $? -eq 0 ]; then
        video_status["$file"]="success"
        echo "File processed successfully: $file"
    else
        video_status["$file"]="failed"
        echo "Failed to process: $file"
    fi
    
    # Print the status of the video after processing
    echo "Current video statuses:"
    for key in "${!video_status[@]}"; do
        echo "$key: ${video_status[$key]}"
    done
done
