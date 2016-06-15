@echo off

rem Konvertiert alle *.eps Dateien des aktuellen Ordners in *.pdf
rem benutzt epstopdf.exe (in /miktex/miktex/bin/ )
rem Funktioniert bei einigen eps-Bildern nicht
rem Vermutung: Problem liegt am integrierten Vorschaubild

rem for %%f in (*.eps) do epstopdf --nocompress %%f

@echo on
for %%f in (*.eps) do epstopdf %%f


:DONE
