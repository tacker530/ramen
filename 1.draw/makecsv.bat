@echo off
SET BASEDIR=C:\dev\Ingress\ramen
cd %BASEDIR%\1.draw

call %BASEDIR%\tools\make.bat aomi-face.json  > %BASEDIR%\2.portals\aomi-face.csv
call %BASEDIR%\tools\make.bat aomi-ramen.json > %BASEDIR%\2.portals\aomi-ramen.csv
call %BASEDIR%\tools\make.bat aomi-ra.json    > %BASEDIR%\2.portals\aomi-ra.csv

call %BASEDIR%\tools\make.bat aomi-all.json    > %BASEDIR%\2.portals\aomi-all.csv

