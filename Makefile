build:
    docker build -t my_image .

build-dev:
    docker build -f Dockerfile.dev -t my_dev_image .

run:
    docker run -v /my_files:/mounted_dir -e INPUT_DIR=/mounted_dir -e OUTPUT_DIR=/renamed_files -e CHECKSUM_ALGORITHM=sha256 -e APPEND_FILE_EXTENSION=yes -e CREATE_EXTENSION_DIRECTORIES=no my_image

run-dev:
    docker run -v /my_files:/app -it my_dev_image
