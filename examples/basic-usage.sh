#!/bin/bash
#
# Example 1: Basic Usage
#
# This example demonstrates the basic usage of the checksum-file-renamer tool
# to rename files to their SHA-256 checksums and organize them by extension.

# Create sample files
echo "This is a sample text file" > sample.txt
echo "This is another sample text file" > another.txt
echo "<html><body>Sample HTML file</body></html>" > sample.html

# Run the container with default settings
docker run -v $(pwd):/mounted_dir \
  -e INPUT_DIR=/mounted_dir \
  -e OUTPUT_DIR=/renamed_files \
  -e CHECKSUM_ALGORITHM=sha256 \
  -e APPEND_FILE_EXTENSION=yes \
  -e CREATE_EXTENSION_DIRECTORIES=yes \
  checksum-file-renamer

# Expected output:
# - Files will be renamed to their SHA-256 checksums
# - Files will be organized into directories by extension (txt/, html/)
# - Original file extensions will be preserved

# To verify the results, check the /renamed_files directory in the container
# or mount an additional volume to see the results locally
