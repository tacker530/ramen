##
# latlng -> portalname 
#
# [説明]
#　36.561217,136.656459 のような緯度経度の情報を標準入力から受け取り、ポータル名を設定して標準出力に返す処理
#  36.561217,136.656459,金沢市役所
# [Usage]
#    ruby draw2latlng.rb amabie_draw.txt  | ruby latlng2name.rb kanazawa-all.csv 
#

require 'csv'
require "date"

# 第一段階として、ポータルのマスタとなるCSVデータを読み込みます。
# これは第一引数をCSVファイルとして扱います。
# CSVは　portalname,lat,long　の順番を想定してます。
mst = Hash.new
#　マスタになるCSVを取り込む
CSV.foreach(ARGV[0], encoding: "UTF-8:UTF-8") do |row|
  key = "#{row[0].strip}_#{row[1].strip}"   # キーはlat & lng
  mst[key] = row[2]             # 値はポータル名
end

# 第二段階として標準入力からJSONから抽出したポータル一覧を取得します。
# ハッシュにするためこの時点で重複データはユニークになります

trn = Hash.new
$stdin.each do |row|
  #print "row = #{row}"
  w = row.chop.split(",")
  key = "#{w[0].strip}_#{w[1].strip}"   # キーはlat & lng
  trn[key] = "#{w[0].strip},#{w[1].strip}"
end

# 緯度経度でソート（南から北、西から東）
sorted_trn = Hash[trn.sort]

#　第三段階で　JSON側の緯度経度をキーとしてポータル一覧の
#  hashからポータル名を取り出します。 
#
sorted_trn.each do |key,value|
  print "#{value},#{mst.has_key?(key) ? mst[key] : 'NONE'}\n"
end

