
find = ARGV[0]
index = eval IO.popen('cat katas/index.rb').read
ids = index.map{|e| e[:uuid]}
ids.each do |id|
  inner_dir = id[0..1]   
  outer_dir = id[2..9]
  kata_dir = "katas/#{inner_dir}/#{outer_dir}"
  manifest = eval IO.popen("cat #{kata_dir}/manifest.rb").read
  if manifest[:name] == find
    print find + ' --> /katas/' + inner_dir + '/' + outer_dir + "\r\n"
  end
end


