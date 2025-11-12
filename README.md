# Data2Paper Generator 
## Support
* ``Linux, Unix & WSL``
* `.csv`
## Ouput
* ``.pdf``

# How to use
## Linux (wsl/unix)
Setup:
```bash
cd to this repo
```
Directory:
```bash
cd doc
```
Update:
```bash
sudo apt update
```
Install Tex:
```bash
sudo apt install texlive-full biber
```
Or if you want spesific:
```bash
sudo apt install texlive-latex-base texlive-bibtex-extra biber
```
Install Compiler: (if you already have skip this)
```bash
sudo apt install gfortran
```
Permission:
```bash
chmod +x full_compile_no_clean.sh
```
##
Compiling:
```bash
./full_compile_no_clean.sh your_data_file.csv
```
Example:
```bash
./full_compile_no_clean.sh data_ekonomi.csv
```
---

Data input is located at ``\data`` (here is your data source for python process it)

Build output (pdf) is located at ``\build``

---

Customize:

```bash
edit your journal at 'artikel.tex'
```

```bash
edit your references at 'references.bib'
```
