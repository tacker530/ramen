#!/bin/zsh
# color change to blue
cat aomi-all-link-color.json| ruby ../tools/draw2dodgerblue.rb  > aomi-all-link.json
#  draw to KML
ruby ../tools/draw2kml.rb aomi-all-link-color.json > ../3.KMLdata/aomi-all.kml
# draw link to CF
cat aomi-all-link-color.json| ruby ../tools/draw2cf.rb  > aomi-all-cf.json
# draw link to portal list(CSV)
echo lat,long,portalname > ../2.portals/aomi-all.csv
cat  aomi-all-link-color.json | ruby ../tools/draw2latlng.rb | ruby ../tools/latlng2name.rb ../2.portals/master_portals.csv >> ../2.portals/aomi-all.csv
