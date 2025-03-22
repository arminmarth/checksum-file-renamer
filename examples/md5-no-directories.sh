#!/bin/bash
#
# Example 2: Advanced Usage with MD5 and No Extension Directories
#
# This example demonstrates using MD5 checksums and disabling extension directories

# Create sample files
echo "This is a sample text file" > sample.txt
echo "This is another sample text file" > another.txt
echo "<html><body>Sample HTML file</body></html>" > sample.html

# Run the container with custom settings
docker run -v $(pwd):/mounted_dir \
  -e INPUT_DIR=/mounted_dir \
  -e OUTPUT_DIR=/renamed_files \
  -e CHECKSUM_ALGORITHM=md5 \
  -e APPEND_FILE_EXTENSION=yes \
  -e CREATE_EXTENSION_DIRECTORIES=no \
  checksum-file-renamer

# Expected output:
# - Files will be renamed to their MD5 checksums
# - Files will NOT be organized into directories by extension
# - All renamed files will be in the root of the output directory
# - Original file extensions will be preserved
