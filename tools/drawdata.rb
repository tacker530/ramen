#
# Class for iitc drawing data
#
#  Draw JSONを読み込んでKMLに変換する
#
require 'json'
require 'csv'


class Drawdata
  attr_accessor :data

  def initialize
  end

  # JSONを読み込む
  def load(json_file_path)
    # パスが未設定ならnil
    return nil if json_file_path == ""
    File.open(json_file_path) do |j|
      self.data = JSON.load(j)
    end
  end

  # 情報をダンプする
  def dump
    self.data.each_with_index do |item,i|
      puts "= [ #{i} ] ============================================================"
      pp item
    end
    puts "= [ END ] ============================================================"
  end

  
  # 情報をダンプする
  def kml
    puts "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
    puts "<kml xmlns=\"http://earth.google.com/kml/2.0\"> <Document>"

    self.data.each_with_index do |item,i|
      #pp item
      puts "<Placemark>" 

      puts "<LineString><coordinates>"
      first_portal = ""
      # リンク順に出力する
      item['latLngs'].each_with_index do |link,idx|
        # リンク順にポータルの情報を出力する
        puts "#{link['lng']},#{link['lat']},0."
        # ポリゴンの場合は最初のポータルを保存して最後に付け加える（一回りする最後のリンクのため）
        if idx == 0 
          first_portal = "#{link['lng']},#{link['lat']},0."
        end        
      end

      # ポリゴンを閉じるポータルを追加、Lineならば追加しない
      puts first_portal if item['type']=="polygon"

      puts "</coordinates></LineString>"
      puts "</Placemark>" 
    end

    puts "</Document>" 
    puts "</kml>"

  end

end