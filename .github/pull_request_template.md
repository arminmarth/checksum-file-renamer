name: Pull Request Template

description: Create a new pull request
title: "[FEATURE/FIX/DOCS]: "
body:
  - type: markdown
    attributes:
      value: |
        Thanks for submitting a pull request! Please provide the information below.
  - type: textarea
    id: description
    attributes:
      label: Description
      description: Please provide a clear and concise description of the changes
      placeholder: Describe what changes you've made and why...
    validations:
      required: true
  - type: textarea
    id: related-issue
    attributes:
      label: Related Issue
      description: If this PR addresses an existing issue, please link it
      placeholder: Fixes #(issue number)
  - type: textarea
    id: testing
    attributes:
      label: Testing Performed
      description: Describe the testing you've done to validate your changes
      placeholder: |
        - Tested with various file types
        - Verified Docker container builds successfully
        - Ran example scripts
    validations:
      required: true
  - type: checkboxes
    id: checklist
    attributes:
      label: Checklist
      description: Please check all that apply
      options:
        - label: I have updated the documentation accordingly
        - label: I have updated the CHANGELOG.md file
        - label: I have added tests that prove my fix/feature works
        - label: I have tested the Docker container
  - type: checkboxes
    id: terms
    attributes:
      label: Code of Conduct
      description: By submitting this pull request, you agree to follow our contribution guidelines
      options:
        - label: I agree to follow this project's Code of Conduct
          required: true
