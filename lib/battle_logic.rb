lib_files = Dir[File.dirname(__FILE__) + '/battle_logic/*.rb']
lib_files.map do |file|
  File.basename(file, File.extname(file))
end.each do |file|
  require "battle_logic/#{file}"
end
