# checksum-file-renamer

A Docker container that renames files in a directory to their checksums and creates separate directories for each file extension.

## Usage

To use the Docker container, first build the image using the `Dockerfile` in this repository:

    docker build -t checksum-file-renamer .

Then, run the Docker container and specify the input and output directories and any other desired options as environment variables:

    docker run -v /my_files:/mounted_dir -e INPUT_DIR=/mounted_dir -e OUTPUT_DIR=/renamed_files -e CHECKSUM_ALGORITHM=sha256 -e APPEND_FILE_EXTENSION=yes -e CREATE_EXTENSION_DIRECTORIES=no checksum-file-renamer

Alternatively, you can use the `Makefile` in this repository to build and run the Docker container:

    make build
    make run

This will build the Docker image using the `Dockerfile`, and then run the container using the built image and the specified environment variables and mount points. You can also run the `build-dev` and `run-dev` tasks to build the development environment Docker image and run the container in the development environment.

## Options and Variables

The following options and variables can be specified when running the Docker container:

* `-i, --input-dir`: The directory to rename the files in (mounted to the container)
  * Default value: `/mounted_dir`
* `-o, --output-dir`: The directory to save the renamed files in
  * Default value: `/renamed_files`
* `-a, --checksum-algorithm`: The checksum algorithm to use (`sha1`, `sha256`, `sha512`, `md5`)
  * Default value: `sha256`
* `-e, --append-file-extension`: Whether to append the original file extension to the renamed file (`yes`, `no`)
  * Default value: `yes`
* `-d, --create-extension-directories`: Whether to create separate directories for each file extension (`yes`, `no`)
  * Default value: `yes`

## License

This Docker container is released under the MIT License. See [LICENSE](LICENSE) for more details.
