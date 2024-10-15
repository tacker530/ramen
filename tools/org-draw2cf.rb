require 'json'

# ポリライン間の共通点を見つける関数
def common_point(poly1, poly2)
  poly1['latLngs'].find do |point1|
    poly2['latLngs'].any? { |point2| same_point?(point1, point2) }
  end
end

# 2点が同一かどうかをチェックする関数
def same_point?(point1, point2)
  point1['lat'] == point2['lat'] && point1['lng'] == point2['lng']
end

# 三角形を構成するかをチェックする関数
def is_triangle?(poly1, poly2, poly3)
  points = []
  
  [poly1, poly2, poly3].combination(2).each do |p1, p2|
    common = common_point(p1, p2)
    points << common if common
  end

  # 共通点が3つあれば三角形
  points.compact.uniq.size == 3
end

# 入力データの読み込み
input = JSON.parse(STDIN.read)

polylines = input.select { |item| item['type'] == 'polyline' }
triangles = []

# ポリラインを3つずつ組み合わせて、三角形を探す
polylines.combination(3).each do |poly1, poly2, poly3|
  if is_triangle?(poly1, poly2, poly3)
    # 三角形を構成する頂点を集める（ポリラインの接続のみを考慮）
    points = [poly1['latLngs'], poly2['latLngs'], poly3['latLngs']].flatten
    unique_points = points.uniq { |point| [point['lat'], point['lng']] }

    # 三角形をJSON形式で出力
    triangle = {
      type: 'polygon',
      latLngs: unique_points.map { |point| { lat: point['lat'], lng: point['lng'] } },
      color: 'dodgerblue'
    }

    triangles << triangle
  end
end

# 結果をJSON形式で標準出力
puts JSON.pretty_generate(triangles)
