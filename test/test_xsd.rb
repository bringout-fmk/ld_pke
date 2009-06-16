require 'rubygems'
require 'xml'

x_name = 'test.xml'
#x_name = 'specif_pke.xml'
x_document = XML::Document.file(x_name)


s_document = XML::Document.file('specif_pke.xsd')
schema = XML::Schema.document(s_document)

#new_node = XML::Node.new('invalid', 'this will napraviti error kod validacije')

#dodaj node
#x_document.root.child_add(new_node)


puts x_document.to_s

puts "-"*100

x_document.validate_schema(schema)



