#!/bin/sh

cd /root/texmf
git pull
cd "$SRC_DIR"
latexmk \
	-pdfxe -ps- -dvi- \
	-xelatex \
	-view=none -pvc \
	-auxdir="$AUX_DIR" \
	-outdir="$BUILD_DIR" \
	$FILENAME
