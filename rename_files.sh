#!/bin/bash

# Parse command line arguments
while [[ $# -gt 0 ]]
do
    case "$1" in
        -i|--input-dir)
            INPUT_DIR=$2
            shift 2
            ;;
        -o|--output-dir)
            OUTPUT_DIR=$2
            shift 2
            ;;
        -a|--checksum-algorithm)
            CHECKSUM_ALGORITHM=$2
            shift 2
            ;;
        -e|--append-file-extension)
            APPEND_FILE_EXTENSION=$2
            shift 2
            ;;
        -d|--create-extension-directories)
            CREATE_EXTENSION_DIRECTORIES=$2
            shift 2
            ;;
        -h|--help)
            printf "Usage: %s [OPTIONS]\n" "$(basename "$0")"
            printf "Renames files in the specified directory to their checksums and creates separate directories for each file extension.\n\n"
            printf "  -i, --input-dir           The directory to rename the files in (mounted to the container)\n"
            printf "  -o, --output-dir          The directory to save the renamed files in\n"
            printf "  -a, --checksum-algorithm  The checksum algorithm to use (sha1, sha256, sha512, md5)\n"
            printf "  -e, --append-file-extension  Whether to append the original file extension to the renamed file (yes, no)\n"
            printf "  -d, --create-extension-directories  Whether to create separate directories for each file extension (yes, no)\n"
            printf "  -h, --help                Show this help message and exit\n"
            exit 0
            ;;
        *)
            printf "Unknown option: %s\n" "$1"
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

# Check if input directory exists
if [[ ! -d "$INPUT_DIR" ]]
then
    printf "Input directory not found: %s\n" "$INPUT_DIR"
    exit 1
fi

# Create output directory if it doesn't exist
if [[ ! -d "$OUTPUT_DIR" ]]
then
    mkdir -p "$OUTPUT_DIR"
fi

# Rename files in input directory
for file in "$INPUT_DIR"/*
do
    # Get file name and extension
    filename=$(basename "$file")
    file_extension="${filename##*.}"
    filename="${filename%.*}"

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
        *)
            printf "Unknown checksum algorithm: %s\n" "$CHECKSUM_ALGORITHM"
            exit 1
            ;;
    esac

    # Determine output file name
    if [[ "$APPEND_FILE_EXTENSION" == "yes" ]]
    then
        output_filename="$checksum.$file_extension"
    else
        # Use exiftool to generate file extension based on file type
        file_extension=$(exiftool -filetype "$input_file" | cut -d: -f2 | tr -d ' ')
        output_filename="$checksum.$file_extension"
    fi

    # Create output directory for file extension if necessary
    if [[ "$CREATE_EXTENSION_DIRECTORIES" == "yes" ]]
    then
        extension_dir="$OUTPUT_DIR/$file_extension"
        if [[ ! -d "$extension_dir" ]]
        then
            mkdir -p "$extension_dir"
        fi
        output_file="$extension_dir/$output_filename"
    else
        output_file="$OUTPUT_DIR/$output_filename"
    fi

    # Rename file
    mv "$file" "$output_file"
done
