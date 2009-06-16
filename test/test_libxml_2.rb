require 'rubygems'
require 'xml'

#doc = XML::Document.string("<?xml version="1.0"?>", :encoding => XML::Encoding::UTF_8, :options => XML::Parser::Options::NOENT, :base_uri => "http://poreznaupravabih.org")

s_init = <<END_OF_STRING
<SpecifikacijaZahtjevaZaIzdavanjePorezneKartice xsi:schemaLocation="urn:SpecifikacijaZahtjevaZaIzdavanjePorezneKartice_V1_0.xsd SpecifikacijaZahtjevaZaIzdavanjePorezneKartice_V1_0.xsd" xmlns="urn:SpecifikacijaZahtjevaZaIzdavanjePorezneKartice_V1_0.xsd" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<Obrazac1001>
		<Dio1PodaciOPoreznomObvezniku>
			<Prezime>String</Prezime>
			<Ime>String</Ime>
			<ImeJednogRoditelja>String</ImeJednogRoditelja>
			<JMB>1901983170014</JMB>
			<AdresaPrebivalista>String</AdresaPrebivalista>
			<OpcinaPrebivalistaNaziv>String</OpcinaPrebivalistaNaziv>
			<OpcinaPrebivalistaKod>String</OpcinaPrebivalistaKod>
			<DatumRodjenja>1967-08-13</DatumRodjenja>
			<Telefon>000-00-000000</Telefon>
		</Dio1PodaciOPoreznomObvezniku>
		<Dio2PodaciOPoslodavcu>
			<NazivPoslodavca>String</NazivPoslodavca>
			<JIB_JMBPoslodavca>0000000000000</JIB_JMBPoslodavca>
			<Zaposlen>true</Zaposlen>
		</Dio2PodaciOPoslodavcu>
		<Dio3PodaciOLicnimOdbicima>
			<OsnovniLicniOdbitak>1.000</OsnovniLicniOdbitak>
			<OdbiciZaIzdrzavanogBracnogDruga>0.000</OdbiciZaIzdrzavanogBracnogDruga>
			<UkupanOdbitakZaIzdzavanuDjecu>0.000</UkupanOdbitakZaIzdzavanuDjecu>
			<UkupanOdbitakZaIzdzavaneClanovePorodice>0.000</UkupanOdbitakZaIzdzavaneClanovePorodice>
			<UkupanOdbitakZaIzdzavaneClanovePorodiceSaInvaliditetom>0.000</UkupanOdbitakZaIzdzavaneClanovePorodiceSaInvaliditetom>
			<UkupanFaktorLicnogOdbitka>0.000</UkupanFaktorLicnogOdbitka>
		</Dio3PodaciOLicnimOdbicima>
		<Dio4PodaciOIzdrzavanomBracnomDugu>
			<PrezimeIIme>String</PrezimeIIme>
			<JMB>0000000000000</JMB>
			<VlastitiPrihod>0.00</VlastitiPrihod>
			<UdioUIzdrzavanju>0</UdioUIzdrzavanju>
			<KoeficijentOdbitka>0.000</KoeficijentOdbitka>
		</Dio4PodaciOIzdrzavanomBracnomDugu>
		<Dio5PodaciOIzdrzavanojDjeci>
			<PodaciOIzdrzavanojDjeci>
				<PrezimeIIme>String</PrezimeIIme>
				<JMB>0000000000000</JMB>
				<VlastitiPrihod>0.00</VlastitiPrihod>
				<UdioUIzdrzavanju>0</UdioUIzdrzavanju>
				<KoeficijentOdbitka>0.000</KoeficijentOdbitka>
			</PodaciOIzdrzavanojDjeci>
			<PodaciOIzdrzavanojDjeci>
				<PrezimeIIme>String</PrezimeIIme>
				<JMB>0000000000000</JMB>
				<VlastitiPrihod>0.00</VlastitiPrihod>
				<UdioUIzdrzavanju>0</UdioUIzdrzavanju>
				<KoeficijentOdbitka>0.000</KoeficijentOdbitka>
			</PodaciOIzdrzavanojDjeci>
			<PodaciOIzdrzavanojDjeci>
				<PrezimeIIme>String</PrezimeIIme>
				<JMB>0000000000000</JMB>
				<VlastitiPrihod>0.00</VlastitiPrihod>
				<UdioUIzdrzavanju>0</UdioUIzdrzavanju>
				<KoeficijentOdbitka>0.000</KoeficijentOdbitka>
			</PodaciOIzdrzavanojDjeci>
		</Dio5PodaciOIzdrzavanojDjeci>
		<Dio6PodaciOIzdrzavanimClanovimaUzePorodice>
			<PodaciOIzdrzavanimClanovimaUzePorodice>
				<PrezimeIIme>String</PrezimeIIme>
				<JMB>0000000000000</JMB>
				<SrodstvoSaPoreznimObveznikomNaziv>String</SrodstvoSaPoreznimObveznikomNaziv>
				<SrodstvoSaPoreznimObveznikomKod>String</SrodstvoSaPoreznimObveznikomKod>
				<VlastitiPrihod>0.00</VlastitiPrihod>
				<UdioUIzdrzavanju>0</UdioUIzdrzavanju>
				<KoeficijentOdbitka>0.300</KoeficijentOdbitka>
			</PodaciOIzdrzavanimClanovimaUzePorodice>
			<PodaciOIzdrzavanimClanovimaUzePorodice>
				<PrezimeIIme>String</PrezimeIIme>
				<JMB>0000000000000</JMB>
				<SrodstvoSaPoreznimObveznikomNaziv>String</SrodstvoSaPoreznimObveznikomNaziv>
				<SrodstvoSaPoreznimObveznikomKod>String</SrodstvoSaPoreznimObveznikomKod>
				<VlastitiPrihod>0.00</VlastitiPrihod>
				<UdioUIzdrzavanju>0</UdioUIzdrzavanju>
				<KoeficijentOdbitka>0.300</KoeficijentOdbitka>
			</PodaciOIzdrzavanimClanovimaUzePorodice>
			<PodaciOIzdrzavanimClanovimaUzePorodice>
				<PrezimeIIme>String</PrezimeIIme>
				<JMB>0000000000000</JMB>
				<SrodstvoSaPoreznimObveznikomNaziv>String</SrodstvoSaPoreznimObveznikomNaziv>
				<SrodstvoSaPoreznimObveznikomKod>String</SrodstvoSaPoreznimObveznikomKod>
				<VlastitiPrihod>0.00</VlastitiPrihod>
				<UdioUIzdrzavanju>0</UdioUIzdrzavanju>
				<KoeficijentOdbitka>0.300</KoeficijentOdbitka>
			</PodaciOIzdrzavanimClanovimaUzePorodice>
		</Dio6PodaciOIzdrzavanimClanovimaUzePorodice>
		<Dio7PodaciOIzdrzavanimClanovimaUzePorodiceSaInvaliditetom>
			<PodaciOIzdrzavanimClanovimaUzePorodiceSaInvaliditetom>
				<PrezimeIIme>String</PrezimeIIme>
				<JMB>0000000000000</JMB>
				<SrodstvoSaPoreznimObveznikomNaziv>String</SrodstvoSaPoreznimObveznikomNaziv>
				<SrodstvoSaPoreznimObveznikomKod>String</SrodstvoSaPoreznimObveznikomKod>
				<VlastitiPrihod>0.00</VlastitiPrihod>
				<UdioUIzdrzavanju>0</UdioUIzdrzavanju>
				<KoeficijentOdbitka>0.300</KoeficijentOdbitka>
			</PodaciOIzdrzavanimClanovimaUzePorodiceSaInvaliditetom>
			<PodaciOIzdrzavanimClanovimaUzePorodiceSaInvaliditetom>
				<PrezimeIIme>String</PrezimeIIme>
				<JMB>0000000000000</JMB>
				<SrodstvoSaPoreznimObveznikomNaziv>String</SrodstvoSaPoreznimObveznikomNaziv>
				<SrodstvoSaPoreznimObveznikomKod>String</SrodstvoSaPoreznimObveznikomKod>
				<VlastitiPrihod>0.00</VlastitiPrihod>
				<UdioUIzdrzavanju>0</UdioUIzdrzavanju>
				<KoeficijentOdbitka>0.300</KoeficijentOdbitka>
			</PodaciOIzdrzavanimClanovimaUzePorodiceSaInvaliditetom>
			<PodaciOIzdrzavanimClanovimaUzePorodiceSaInvaliditetom>
				<PrezimeIIme>String</PrezimeIIme>
				<JMB>0000000000000</JMB>
				<SrodstvoSaPoreznimObveznikomNaziv>String</SrodstvoSaPoreznimObveznikomNaziv>
				<SrodstvoSaPoreznimObveznikomKod>String</SrodstvoSaPoreznimObveznikomKod>
				<VlastitiPrihod>0.00</VlastitiPrihod>
				<UdioUIzdrzavanju>0</UdioUIzdrzavanju>
				<KoeficijentOdbitka>0.300</KoeficijentOdbitka>
			</PodaciOIzdrzavanimClanovimaUzePorodiceSaInvaliditetom>
		</Dio7PodaciOIzdrzavanimClanovimaUzePorodiceSaInvaliditetom>
		<Dio8IzjavaPoreznogObveznika>
			<VaziOd>1967-08-13</VaziOd>
		</Dio8IzjavaPoreznogObveznika>
	</Obrazac1001>
</SpecifikacijaZahtjevaZaIzdavanjePorezneKartice>
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


puts doc.to_s
