#!/bin/bash
#
# rename_files.sh - Renames files to their checksums and organizes by extension
#
# This script renames files in the specified directory to their checksums
# and optionally creates separate directories for each file extension.
#
# Author: Armin Marth
# Version: 1.1.0
# Last Updated: 2025-03-22

set -e  # Exit immediately if a command exits with a non-zero status

# Function to display usage information
show_help() {
    printf "Usage: %s [OPTIONS]\n" "$(basename "$0")"
    printf "Renames files in the specified directory to their checksums and organizes by file extension.\n\n"
    printf "Options:\n"
    printf "  -i, --input-dir DIR           The directory containing files to rename (default: /mounted_dir)\n"
    printf "  -o, --output-dir DIR          The directory to save renamed files (default: /renamed_files)\n"
    printf "  -a, --checksum-algorithm ALG  Checksum algorithm to use: sha1, sha256, sha512, md5 (default: sha256)\n"
    printf "  -e, --append-file-extension   Whether to append original file extension: yes, no (default: yes)\n"
    printf "  -d, --create-extension-dirs   Whether to create directories for each extension: yes, no (default: yes)\n"
    printf "  -h, --help                    Show this help message and exit\n"
    printf "\nExample:\n"
    printf "  %s -i /data/files -o /data/renamed -a md5 -e yes -d yes\n" "$(basename "$0")"
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        -i|--input-dir)
            INPUT_DIR="$2"
            shift 2
            ;;
        -o|--output-dir)
            OUTPUT_DIR="$2"
            shift 2
            ;;
        -a|--checksum-algorithm)
            CHECKSUM_ALGORITHM="$2"
            shift 2
            ;;
        -e|--append-file-extension)
            APPEND_FILE_EXTENSION="$2"
            shift 2
            ;;
        -d|--create-extension-directories|--create-extension-dirs)
            CREATE_EXTENSION_DIRECTORIES="$2"
            shift 2
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            printf "Error: Unknown option: %s\n" "$1"
            show_help
            exit 1
            ;;
    esac
done

# Set default values for environment variables
INPUT_DIR=${INPUT_DIR:-/mounted_dir}
OUTPUT_DIR=${OUTPUT_DIR:-/renamed_files}
CHECKSUM_ALGORITHM=${CHECKSUM_ALGORITHM:-sha256}
APPEND_FILE_EXTENSION=${APPEND_FILE_EXTENSION:-yes}
CREATE_EXTENSION_DIRECTORIES=${CREATE_EXTENSION_DIRECTORIES:-yes}

# Validate checksum algorithm
case "$CHECKSUM_ALGORITHM" in
    sha1|sha256|sha512|md5)
        # Valid algorithm
        ;;
    *)
        printf "Error: Invalid checksum algorithm: %s\n" "$CHECKSUM_ALGORITHM"
        printf "Valid options are: sha1, sha256, sha512, md5\n"
        exit 1
        ;;
esac

# Check if input directory exists
if [[ ! -d "$INPUT_DIR" ]]; then
    printf "Error: Input directory not found: %s\n" "$INPUT_DIR"
    exit 1
fi

# Create output directory if it doesn't exist
if [[ ! -d "$OUTPUT_DIR" ]]; then
    printf "Creating output directory: %s\n" "$OUTPUT_DIR"
    mkdir -p "$OUTPUT_DIR"
fi

# Count files to process
file_count=$(find "$INPUT_DIR" -type f | wc -l)
if [[ $file_count -eq 0 ]]; then
    printf "Warning: No files found in input directory: %s\n" "$INPUT_DIR"
    exit 0
fi

printf "Found %d files to process in %s\n" "$file_count" "$INPUT_DIR"
printf "Using checksum algorithm: %s\n" "$CHECKSUM_ALGORITHM"

# Process counter
processed=0
skipped=0

# Rename files in input directory
find "$INPUT_DIR" -type f | while read -r file; do
    # Skip if the file is in a subdirectory of INPUT_DIR
    if [[ "$(dirname "$file")" != "$INPUT_DIR" ]]; then
        printf "Skipping file in subdirectory: %s\n" "$file"
        ((skipped++))
        continue
    fi
    
    # Get file name and extension
    filename=$(basename "$file")
    file_extension="${filename##*.}"
    
    # Handle files without extension
    if [[ "$filename" == "$file_extension" ]]; then
        file_extension=""
    else
        filename="${filename%.*}"
    fi

    # Calculate checksum
    case "$CHECKSUM_ALGORITHM" in
        sha1)
            checksum=$(sha1sum "$file" | awk '{print $1}')
            ;;
        sha256)
            checksum=$(sha256sum "$file" | awk '{print $1}')
            ;;
        sha512)
            checksum=$(sha512sum "$file" | awk '{print $1}')
            ;;
        md5)
            checksum=$(md5sum "$file" | awk '{print $1}')
            ;;
    esac

    # Determine output file name
    if [[ "$APPEND_FILE_EXTENSION" == "yes" && -n "$file_extension" ]]; then
        output_filename="$checksum.$file_extension"
    elif [[ "$APPEND_FILE_EXTENSION" == "yes" && -z "$file_extension" ]]; then
        # Try to determine file type using exiftool
        detected_extension=$(exiftool -s -s -s -FileType "$file" | tr '[:upper:]' '[:lower:]')
        if [[ -n "$detected_extension" ]]; then
            output_filename="$checksum.$detected_extension"
            file_extension="$detected_extension"
        else
            output_filename="$checksum"
        fi
    else
        output_filename="$checksum"
    fi

    # Create output directory for file extension if necessary
    if [[ "$CREATE_EXTENSION_DIRECTORIES" == "yes" && -n "$file_extension" ]]; then
        extension_dir="$OUTPUT_DIR/$file_extension"
        if [[ ! -d "$extension_dir" ]]; then
            printf "Creating directory for extension: %s\n" "$file_extension"
            mkdir -p "$extension_dir"
        fi
        output_file="$extension_dir/$output_filename"
    else
        output_file="$OUTPUT_DIR/$output_filename"
    fi

    # Rename file
    printf "Renaming: %s -> %s\n" "$filename" "$output_filename"
    cp "$file" "$output_file"
    
    # Increment counter
    ((processed++))
done

printf "\nSummary:\n"
printf "  Processed: %d files\n" "$processed"
printf "  Skipped: %d files\n" "$skipped"
printf "  Total: %d files\n" "$file_count"
printf "Files renamed successfully to %s\n" "$OUTPUT_DIR"
