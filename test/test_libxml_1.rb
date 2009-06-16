require 'rubygems'
require 'xml'

#doc = XML::Document.string("<?xml version="1.0"?>", :encoding => XML::Encoding::UTF_8, :options => XML::Parser::Options::NOENT, :base_uri => "http://poreznaupravabih.org")

s_init = <<END_OF_STRING
<SpecifikacijaZahtjevaZaIzdavanjePorezneKartice/>
END_OF_STRING


doc = XML::Document.string(s_init, :encoding => XML::Encoding::UTF_8, :options => XML::Parser::Options::NOENT)

# :base_uri => "http://poreznaupravabih.org"


#	<PodaciOPoslodavcu>
#		<JIBPoslodavca>1901983170014</JIBPoslodavca>
#		<NazivPoslodavca>String</NazivPoslodavca>
#		<BrojZahtjeva>0</BrojZahtjeva>
#		<DatumPodnosenja>1967-08-13</DatumPodnosenja>
#	</PodaciOPoslodavcu>
	

node_1 = XML::Node.new('PodaciOPoslodavcu')

sub_nodes = [
   XML::Node.new('JIBPoslodavca', 'bring.out'),
   XML::Node.new('BrojZahtjeva', '199'),
   XML::Node.new('DatumPodnosenja', '2009-06-05')
]

sub_nodes.each do |sub| 
  node_1 << sub
end
doc.root << node_1

node_1 = XML::Node.new('Obrazac1001')
doc.root << node_1


puts doc.to_s
