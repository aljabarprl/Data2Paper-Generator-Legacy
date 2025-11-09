#!/bin/bash

DOC_DIR=$(pwd)                 
ROOT_DIR=$(dirname "$DOC_DIR")
BUILD_DIR="$ROOT_DIR/build"    
SRC_DIR="$ROOT_DIR/src"       

FILE_NAME="artikel"

echo "--- 1. Menjalankan Program Fortran ---"
mkdir -p "$BUILD_DIR"

cd "$SRC_DIR" || { echo "Gagal pindah ke direktori src/"; exit 1; }
gfortran statistik.f90 -o statistik_program
./statistik_program

cd "$DOC_DIR" || { echo "Gagal kembali ke direktori doc/"; exit 1; }
echo "Hasil statistik (hasil_statistik.dat) sudah diperbarui di ../results/"

echo "--- 2. Kompilasi LaTeX dan Biber ---"
echo "Menjalankan pdflatex (Langkah 1/4)..."
pdflatex "$FILE_NAME.tex"

echo "Menjalankan biber (Langkah 2/4)..."
biber "$FILE_NAME"

echo "Menjalankan pdflatex (Langkah 3/4)..."
pdflatex "$FILE_NAME.tex"

echo "Menjalankan pdflatex (Langkah 4/4 - Final)..."
pdflatex "$FILE_NAME.tex"

echo "--- 3. Pindahkan HANYA file PDF ke /build ---"

if [ -f "$FILE_NAME.pdf" ]; then
    mv "$FILE_NAME.pdf" "$BUILD_DIR/"
    echo "[Success]: ${FILE_NAME}.pdf dipindahkan ke $BUILD_DIR/"
else
    echo "[Failed]: File PDF tidak ditemukan setelah kompilasi."
fi

echo "Selesai. File .pdf di $BUILD_DIR/. File perantara tetap ada di $DOC_DIR/."