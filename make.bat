@echo off
SET BASEDIR=C:\dev\Ingress\ramen
type %1 | ruby %BASEDIR%\tools\draw2latlng.rb > %BASEDIR%\tools\tmpfile.csv
type %BASEDIR%\tools\tmpfile.csv | ruby %BASEDIR%\tools\latlng2name.rb %BASEDIR%\portals\all_portals.csv 