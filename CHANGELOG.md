# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.1.0] - 2025-03-22

### Added
- Support for EXIF data detection for files without extensions
- Improved error handling for invalid input directories
- Added progress reporting for large file sets

### Changed
- Optimized checksum calculation for large files
- Updated Docker container to use Alpine Linux for smaller image size

### Fixed
- Fixed issue with spaces in filenames
- Fixed handling of files without extensions

## [1.0.0] - 2024-12-15

### Added
- Initial release
- Support for SHA-1, SHA-256, SHA-512, and MD5 checksums
- Option to preserve original file extensions
- Automatic organization by file extension
- Docker container support
- Makefile for common operations
