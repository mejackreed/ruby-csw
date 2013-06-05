$: << File.join(File.dirname(__FILE__), '../lib')

require 'rcsw'

client = RCSW::Client::Base.new('http://seakgis03.alaska.edu/geoportal/csw')

# 
# client.capabilities.operations.each do |op|
#   puts op.name
#   puts "\t#{op.parameters.collect(&:name)}"
# end

# puts client.capabilities.operations.collect(&:name)

puts client.records.count
puts client.records.count

client.clear!

puts client.records