#!/usr/bin/env ruby

baseDir = '../modules'
modules =  Dir["#{baseDir}/*"].map { |a| File.basename(a) }

Dir.mkdir("dot") if  !File.directory? "dot"


for mod in modules

	Dir.glob("#{baseDir}/#{mod}/manifests/*.pp") do |manifest|
		puts "creating dot for: #{manifest}"
		Dir.mkdir("dot/#{mod}") if  !File.directory? "dot/#{mod}"

		` puppet apply --noop --graph --graphdir ./dot/#{mod}  #{manifest} `
	end


	`dot -Tpng ./dot/#{mod}/resources.dot -o #{mod}_resources.png`
	`dot -Tpng ./dot/#{mod}/relationships.dot -o #{mod}_relationships.png`
	`dot -Tpng ./dot/#{mod}/expanded_relationships.dot -o #{mod}_expanded_relationships.png`

end
puts
puts "Generated: "
puts  `ls -lR *.png | awk {'print "     " $9'}`
puts


