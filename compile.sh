#!/bin/sh

cd /root/texmf
git pull
cd "$SRC_DIR"
if [ -z "$CI" ]; then
	latexmk \
		-pdfxe -ps- -dvi- \
		-xelatex \
		-view=none -pvc \
		-auxdir="$AUX_DIR" \
		-outdir="$BUILD_DIR" \
		$FILENAME
else
	latexmk \
		-pdfxe -ps- -dvi- \
		-xelatex \
		-auxdir="$AUX_DIR" \
		-outdir="$BUILD_DIR" \
		$FILENAME
fi
