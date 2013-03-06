#!/usr/bin/env ruby

# baseDir = '../modules'
# modules =  Dir["#{baseDir}/*"].map { |a| File.basename(a) }

# Dir.mkdir("dot") if  !File.directory? "dot"


# for mod in modules

# 	Dir.glob("#{baseDir}/#{mod}/manifests/*.pp") do |manifest|
# 		puts "creating dot for: #{manifest}"
# 		Dir.mkdir("dot/#{mod}") if  !File.directory? "dot/#{mod}"

# 		` puppet apply --noop --graph --graphdir #{mod}  #{manifest} `
# 	end


# 	`dot -Tpng #{mod}/resources.dot -o #{mod}_resources.png`
# 	`dot -Tpng #{mod}/relationships.dot -o #{mod}_relationships.png`
# 	`dot -Tpng #{mod}/expanded_relationships.dot -o #{mod}_expanded_relationships.png`

# end
# puts
# puts "Generated: "
# puts  `ls -lR *.png | awk {'print "     " $9'}`
# puts

# The above scripts don't generate propertly..  

# The below will work if you keep the --graph and --graphdir /vagrant/graphs option in the vagrant file. 


`dot -Tpng resources.dot -o resources.png`
`dot -Tpng relationships.dot -o relationships.png`
`dot -Tpng expanded_relationships.dot -o expanded_relationships.png`


puts
puts "Generated: "
puts  `ls -lR *.png | awk {'print "     " $9'}`
puts
