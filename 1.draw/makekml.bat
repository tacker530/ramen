@echo off
SET BASEDIR=C:\dev\Ingress\ramen
cd %BASEDIR%\1.draw

call %BASEDIR%\tools\kml.bat aomi-face.json  > %BASEDIR%\3.kml\aomi-face.kml
call %BASEDIR%\tools\kml.bat aomi-ramen.json > %BASEDIR%\3.kml\aomi-ramen.kml
call %BASEDIR%\tools\kml.bat aomi-ra.json    > %BASEDIR%\3.kml\aomi-ra.kml
