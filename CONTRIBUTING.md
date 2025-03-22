# Contributing to Checksum File Renamer

Thank you for considering contributing to the Checksum File Renamer project! This document provides guidelines for contributions.

## How to Contribute

1. **Fork the Repository**: Create your own fork of the repository
2. **Create a Branch**: Make your changes in a new branch
3. **Submit a Pull Request**: Once your changes are ready, submit a pull request

## Development Setup

### Prerequisites

- Docker installed on your system
- Bash shell environment

### Local Development

```bash
# Clone the repository
git clone https://github.com/arminmarth/checksum-file-renamer.git
cd checksum-file-renamer

# Build the development Docker image
make build-dev

# Run the development container
make run-dev
```

## Coding Standards

- Follow the [Google Shell Style Guide](https://google.github.io/styleguide/shellguide.html) for shell scripts
- Use meaningful variable and function names
- Add comments for complex logic
- Include error handling for all operations

## Testing

Before submitting a pull request, please:

1. Test your changes with various file types
2. Verify that all existing functionality still works
3. Add appropriate test cases for new features

## Pull Request Process

1. Update the README.md with details of changes if applicable
2. Update the CHANGELOG.md with details of changes
3. The version number will be updated according to [Semantic Versioning](http://semver.org/)
4. Your pull request will be merged once it has been reviewed and approved

## Code of Conduct

- Be respectful and inclusive in all communications
- Focus on constructive feedback
- Respect the original author's design decisions

## Questions?

If you have questions about contributing, please open an issue in the repository.

Thank you for your contributions!
