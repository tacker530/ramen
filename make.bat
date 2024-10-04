@echo off
type %1 | ruby tools\draw2latlng.rb > tools\tmpfile.csv
type tools\tmpfile.csv | ruby tools\latlng2name.rb all_portals.csv 