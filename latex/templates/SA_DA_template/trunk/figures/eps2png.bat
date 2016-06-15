@echo off

rem convert *.eps file to *.png file using the bounding box

rem possible devices:
rem png16m  24-bit RGB
rem png256  8-bit color
rem png16   4-bit color
rem pngmono black-and-white
rem pnggray grayscale

rem -r gibt Auflösung in dots per inch an


if "%1"=="" goto USAGE

if "%2"=="" (
set res=300
goto PNG)

set res=%2

:PNG
@echo on
gswin32c -q -dBATCH -dNOPAUSE -r%res% -dEPSCrop -dTextAlphaBits=4 -dGraphicsAlphaBits=4 -sDEVICE=png16m -sOutputFile=%~n1_%res%dpi.png %~n1.eps
rem transparent: (aber schlechtere Qualität)
rem gswin32c -q -dBATCH -dNOPAUSE -sDEVICE=pngalpha -sOutputFile=%~n1_%res%dpi_t.png -r%res% -dEPSCrop -dTextAlphaBits=4 -dGraphicsAlphaBits=4 %~n1.eps
@echo off
goto EXIT


:USAGE
echo eps2png file.eps [resolution]
echo resolution (in dpi is optional)

:EXIT

