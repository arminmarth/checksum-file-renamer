# Docker Container for Renaming Files

This Docker container renames all files in a specified directory to their checksums and creates separate directories for each file extension, with the files of that type moved into the corresponding directories.

## Usage

To use this Docker container, follow these steps:

1.  Build the Docker image by running the following command from the directory that contains the `Dockerfile` and `rename_files.sh` script:

        docker build -t my_image .

2.  Run the Docker container, using the `-v` flag to mount the directory you want to rename the files in and the `-e` flag to specify any custom values for the environment variables. For example:

        docker run -v /my_files:/mounted_dir -e INPUT_DIR=/mounted_dir -e OUTPUT_DIR=/renamed_files -e CHECKSUM_ALGORITHM=sha256 -e APPEND_FILE_EXTENSION=yes -e CREATE_EXTENSION_DIRECTORIES=no my_image

## Options and Variables

The following options and variables can be customized when running the Docker container:

* `INPUT_DIR`: The directory to rename the files in. This directory will be mounted to the container. Default value: `/mounted_dir`
* `OUTPUT_DIR`: The directory to save the renamed files in. Default value: `/renamed_files`
* `CHECKSUM_ALGORITHM`: The checksum algorithm to use. Possible values: `sha1`, `sha256`, `sha512`, `md5`. Default value: `sha256`
* `APPEND_FILE_EXTENSION`: Whether to append the original file extension to the renamed file. Possible values: `yes`, `no`. Default value: `yes`
* `CREATE_EXTENSION_DIRECTORIES`: Whether to create separate directories for each file extension and move the files with that extension into the corresponding directories. Possible values: `yes`, `no`. Default value: `yes`

## License

This Docker container is released under the MIT License. See [LICENSE](LICENSE) for more details.
