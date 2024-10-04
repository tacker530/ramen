@echo off
echo lat,long,name > portals.csv
ruby .\draw2latlng.rb .\karasu.json | ruby .\latlng2name.rb .\kanazawa.csv >> portals.csv
ruby json2kml.rb karasu.json > karasu.kml