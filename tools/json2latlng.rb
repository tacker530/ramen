# JSONに使われている座標のlat,lng(緯度、経度)の
#　CSV形式で出力します。（重複無し） 
# ヘッダーなしでCSVを出力する場合（デフォルト）：
# ruby json2latlng.rb < input.json
#
# ヘッダー付きでCSVを出力する場合：
# ruby json2latlng.rb --header < input.json

require 'json'
require 'csv'
require 'set'

def extract_coordinates(json_string)
  coordinates = Set.new
  json_data = JSON.parse(json_string)
  json_data.each do |item|
    if item["latLngs"]
      item["latLngs"].each do |latlng|
        coordinates.add([latlng["lat"], latlng["lng"]])
      end
    end
  end
  coordinates.to_a
end

# コマンドライン引数を解析
include_header = ARGV.include?('--header')

# 標準入力からJSONデータを読み込む
json_string = $stdin.read
coordinates = extract_coordinates(json_string)

# 結果をCSV形式で出力
CSV($stdout) do |csv|
  csv << ["lat", "lng"] if include_header
  coordinates.each do |coord|
    csv << coord
  end
end