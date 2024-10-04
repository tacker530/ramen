@echo off
ruby tools\draw2latlng.rb %1  > tmpfile.csv
type tmpfile.csv | ruby tools\latlng2name.rb portals.csv 