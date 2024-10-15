require 'json'

# 標準入力からJSONデータを読み込む
json_data = STDIN.read

begin
  # JSONデータをパースする
  data = JSON.parse(json_data)

  # color要素をdodgerblueに変換する
  data.each do |item|
    if item.is_a?(Hash) && item.key?('color')
      item['color'] = 'dodgerblue'
    end
  end

  # 変換後のJSONデータを標準出力に出力する
  puts JSON.pretty_generate(data)

rescue JSON::ParserError => e
  # JSONのパースエラーが発生した場合の処理
  STDERR.puts "JSONのパースエラー: #{e.message}"
end