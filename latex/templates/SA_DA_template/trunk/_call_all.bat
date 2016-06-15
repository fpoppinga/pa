set filein=SA_DA_vorlage

rem set filein=SA_DA_template

rem Indexfiles löschen:
del %filein%.idx
del %filein%.ind
del %filein%.ilg

pdflatex %filein%
bibtex %filein%
pdflatex %filein%
pdflatex %filein%
makeindex -g -s index.ist %filein%
pdflatex %filein%
pdflatex %filein%
