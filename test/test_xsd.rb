# * 
# * This file is part of the bring.out FMK, a free and open source 
# * accounting software suite,
# * Copyright (c) 1996-2011 by bring.out doo Sarajevo.
# * It is licensed to you under the Common Public Attribution License
# * version 1.0, the full text of which (including FMK specific Exhibits)
# * is available in the file LICENSE_CPAL_bring.out_FMK.md located at the 
# * root directory of this source code archive.
# * By using this software, you agree to be bound by its terms.
# *


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



