#
#drawtoolsのテキストから、対応するポータルの一覧を作成する
#  入力
# 　$ruby draw2latlng.rb JSONファイル
#　出力
#   latitude,logitude

require 'json'
require 'csv'

# 見つかったポータルの一覧
portals = []

class Portal
  attr_accessor :portalname, :lat, :lng
  def initialize(portalname,lat,lng)
    @portalname = portalname; @lat = lat;  @lng = lng
  end
end

# 引数をJSONファイルとする
json_file_path = ARGV[0]
array = {}
File.open(json_file_path) do |j|
    array = JSON.load(j)
end

def item_writer (value)
  # 配列だった場合はひとつずつに分けて再起処理します
  if value.instance_of?(Array) then
    value.each do |v|
      item_writer(v)
    end
  end
  # ハッシュだった場合は値を出力します。
  #　必ずlat,lngの順番と仮定している
  if value.instance_of?(Hash) then
    value.each_pair do |key, val|
      case key 
        when "lat"     then print "#{val}, "   
        when "lng"     then print "#{val}\n"
        #  Portal.new( "",val["lat"],val["lng"])  >> Portals
        when "type"    then # print "TYPE = #{val}\n"
        when "color"   then # print "COLOR = #{val}\n"
        when "latLngs" then 
          item_writer(val) 
        else # print "key =#{key} #{val}"
      end
    end
  end
end

# JSON -> 配列　を順番に処理します
array.each_with_index do | value, i |
  item_writer(value)
end
