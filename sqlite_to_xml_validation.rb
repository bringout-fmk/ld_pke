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

xml_name = 'output.xml'
xml_document = XML::Document.file(xml_name)

schema_name = 'specif_pke.xsd'
schema_document = XML::Document.file(schema_name)
schema = XML::Schema.document(schema_document)

xml_document.validate_schema(schema)

