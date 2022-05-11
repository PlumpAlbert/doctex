# DOCTEX

Docker container for continuous compilation of LaTeX documents.

## Options

### `SRC_DIR`

Root directory of LaTeX project inside Docker container.

Default: `/work/src`

### `BUILD_DIR`

Directory for generated PDF document.

Default: `/work/build`

### `AUX_DIR`

Directory for auxiliary files.

Default: `${BUILD_DIR}`

### `LOG_DIR`

Directory for latexmk logs

Default: `/work/log`


### `FILENAME` **[REQUIRED]**

Main LaTeX project file to compile.
