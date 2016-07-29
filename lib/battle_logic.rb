lib_files = Dir[File.dirname(__FILE__) + '/battle_logic/*.rb']
lib_paths = lib_files.map { |file|
  File.basename(file, File.extname(file))
}
lib_paths.each do |file|
  require "battle_logic/#{file}"
end
