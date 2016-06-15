set filein=SA_DA_vorlage

rem set filein=SA_DA_template

set fileout=%filein%_2up

pdflatex %filein%
bibtex %filein%
pdflatex %filein%
pdflatex %filein%
pdflatex %fileout%
