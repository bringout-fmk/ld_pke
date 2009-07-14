require 'rubygems'
require 'xml'

xml_name = 'output.xml'
xml_document = XML::Document.file(xml_name)

schema_name = 'specif_pke.xsd'
schema_document = XML::Document.file(schema_name)
schema = XML::Schema.document(schema_document)

xml_document.validate_schema(schema)

