@echo off
SET BASEDIR=C:\dev\Ingress\ramen
echo lat,long,portalname
type %1 | ruby %BASEDIR%\tools\draw2latlng.rb | ruby %BASEDIR%\tools\latlng2name.rb %BASEDIR%\2.portals\all_portals.csv 