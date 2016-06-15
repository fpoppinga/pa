set filein=SA_DA_vorlage

rem set filein=SA_DA_template

set fileout=%filein%_2up

latex %filein%
bibtex %filein%
latex %filein%
latex %filein%
dvips -t a4 -Ppdf %filein%.dvi
gswin32c -q -dBATCH -dNOPAUSE -sPAPERSIZE=a4 -sDEVICE=pdfwrite -dPDFSETTINGS=/printer -dCompatibilityLevel=1.3 -dMaxSubsetPct=100 -dSubsetFonts=true -dEmbedAllFonts=true -sOutputFile=%filein%.pdf %filein%.ps

pdflatex %fileout%
