# Markdown Standards

This document outlines the Markdown standards and conventions used throughout the Juno project documentation.

## General Principles

- All documentation must be written in **International English**
- Follow semantic structure over visual formatting
- Maintain consistency across all Markdown files
- Ensure accessibility and readability

## File Structure

### File Naming
- Use lowercase with hyphens: `installation-guide.md`
- Be descriptive but concise: `troubleshooting-docker.md`
- Avoid abbreviations unless widely understood

### Document Structure
```markdown
# Document Title

Brief description of the document's purpose.

## Table of Contents (if needed)

- [Section 1](#section-1)
- [Section 2](#section-2)

## Section 1

Content here...

## Section 2

Content here...
```

## Headers

### Hierarchy
- Use ATX-style headers (`#`, `##`, `###`)
- Always include a space after the `#` symbols
- Use sentence case (capitalize first letter only)
- Maximum 6 levels of headers

### Examples
```markdown
# Main document title
## Primary section
### Subsection
#### Sub-subsection
##### Minor heading
###### Smallest heading
```

### Guidelines
- Only one H1 (`#`) per document
- Don't skip header levels (H1 → H3)
- Use descriptive, scannable headers

## Lists

### Unordered Lists
- Use `-` for consistency
- Add space after the dash
- Indent nested items with 2 spaces

```markdown
- First item
- Second item
  - Nested item
  - Another nested item
- Third item
```

### Ordered Lists
- Use `1.` for all items (auto-numbering)
- Add space after the period
- Indent nested items with 3 spaces

```markdown
1. First step
1. Second step
   1. Sub-step
   1. Another sub-step
1. Third step
```

### Task Lists
```markdown
- [x] Completed task
- [ ] Pending task
- [ ] Another pending task
```

## Code and Commands

### Inline Code
- Use backticks for file names, commands, and code snippets
- Examples: `README.md`, `docker compose up`, `--version`

### Code Blocks
- Always specify the language for syntax highlighting
- Use lowercase language identifiers

```markdown
```bash
# Shell commands
docker compose up -d
```

```python
# Python code
def generate_containers():
    return containers
```

```yaml
# YAML configuration
version: '3.8'
services:
  app:
    image: python:3.13
```
```

### Command Examples
```bash
# Good - with comments and expected output
docker ps
# Expected output:
# CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    NAMES

# Show file structure
tree -F .
```

## Links

### Internal Links
- Use relative paths for project files
- Be descriptive with link text
- Avoid "click here" or similar phrases

```markdown
# Good
See the [installation guide](INSTALLATION.md) for details.
Refer to the [container configuration](app/README.md).

# Avoid
Click [here](INSTALLATION.md) for installation.
See [this file](app/README.md).
```

### External Links
- Use descriptive link text
- Include protocol (https://)
- Consider link stability

```markdown
# Good
Check the [Docker documentation](https://docs.docker.com/) for more information.

# Avoid
Go to https://docs.docker.com/ for more information.
```

## Images

### Image Syntax
```markdown
![Alt text describing the image](path/to/image.png)
```

### Guidelines
- Always include descriptive alt text
- Use relative paths for project images
- Store images in `.assets/` directory
- Use appropriate file formats (PNG for screenshots, SVG for diagrams)

### Examples
```markdown
![Juno Dashboard Interface](../.assets/junoDashboard.png)
![Project Architecture Diagram](../.assets/junoStack.svg)
```

## Tables

### Basic Structure
```markdown
| Header 1 | Header 2 | Header 3 |
|----------|----------|----------|
| Row 1    | Data     | Data     |
| Row 2    | Data     | Data     |
```

### Alignment
```markdown
| Left | Center | Right |
|:-----|:------:|------:|
| Text | Text   | Text  |
```

### Guidelines
- Keep tables simple and readable
- Use tables for structured data only
- Consider lists for simple comparisons

## Emphasis and Formatting

### Text Emphasis
```markdown
- *Italic text* for emphasis
- **Bold text** for strong emphasis
- ***Bold and italic*** for very strong emphasis
- `Inline code` for technical terms
```

### Guidelines
- Use emphasis sparingly for maximum impact
- Bold for important warnings or key points
- Italic for subtle emphasis or definitions

## Blockquotes

### Basic Quotes
```markdown
> This is a blockquote.
> It can span multiple lines.
```

### Nested Quotes
```markdown
> Primary quote
>> Nested quote
```

### Guidelines
- Use for important notes, warnings, or citations
- Keep quotes concise and relevant

## Special Sections

### Admonitions
```markdown
**Note**: This is an informational note.

**Warning**: This is a warning about potential issues.

**Important**: This highlights critical information.

**Tip**: This provides helpful advice.
```

### File Paths and Commands
```markdown
Navigate to the project directory:
```bash
cd /path/to/Juno
```

Edit the configuration file:
```bash
nano containers.txt
```
```

## Line Length and Formatting

### Guidelines
- Aim for 80-100 characters per line for readability
- Break long sentences at natural points
- Use blank lines to separate sections
- Avoid trailing whitespace

### Example
```markdown
This is a properly formatted paragraph that doesn't exceed the
recommended line length and breaks at natural points for optimal
readability.

This is a new paragraph with appropriate spacing.
```

## File References

### Documentation Files
- Use consistent casing: `README.md`, `CONTRIBUTING.md`, `CHANGELOG.md`
- Reference other docs: `[contributing guidelines](CONTRIBUTING.md)`

### Project Files
- Use relative paths: `app/notes/README.md`
- Use backticks for file names: `generator.py`

## Common Patterns

### Prerequisites Section
```markdown
## Prerequisites

Before starting, ensure you have:

- **Docker Engine** (24.0+)
- **Docker Compose** (v2.21+)
- **Python 3** (3.13+)
```

### Installation Steps
```markdown
## Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/incognia/Juno.git
   ```

2. **Navigate to the project directory**:
   ```bash
   cd Juno
   ```

3. **Generate the configuration**:
   ```bash
   ./generator.py
   ```
```

### Troubleshooting Section
```markdown
## Troubleshooting

### Issue: Container fails to start

**Symptoms**: Error message about port conflicts

**Solution**: Check for existing containers:
```bash
docker ps -a
```

### Issue: Permission denied

**Symptoms**: Cannot access Docker socket

**Solution**: Add user to docker group:
```bash
sudo usermod -aG docker $USER
```
```

## Validation

### Before Committing
- [ ] All links work correctly
- [ ] Code blocks have language specification
- [ ] Headers follow hierarchy
- [ ] Alt text provided for images
- [ ] No trailing whitespace
- [ ] Spell check completed
- [ ] Grammar check completed

### Tools
- Use a Markdown linter (markdownlint)
- Validate links with link checkers
- Preview rendered output before committing

## Examples

For complete examples of well-formatted Markdown, refer to:
- [README.md](README.md) - Main project documentation
- [CONTRIBUTING.md](CONTRIBUTING.md) - Contribution guidelines
- [CHANGELOG.md](CHANGELOG.md) - Version history

## Resources

- [CommonMark Specification](https://commonmark.org/)
- [GitHub Flavored Markdown](https://github.github.com/gfm/)
- [Markdown Guide](https://www.markdownguide.org/)
