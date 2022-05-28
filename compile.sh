#!/bin/sh
# DEBUG PRINTING
echo "## Who am I? -- $(whoami)"

echo "## Updating custom classes repo :"
cd /root/texmf
git pull

export TEXMFHOME=/root/texmf
echo "## Set TEXMFHOME environment variable : $TEXMFHOME"

echo "## Starting compilation ($( $CI && echo 'single run' || echo 'continuous' ))"
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
		-xelatex -f -e '$max_repeat=10' \
		-auxdir="$AUX_DIR" \
		-outdir="$BUILD_DIR" \
		$FILENAME
fi
