# Specify the base image to use
FROM alpine

# Install the necessary dependencies
RUN apk add --no-cache findutils busybox-extras

# Copy the shell script into the container
COPY rename_files.sh /

# Specify the default values for the environment variables
ENV INPUT_DIR /mounted_dir
ENV OUTPUT_DIR /renamed_files
ENV CHECKSUM_ALGORITHM sha256
ENV APPEND_FILE_EXTENSION yes
ENV CREATE_EXTENSION_DIRECTORIES yes

# Specify the command to run when the container starts
ENTRYPOINT ["/rename_files.sh"]
