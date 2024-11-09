#!/bin/bash

# Get the current date in YYYY_MM_DD format
current_date=$(date +"%Y_%m_%d")

# Output CSV file with date in the filename
output_csv="storage_audit_${current_date}.csv"

# Write the header row to the CSV file
echo "category,name,num_files,size(MB),location" > "$output_csv"

# List the top-level directories with indexes
echo "Listing the top-level directories:"
top_level_dirs=()
index=1
for dir in */; do
    if [ -d "$dir" ]; then
        echo "$index. $(basename "$dir")"
        top_level_dirs+=("$dir")
        ((index++))
    fi
done

# Prompt user for directory selection
echo -n "Enter the directory numbers (comma-separated) you wish to audit: "
read user_input

# Convert the user input into an array of indices
IFS=',' read -r -a selected_dirs <<< "$user_input"

# Loop over the selected directories
for dir_index in "${selected_dirs[@]}"; do
    dir_index=$((dir_index - 1))  # Adjust for 0-based array indexing
    if [ -z "${top_level_dirs[$dir_index]}" ]; then
        echo "Invalid selection: $dir_index. Skipping."
        continue
    fi
    
    selected_dir="${top_level_dirs[$dir_index]}"
    echo "Running audit for: $selected_dir"
    
    # Get the base/top-level directory name (category) from the selected directory
    category=$(basename "$selected_dir")
    
    # Function to traverse directories and log leaf directories
    traverse_directory() {
        local parent_dir="$1"

        # Find all subdirectories under the parent directory (skip non-leaf directories)
        find "$parent_dir" -mindepth 1 -type d | while read dir; do
            # Check if this directory has any subdirectories (non-leaf check)
            if [ $(find "$dir" -mindepth 1 -type d | wc -l) -eq 0 ]; then
                # This is a leaf directory (no subdirectories)

                # Get the subdirectory name (name)
                name=$(basename "$dir")
                
                # Replace commas in the name with underscores
                name=$(echo "$name" | sed 's/,/_/g')

                # Get the number of files in the subdirectory
                num_files=$(find "$dir" -type f | wc -l)
                # Get the total size of the subdirectory in MB
                size_mb=$(du -sm "$dir" | cut -f1)
                # Full path (location) of the subdirectory
                location="$dir"
                
                # Log the row being inserted into the console
                echo "Inserting row: $category,$name,$num_files,$size_mb,$location"

                # Append the result to the CSV file
                echo "$category,$name,$num_files,$size_mb,$location" >> "$output_csv"
            else
                # This directory has subdirectories, so skip it
                echo "Skipping directory (non-leaf): $dir"
            fi
        done
    }

    # Run the traverse function on the selected directory
    traverse_directory "$selected_dir"
done

echo "CSV file created: $output_csv"

