# Storage Audit Script

This script audits directories and subdirectories, collecting information about the number of files, the total size (in MB), and the directory path. It generates a CSV file with this information. The filename of the CSV includes the current date in the format `storage_audit_YYYY_MM_DD.csv`.

## Features

- Recursively traverses selected top-level directories.
- Collects information only for **leaf** directories (directories with no subdirectories).
- For each leaf directory, collects:
  - **category**: The top-level parent directory.
  - **name**: The name of the leaf directory (commas replaced with underscores).
  - **num_files**: The number of files in the directory.
  - **size**: The total size of the directory in MB.
  - **location**: The full path of the directory.
- Generates a CSV file with the collected information.
- CSV filename includes the date in the format `storage_audit_YYYY_MM_DD.csv`.

## Requirements

- A Unix-like environment (Linux, macOS, or WSL on Windows).
- `bash` shell.
- `find` and `du` commands (typically pre-installed in most Linux-based distributions).

## Usage

### Make the Script Executable  

```bash
chmod +x audit_storage.sh
```
### Run the Script  

```bash
./audit_storage.sh
```

### Select Directories to Audit  
The script will list the first-level directories and prompt you to select which ones to audit (comma-separated). For example:

```
Listing the top-level directories:

dir1
dir2 
dir3

Enter the directory numbers (comma-separated) you wish to audit: 1,2
```

### Output

A CSV file named storage_audit_YYYY_MM_DD.csv will be generated with the audit data.

```
category,name,num_files,size(MB),location
dir1,sub_dir1,10,2,./dir1/sub/dir1/subsubdir1
dir2,subsubdir1,5,1,./dir2/subdir1/subsubdir1
```

## Notes
- **Leaf Directories**: Only leaf directories (directories with no subdirectories) are included.
- **Comma Replacement**: If a directory name contains commas, they will be replaced with underscores in the output.

## License
This script is released under the MIT License. Feel free to modify and redistribute as needed.