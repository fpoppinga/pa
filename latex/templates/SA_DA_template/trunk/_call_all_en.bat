set filein=SA_DA_template

rem Indexfiles löschen:
del %filein%.idx
del %filein%.ind
del %filein%.ilg

pdflatex %filein%
bibtex %filein%
pdflatex %filein%
pdflatex %filein%
makeindex -s index_en.ist %filein%
pdflatex %filein%
pdflatex %filein%
