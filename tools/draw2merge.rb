require 'json'

def deep_merge(a, b)
  return b unless a.is_a?(Hash) && b.is_a?(Hash)
  a.merge(b) { |_, v1, v2| deep_merge(v1, v2) }
end

def merge_json_data(data1, data2)
  if data1.is_a?(Array) && data2.is_a?(Array)
    return data1 + data2
  elsif data1.is_a?(Hash) && data2.is_a?(Hash)
    return deep_merge(data1, data2)
  else
    return data2  # 異なる型の場合は後者を優先
  end
end

def merge_json_files(file_paths)
  merged_data = nil

  file_paths.each do |file_path|
    begin
      file_content = File.read(file_path)
      json_data = JSON.parse(file_content)
      if merged_data.nil?
        merged_data = json_data
      else
        merged_data = merge_json_data(merged_data, json_data)
      end
    rescue JSON::ParserError => e
      STDERR.puts "Error parsing JSON in file #{file_path}: #{e.message}"
    rescue Errno::ENOENT => e
      STDERR.puts "Error reading file #{file_path}: #{e.message}"
    end
  end

  merged_data
end

# コマンドライン引数からファイル名を取得
json_files = ARGV

if json_files.empty?
  STDERR.puts "使用方法: ruby #{$PROGRAM_NAME} <file1.json> <file2.json> ..."
  STDERR.puts "少なくとも1つのJSONファイルを指定してください。"
  exit 1
end

# ファイルをマージ
merged_result = merge_json_files(json_files)

# 結果を標準出力に表示
puts JSON.pretty_generate(merged_result)