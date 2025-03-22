FROM ubuntu:22.04

LABEL maintainer="Armin Marth"
LABEL description="Docker container that renames files to their checksums and organizes by extension"
LABEL version="1.1.0"

# Install dependencies in a single RUN command to reduce layers
RUN apt-get update && apt-get install -y --no-install-recommends \
    coreutils \
    libimage-exiftool-perl \
    && rm -rf /var/lib/apt/lists/*

# Create directories
RUN mkdir -p /mounted_dir /renamed_files

# Copy script and make it executable
COPY rename_files.sh /usr/local/bin/rename_files.sh
RUN chmod +x /usr/local/bin/rename_files.sh

# Set working directory
WORKDIR /mounted_dir

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/rename_files.sh"]

# Default command shows help
CMD ["-h"]
