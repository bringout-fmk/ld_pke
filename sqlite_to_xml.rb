require 'rubygems'
require 'xml'
require 'sqlite3'
require 'date'


# provjeri maticni broj
def check_jib( jib, ime )
	if ( jib.length < 13 )
		puts "Greska: (JIB) " + jib + "(" + jib.length.to_s + ") - " + ime
	end
	return jib
end

# konverzija podatka o telefonu
def convert_tel( val )
	
	min_len = 13
	prefix = '387'
	pozivni_def = '32'
	pozivni_null = '00'
	temp = val.to_s.strip
	
	# ako je uneseno 0, onda formiraj ispravnu vrijednost
	if ( temp == '0' )
		return (prefix + '-' + pozivni_null + '-000000').rjust(min_len)
	end
	
	# ako je uneseno sa pozivnim brojem
	if ( temp.length == 8 )
		
		a = temp
		_poz = a[ 0, 2 ]
		_broj = a[ 2, 7 ]

		return (prefix + '-' + _poz + '-' + _broj).rjust(min_len)
	end

	ret = prefix + '-' + pozivni_def + '-' + temp
	
	return ret.rjust(min_len)
end

# konvertovanje bool vrijednosti za xml
def convert_true( val )
	if ( val == 'D' )
		return true.to_s
	else
		return false.to_s
	end
end


# konverzija datuma
def convert_date( s_date )
	four_digit_date = '%Y%m%d'
	return Date.strptime( s_date.to_s , four_digit_date ).to_s
end


s_init = <<END_OF_STRING
<SpecifikacijaZahtjevaZaIzdavanjePorezneKartice xsi:schemaLocation="urn:SpecifikacijaZahtjevaZaIzdavanjePorezneKartice_V1_0.xsd SpecifikacijaZahtjevaZaIzdavanjePorezneKartice_V1_0.xsd" xmlns="urn:SpecifikacijaZahtjevaZaIzdavanjePorezneKartice_V1_0.xsd" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
</SpecifikacijaZahtjevaZaIzdavanjePorezneKartice>
END_OF_STRING

doc = XML::Document.string(s_init, :encoding => XML::Encoding::UTF_8, :options => XML::Parser::Options::NOENT )

# :base_uri => "http://poreznaupravabih.org"
#	<PodaciOPoslodavcu>
#		<JIBPoslodavca>1901983170014</JIBPoslodavca>
#		<NazivPoslodavca>String</NazivPoslodavca>
#		<BrojZahtjeva>0</BrojZahtjeva>
#		<DatumPodnosenja>1967-08-13</DatumPodnosenja>
#	</PodaciOPoslodavcu>

puts "bring.out d.o.o Sarajevo"
puts "-------------------------"
puts "xml export, ver. 02.00"
puts "------------------------------------------------------------"


db = SQLite3::Database.new("pk.sqlite3")
db.results_as_hash = true
osn_podaci = db.get_first_row( "select * from pk_radn" )
broj_zahtjeva = db.get_first_value( "select count(*) from pk_radn" )
jib_firme = osn_podaci['p_jib'].to_s

puts "ukupni broj zahtjeva za obradu: " + broj_zahtjeva.to_s
puts "JIB firme: " + jib_firme.to_s
puts ""
puts ""

node_podaci_poslodavac = XML::Node.new('PodaciOPoslodavcu')

sub_nodes = [
   XML::Node.new('JIBPoslodavca', osn_podaci['p_jib']),
   XML::Node.new('NazivPoslodavca', osn_podaci['p_naziv']),
   XML::Node.new('BrojZahtjeva', broj_zahtjeva ),
   XML::Node.new('DatumPodnosenja', '2009-07-01')
]

sub_nodes.each do |sub| 
  node_podaci_poslodavac << sub
end

doc.root << node_podaci_poslodavac

#<Obrazac1001>

 #<Dio1PodaciOPoreznomObvezniku>
 #	<Prezime>String</Prezime>
 #	<Ime>String</Ime>
 #	<ImeJednogRoditelja>String</ImeJednogRoditelja>
 #	<JMB>1901983170014</JMB>
 #	<AdresaPrebivalista>String</AdresaPrebivalista>
 #	<OpcinaPrebivalistaNaziv>String</OpcinaPrebivalistaNaziv>
 #	<OpcinaPrebivalistaKod>String</OpcinaPrebivalistaKod>
 #	<DatumRodjenja>1967-08-13</DatumRodjenja>
 #	<Telefon>000-00-000000</Telefon>
 #</Dio1PodaciOPoreznomObvezniku>

 #<Dio2PodaciOPoslodavcu>
 #	<NazivPoslodavca>String</NazivPoslodavca>
 #	<JIB_JMBPoslodavca>0000000000000</JIB_JMBPoslodavca>
 #	<Zaposlen>true</Zaposlen>
 #</Dio2PodaciOPoslodavcu>

 #<Dio3PodaciOLicnimOdbicima>
 #	<OsnovniLicniOdbitak>1.000</OsnovniLicniOdbitak>
 #	<OdbiciZaIzdrzavanogBracnogDruga>0.000</OdbiciZaIzdrzavanogBracnogDruga>
 #	<UkupanOdbitakZaIzdzavanuDjecu>0.000</UkupanOdbitakZaIzdzavanuDjecu>
 #	<UkupanOdbitakZaIzdzavaneClanovePorodice>0.000</UkupanOdbitakZaIzdzavaneClanovePorodice>
 #	<UkupanOdbitakZaIzdzavaneClanovePorodiceSaInvaliditetom>0.000</UkupanOdbitakZaIzdzavaneClanovePorodiceSaInvaliditetom>
 #	<UkupanFaktorLicnogOdbitka>0.000</UkupanFaktorLicnogOdbitka>
 #</Dio3PodaciOLicnimOdbicima>

 #<Dio4PodaciOIzdrzavanomBracnomDugu>
 #	<PrezimeIIme>String</PrezimeIIme>
 #	<JMB>0000000000000</JMB>
 #	<VlastitiPrihod>0.00</VlastitiPrihod>
 #	<UdioUIzdrzavanju>0</UdioUIzdrzavanju>
 #	<KoeficijentOdbitka>0.000</KoeficijentOdbitka>
 #</Dio4PodaciOIzdrzavanomBracnomDugu>

 #<Dio5PodaciOIzdrzavanojDjeci>

 #<PodaciOIzdrzavanojDjeci>
 #	<PrezimeIIme>String</PrezimeIIme>
 #	<JMB>0000000000000</JMB>
 #	<VlastitiPrihod>0.00</VlastitiPrihod>
 #	<UdioUIzdrzavanju>0</UdioUIzdrzavanju>
 #	<KoeficijentOdbitka>0.000</KoeficijentOdbitka>
 #</PodaciOIzdrzavanojDjeci>

 # .....

 #</Dio5PodaciOIzdrzavanojDjeci>

 #<Dio6PodaciOIzdrzavanimClanovimaUzePorodice>

 #<PodaciOIzdrzavanimClanovimaUzePorodice>
 #	<PrezimeIIme>String</PrezimeIIme>
 #	<JMB>0000000000000</JMB>
 #	<SrodstvoSaPoreznimObveznikomNaziv>String</SrodstvoSaPoreznimObveznikomNaziv>
 #	<SrodstvoSaPoreznimObveznikomKod>String</SrodstvoSaPoreznimObveznikomKod>
 #	<VlastitiPrihod>0.00</VlastitiPrihod>
 #	<UdioUIzdrzavanju>0</UdioUIzdrzavanju>
 #	<KoeficijentOdbitka>0.300</KoeficijentOdbitka>
 #</PodaciOIzdrzavanimClanovimaUzePorodice>

 # .....

 #</Dio6PodaciOIzdrzavanimClanovimaUzePorodice>

 #<Dio7PodaciOIzdrzavanimClanovimaUzePorodiceSaInvaliditetom>

 #<PodaciOIzdrzavanimClanovimaUzePorodiceSaInvaliditetom>
 #	<PrezimeIIme>String</PrezimeIIme>
 #	<JMB>0000000000000</JMB>
 #	<SrodstvoSaPoreznimObveznikomNaziv>String</SrodstvoSaPoreznimObveznikomNaziv>
 #	<SrodstvoSaPoreznimObveznikomKod>String</SrodstvoSaPoreznimObveznikomKod>
 #	<VlastitiPrihod>0.00</VlastitiPrihod>
 #	<UdioUIzdrzavanju>0</UdioUIzdrzavanju>
 #	<KoeficijentOdbitka>0.300</KoeficijentOdbitka>
 #</PodaciOIzdrzavanimClanovimaUzePorodiceSaInvaliditetom>

 # ....

 #</Dio7PodaciOIzdrzavanimClanovimaUzePorodiceSaInvaliditetom>

 #<Dio8IzjavaPoreznogObveznika>
 #	<VaziOd>1967-08-13</VaziOd>
 #</Dio8IzjavaPoreznogObveznika>

#</Obrazac1001>

db = SQLite3::Database.new("pk.sqlite3")
db.results_as_hash = true
all_rows = db.execute( "select * from pk_radn" )

all_rows.each do |rows|
	
	node_obrazac = XML::Node.new('Obrazac1001')
	

	# dio 1: podaci o poreskom obvezniku
	node_dio_1 = XML::Node.new('Dio1PodaciOPoreznomObvezniku')
	sub_nodes_dio_1 = [
   		XML::Node.new('Prezime', rows['r_prez'] ),
   		XML::Node.new('Ime', rows['r_ime'] ),
   		XML::Node.new('ImeJednogRoditelja', rows['r_imeoca'] ),
   		XML::Node.new('JMB', check_jib(rows['r_jmb'], rows['r_prez'] + ' ' + rows['r_ime'] ) ),
   		XML::Node.new('AdresaPrebivalista', rows['r_adr'] ),
   		XML::Node.new('OpcinaPrebivalistaNaziv', rows['r_opc'] ),
   		XML::Node.new('OpcinaPrebivalistaKod', rows['r_opckod'] ),
   		XML::Node.new('DatumRodjenja', convert_date( rows['r_drodj'])),
   		XML::Node.new('Telefon', convert_tel( rows['r_tel'] ) )
	]
	
	sub_nodes_dio_1.each do |sub_1| 
		node_dio_1 << sub_1
	end

	# dio 2: podaci o poslodavcu
	node_dio_2 = XML::Node.new('Dio2PodaciOPoslodavcu')
	sub_nodes_dio_2 = [
   		XML::Node.new('NazivPoslodavca', rows['p_naziv'] ),
   		XML::Node.new('JIB_JMBPoslodavca', rows['p_jib'] ),
   		XML::Node.new('Zaposlen', convert_true( rows['p_zap']) )
	]
	
	sub_nodes_dio_2.each do |sub_2| 
		node_dio_2 << sub_2
	end

	# dio 3: podaci o licnim odbicima
	node_dio_3 = XML::Node.new('Dio3PodaciOLicnimOdbicima')
	sub_nodes_dio_3 = [
   		XML::Node.new('OsnovniLicniOdbitak', rows['lo_osn'] ),
   		XML::Node.new('OdbiciZaIzdrzavanogBracnogDruga', rows['lo_brdr'] ),
   		XML::Node.new('UkupanOdbitakZaIzdzavanuDjecu', rows['lo_izdj'] ),
   		XML::Node.new('UkupanOdbitakZaIzdzavaneClanovePorodice', rows['lo_clp'] ),
   		XML::Node.new('UkupanOdbitakZaIzdzavaneClanovePorodiceSaInvaliditetom', rows['lo_clpi'] ),
   		XML::Node.new('UkupanFaktorLicnogOdbitka', rows['lo_ufakt'] )
	]
	
	sub_nodes_dio_3.each do |sub_3| 
		node_dio_3 << sub_3
	end


	# dio 4: podaci o bracnom drugu
	
	node_dio_4 = XML::Node.new('Dio4PodaciOIzdrzavanomBracnomDugu')
	br_drug_sql = db.execute("select * from pk_data where ident = :ident and idradn = :idradn", "ident" => "1", "idradn" => rows['idradn'] )
	
	i_nd4 = 0

	br_drug_sql.each do |br_dr|
		
		sub_nodes_dio_4 = [
   			XML::Node.new('PrezimeIIme', br_dr['ime_pr'] ),
   			XML::Node.new('JMB', check_jib( br_dr['jmb'], br_dr['ime_pr']) ),
   			XML::Node.new('VlastitiPrihod', br_dr['prihod'] ),
   			XML::Node.new('UdioUIzdrzavanju', br_dr['udio'] ),
   			XML::Node.new('KoeficijentOdbitka', br_dr['koef'] )
		]
		
		sub_nodes_dio_4.each do |sub_4| 
			node_dio_4 << sub_4
		end

		i_nd4 = i_nd4 + 1

	end

	# dio 5: podaci o izdrzavanoj djeci
	node_dio_5 = XML::Node.new('Dio5PodaciOIzdrzavanojDjeci')
	i_nd5 = 0
	izdr_djeca_sql  = db.execute("select * from pk_data where ident = :ident and idradn = :idradn", "ident" => "2", "idradn" => rows['idradn'] )
	izdr_djeca_sql.each do |iz_dj|
		
		node_dio_5_1 = XML::Node.new('PodaciOIzdrzavanojDjeci')
		
		sub_nodes_dio_5 = [
   			XML::Node.new('PrezimeIIme', iz_dj['ime_pr'] ),
   			XML::Node.new('JMB', check_jib(iz_dj['jmb'],iz_dj['ime_pr']) ),
   			XML::Node.new('VlastitiPrihod', iz_dj['prihod'] ),
   			XML::Node.new('UdioUIzdrzavanju', iz_dj['udio'] ),
   			XML::Node.new('KoeficijentOdbitka', iz_dj['koef'] )
		]
		
		sub_nodes_dio_5.each do |sub_5| 
			node_dio_5_1 << sub_5
		end

		node_dio_5 << node_dio_5_1

		i_nd5 = i_nd5 + 1
	end
	
	#node_dio_5 << node_dio_5_1


	# dio 6: podaci o izdrzavananim clanovima porodice
	node_dio_6 = XML::Node.new('Dio6PodaciOIzdrzavanimClanovimaUzePorodice')
	i_nd6 = 0
	cl_por_sql  = db.execute("select * from pk_data where ident = :ident and idradn = :idradn", "ident" => "3", "idradn" => rows['idradn'] )
	cl_por_sql.each do |cl_p|
		
		node_dio_6_1 = XML::Node.new('PodaciOIzdrzavanimClanovimaUzePorodice')
		
		sub_nodes_dio_6 = [
   			XML::Node.new('PrezimeIIme', cl_p['ime_pr'] ),
   			XML::Node.new('JMB', check_jib(cl_p['jmb'],cl_p['ime_pr']) ),
   			XML::Node.new('SrodstvoSaPoreznimObveznikomNaziv', cl_p['sr_naz'] ),
   			XML::Node.new('SrodstvoSaPoreznimObveznikomKod', cl_p['sr_kod'] ),
   			XML::Node.new('VlastitiPrihod', cl_p['prihod'] ),
   			XML::Node.new('UdioUIzdrzavanju', cl_p['udio'] ),
   			XML::Node.new('KoeficijentOdbitka', cl_p['koef'] )
		]

		sub_nodes_dio_6.each do |sub_6| 
			node_dio_6_1 << sub_6
		end
		
		node_dio_6 << node_dio_6_1

		i_nd6 = i_nd6 + 1
	end
	
	#node_dio_6 << node_dio_6_1

	# dio 7: podaci o izdrzavananim clanovima porodice sa invaliditetom
	node_dio_7 = XML::Node.new('Dio7PodaciOIzdrzavanimClanovimaUzePorodiceSaInvaliditetom')
	i_nd7 = 0
	cl_pori_sql  = db.execute("select * from pk_data where ident = :ident and idradn = :idradn", "ident" => "4", "idradn" => rows['idradn'] )
	cl_pori_sql.each do |cl_pi|
		
		node_dio_7_1 = XML::Node.new('PodaciOIzdrzavanimClanovimaUzePorodiceSaInvaliditetom')
		
		sub_nodes_dio_7 = [
   			XML::Node.new('PrezimeIIme', cl_pi['ime_pr'] ),
   			XML::Node.new('JMB', check_jib(cl_pi['jmb'],cl_pi['ime_pr']) ),
   			XML::Node.new('SrodstvoSaPoreznimObveznikomNaziv', cl_pi['sr_naz'] ),
   			XML::Node.new('SrodstvoSaPoreznimObveznikomKod', cl_pi['sr_kod'] ),
   			XML::Node.new('VlastitiPrihod', cl_pi['prihod'] ),
   			XML::Node.new('UdioUIzdrzavanju', cl_pi['udio'] ),
   			XML::Node.new('KoeficijentOdbitka', cl_pi['koef'] )
		]

		sub_nodes_dio_7.each do |sub_7| 
			node_dio_7_1 << sub_7
		end

		node_dio_7 << node_dio_7_1

		i_nd7 = i_nd7 + 1
	end
	
	
	# dio 8: izjava
	node_dio_8 = XML::Node.new('Dio8IzjavaPoreznogObveznika')
	sub_nodes_dio_8 = [
   		XML::Node.new('VaziOd', convert_date( rows['datum'] ) )
	]
	
	sub_nodes_dio_8.each do |sub_8| 
		node_dio_8 << sub_8
	end

	# zapisi nodove sve u node_obrazac
	node_obrazac << node_dio_1
	node_obrazac << node_dio_2
	node_obrazac << node_dio_3
	
	# za naredne tipove se uvijek provjerava da li ima podataka 
	
	# debug varijable, setuj 1 ako zelis da uvijek upise
	#i_nd4 = 1
	#i_nd5 = 1
	#i_nd6 = 1
	#i_nd7 = 1

	if ( i_nd4 > 0 )
		node_obrazac << node_dio_4
	end
	if ( i_nd5 > 0 )
		node_obrazac << node_dio_5
	end
	if ( i_nd6 > 0 )
		node_obrazac << node_dio_6
	end
	if ( i_nd7 > 0 )
		node_obrazac << node_dio_7
	end

	node_obrazac << node_dio_8

	# zapisi u doc.root < node_obrazac
	doc.root << node_obrazac

end

puts "-----------------------------"
puts "snimam dokument ..."

# snimi dokument u tekuci direktorij
doc.save( jib_firme + '.xml' )

# napravi validaciju

puts ""
puts "validacija xml dokumenta"
puts "---------------------------------------------------------------"
puts ""

xml_name = jib_firme + '.xml'
xml_document = XML::Document.file(xml_name)

schema_name = 'specif_pke.xsd'
schema_document = XML::Document.file(schema_name)
schema = XML::Schema.document(schema_document)

# izvrsi validaciju
begin
	xml_document.validate_schema(schema) 
rescue Exception=>ex
	
	# Save to a file.
	aFile = File.new( jib_firme + '.txt', 'w')
	aFile.write(ex)
	aFile.close

end

puts ""
puts "Ako postoje greske treba ih pregledati !"

gets


