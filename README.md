# Checksum File Renamer

A Docker container that renames files to their checksums and organizes them by file extension.

## Overview

This tool helps you organize files by:
1. Renaming files to their checksum values (using SHA-256, MD5, or other algorithms)
2. Optionally preserving original file extensions
3. Organizing files into directories by file extension
4. Handling files without extensions using EXIF data

## Features

- **Multiple Checksum Algorithms**: Support for SHA-1, SHA-256, SHA-512, and MD5
- **Extension Handling**: Option to preserve original file extensions
- **Automatic Organization**: Creates directories for each file type
- **File Type Detection**: Uses ExifTool to detect file types when extensions are missing
- **Detailed Logging**: Shows progress and summary information
- **Containerized**: Runs in an isolated Docker environment

## Installation

### Prerequisites

- Docker installed on your system

### Quick Start

```bash
# Clone the repository
git clone https://github.com/arminmarth/checksum-file-renamer.git
cd checksum-file-renamer

# Build the Docker image
docker build -t checksum-file-renamer .

# Run with default settings (using the Makefile)
make run

# Or run with custom settings
docker run -v /path/to/your/files:/mounted_dir \
  -e INPUT_DIR=/mounted_dir \
  -e OUTPUT_DIR=/renamed_files \
  -e CHECKSUM_ALGORITHM=sha256 \
  -e APPEND_FILE_EXTENSION=yes \
  -e CREATE_EXTENSION_DIRECTORIES=yes \
  checksum-file-renamer
```

## Usage

### Command Line Options

```
Usage: rename_files.sh [OPTIONS]
Renames files in the specified directory to their checksums and organizes by file extension.

Options:
  -i, --input-dir DIR           The directory containing files to rename (default: /mounted_dir)
  -o, --output-dir DIR          The directory to save renamed files (default: /renamed_files)
  -a, --checksum-algorithm ALG  Checksum algorithm to use: sha1, sha256, sha512, md5 (default: sha256)
  -e, --append-file-extension   Whether to append original file extension: yes, no (default: yes)
  -d, --create-extension-dirs   Whether to create directories for each extension: yes, no (default: yes)
  -h, --help                    Show this help message and exit

Example:
  rename_files.sh -i /data/files -o /data/renamed -a md5 -e yes -d yes
```

### Environment Variables

When running the Docker container, you can configure the behavior using these environment variables:

| Variable | Description | Default | Options |
|----------|-------------|---------|---------|
| `INPUT_DIR` | Directory containing files to rename | `/mounted_dir` | Any valid path |
| `OUTPUT_DIR` | Directory to save renamed files | `/renamed_files` | Any valid path |
| `CHECKSUM_ALGORITHM` | Algorithm to use for checksums | `sha256` | `sha1`, `sha256`, `sha512`, `md5` |
| `APPEND_FILE_EXTENSION` | Whether to keep original extensions | `yes` | `yes`, `no` |
| `CREATE_EXTENSION_DIRECTORIES` | Whether to organize by extension | `yes` | `yes`, `no` |

### Using the Makefile

The repository includes a Makefile for common operations:

```bash
# Build the Docker image
make build

# Run the container with default settings
make run

# Build development version
make build-dev

# Run development version
make run-dev
```

## Examples

### Basic Usage

```bash
# Rename all files in /data/photos to their SHA-256 checksums
# and organize them by extension
docker run -v /data/photos:/mounted_dir checksum-file-renamer
```

### Using MD5 Instead of SHA-256

```bash
docker run -v /data/photos:/mounted_dir \
  -e CHECKSUM_ALGORITHM=md5 \
  checksum-file-renamer
```

### Don't Create Extension Directories

```bash
docker run -v /data/photos:/mounted_dir \
  -e CREATE_EXTENSION_DIRECTORIES=no \
  checksum-file-renamer
```

## Development

To build and run the development version:

```bash
# Build development image
make build-dev

# Run development container
make run-dev
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
