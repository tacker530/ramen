require 'csv'
require 'optparse'

def load_master_data(file_path)
  master_data = {}
  begin
    CSV.foreach(file_path, encoding: 'UTF-8') do |row|
      uuid, name, lat, lng = row
      master_data[[lat.to_f, lng.to_f]] = name
    end
  rescue CSV::MalformedCSVError => e
    handle_csv_error(e, file_path, "マスタファイル")
  end
  master_data
end

def process_csv(master_data, include_header)
  begin
    CSV($stdout) do |csv_out|
      csv_out << ['lat', 'lng', 'name'] if include_header
      CSV($stdin, encoding: 'UTF-8').each.with_index(1) do |row, line_num|
        lat, lng = row
        name = master_data[[lat.to_f, lng.to_f]] || '不明'
        csv_out << [lat, lng, name]
      end
    end
  rescue CSV::MalformedCSVError => e
    handle_csv_error(e, "標準入力", "入力データ")
  end
end

def handle_csv_error(error, file_path, file_type)
  STDERR.puts "#{file_type}の処理中にエラーが発生しました:"
  STDERR.puts error.message
  STDERR.puts "問題のある行番号: #{error.lineno}" if error.respond_to?(:lineno)
  
  if file_path == "標準入力"
    STDERR.puts "標準入力からの問題のある行の内容を表示できません。"
  else
    begin
      problematic_line = File.readlines(file_path, encoding: 'UTF-8')[error.lineno - 1]
      STDERR.puts "問題のある行の内容: #{problematic_line.strip}"
    rescue => e
      STDERR.puts "問題のある行の内容を取得できませんでした: #{e.message}"
    end
  end

  exit 1
end

# オプションの解析
options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: cat input.csv | ruby script.rb [options] <master_file>"
  opts.on("--header", "Include header in output") do |v|
    options[:header] = v
  end
end.parse!

# 引数の確認
if ARGV.length != 1
  STDERR.puts "エラー: マスタファイルを指定してください。"
  STDERR.puts "使用方法: cat latlng2name.csv | ruby script.rb [--header] <master_file>"
  exit 1
end

master_file = ARGV[0]

# メイン処理
master_data = load_master_data(master_file)
process_csv(master_data, options[:header])