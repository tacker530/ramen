#
# Test for drawing data
#
#  IITC draw data to KML line
#
require './drawdata'

draw = Drawdata.new
draw.load(ARGV[0])
draw.kml
