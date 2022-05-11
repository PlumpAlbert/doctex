#!/bin/sh

latexmk \
	-pdf -ps- -dvi- \
	-xelatex \
	-view=none -pvc \
	-auxdir="$AUX_DIR" \
	-outdir="$BUILD_DIR" \
	$FILENAME
