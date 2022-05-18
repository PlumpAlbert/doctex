#!/bin/sh

cd /root/texmf
git pull
cd "$SRC_DIR"
latexmk \
	-pdf -ps- -dvi- \
	-xelatex \
	-view=none -pvc \
	-auxdir="$AUX_DIR" \
	-outdir="$BUILD_DIR" \
	$FILENAME
