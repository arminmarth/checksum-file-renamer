#!/bin/sh

# Find all files in the input directory and calculate their checksums
find "$INPUT_DIR" -type f -exec "$CHECKSUM_ALGORITHM"sum {} \; | while read -r checksum file; do
  # Determine the file's extension
  if [ "$APPEND_FILE_EXTENSION" = "yes" ]; then
    # Use the original file extension
    extension="${file##*.}"
  else
    # Determine the file's extension based on its MIME type
    extension="$(file --mime-type -b "$file" | tr / -)"
  fi

  # Rename the file with its checksum and extension
  if [ "$CREATE_EXTENSION_DIRECTORIES" = "yes" ]; then
    # Create a directory for the file's extension and move the file into it
    mkdir -p "$OUTPUT_DIR/$extension"
    mv "$file" "$OUTPUT_DIR/$extension/${checksum}.${extension}"
  else
    # Move the file to the output directory
    mv "$file" "$OUTPUT_DIR/${checksum}.${extension}"
  fi
done
