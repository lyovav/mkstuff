<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE eagle SYSTEM "eagle.dtd">
<eagle version="7.1.0">
<drawing>
<settings>
<setting alwaysvectorfont="no"/>
<setting verticaltext="up"/>
</settings>
<grid distance="0.1" unitdist="inch" unit="inch" style="lines" multiple="1" display="no" altdistance="0.01" altunitdist="inch" altunit="inch"/>
<layers>
<layer number="1" name="Top" color="4" fill="1" visible="no" active="no"/>
<layer number="16" name="Bottom" color="1" fill="1" visible="no" active="no"/>
<layer number="17" name="Pads" color="2" fill="1" visible="no" active="no"/>
<layer number="18" name="Vias" color="2" fill="1" visible="no" active="no"/>
<layer number="19" name="Unrouted" color="6" fill="1" visible="no" active="no"/>
<layer number="20" name="Dimension" color="15" fill="1" visible="no" active="no"/>
<layer number="21" name="tPlace" color="7" fill="1" visible="no" active="no"/>
<layer number="22" name="bPlace" color="7" fill="1" visible="no" active="no"/>
<layer number="23" name="tOrigins" color="15" fill="1" visible="no" active="no"/>
<layer number="24" name="bOrigins" color="15" fill="1" visible="no" active="no"/>
<layer number="25" name="tNames" color="7" fill="1" visible="no" active="no"/>
<layer number="26" name="bNames" color="7" fill="1" visible="no" active="no"/>
<layer number="27" name="tValues" color="7" fill="1" visible="no" active="no"/>
<layer number="28" name="bValues" color="7" fill="1" visible="no" active="no"/>
<layer number="29" name="tStop" color="7" fill="3" visible="no" active="no"/>
<layer number="30" name="bStop" color="7" fill="6" visible="no" active="no"/>
<layer number="31" name="tCream" color="7" fill="4" visible="no" active="no"/>
<layer number="32" name="bCream" color="7" fill="5" visible="no" active="no"/>
<layer number="33" name="tFinish" color="6" fill="3" visible="no" active="no"/>
<layer number="34" name="bFinish" color="6" fill="6" visible="no" active="no"/>
<layer number="35" name="tGlue" color="7" fill="4" visible="no" active="no"/>
<layer number="36" name="bGlue" color="7" fill="5" visible="no" active="no"/>
<layer number="37" name="tTest" color="7" fill="1" visible="no" active="no"/>
<layer number="38" name="bTest" color="7" fill="1" visible="no" active="no"/>
<layer number="39" name="tKeepout" color="4" fill="11" visible="no" active="no"/>
<layer number="40" name="bKeepout" color="1" fill="11" visible="no" active="no"/>
<layer number="41" name="tRestrict" color="4" fill="10" visible="no" active="no"/>
<layer number="42" name="bRestrict" color="1" fill="10" visible="no" active="no"/>
<layer number="43" name="vRestrict" color="2" fill="10" visible="no" active="no"/>
<layer number="44" name="Drills" color="7" fill="1" visible="no" active="no"/>
<layer number="45" name="Holes" color="7" fill="1" visible="no" active="no"/>
<layer number="46" name="Milling" color="3" fill="1" visible="no" active="no"/>
<layer number="47" name="Measures" color="7" fill="1" visible="no" active="no"/>
<layer number="48" name="Document" color="7" fill="1" visible="no" active="no"/>
<layer number="49" name="Reference" color="7" fill="1" visible="no" active="no"/>
<layer number="50" name="dxf" color="7" fill="1" visible="no" active="no"/>
<layer number="51" name="tDocu" color="10" fill="1" visible="no" active="no"/>
<layer number="52" name="bDocu" color="11" fill="1" visible="no" active="no"/>
<layer number="90" name="Modules" color="5" fill="1" visible="yes" active="yes"/>
<layer number="91" name="Nets" color="2" fill="1" visible="yes" active="yes"/>
<layer number="92" name="Busses" color="1" fill="1" visible="yes" active="yes"/>
<layer number="93" name="Pins" color="2" fill="1" visible="no" active="yes"/>
<layer number="94" name="Symbols" color="4" fill="1" visible="yes" active="yes"/>
<layer number="95" name="Names" color="7" fill="1" visible="yes" active="yes"/>
<layer number="96" name="Values" color="7" fill="1" visible="yes" active="yes"/>
<layer number="97" name="Info" color="7" fill="1" visible="yes" active="yes"/>
<layer number="98" name="Guide" color="6" fill="1" visible="yes" active="yes"/>
<layer number="200" name="200bmp" color="1" fill="10" visible="no" active="no"/>
<layer number="201" name="tNamesOnPCB" color="5" fill="1" visible="yes" active="yes"/>
<layer number="202" name="bNamesOnPCB" color="3" fill="1" visible="yes" active="yes"/>
</layers>
<schematic xreflabel="%F%N/%S.%C%R" xrefpart="/%S.%C%R">
<libraries>
<library name="atmel_tiny24-44-84tiny48-88mega48-88-168-328">
<description>Atmel MCUs:

&lt;p&gt;&lt;b&gt;ATmega48/88/168/328&lt;/b&gt; in variants AU, MU, PU
&lt;p&gt;&lt;b&gt;ATtiny24/44/84&lt;/b&gt; in variants SSU, PU, MU
&lt;p&gt;&lt;b&gt;ATtiny48/88&lt;/b&gt; in variants AU, MU, MMU, MMH, PU
&lt;p&gt;&lt;b&gt;AT89C51/52/...&lt;/b&gt;
&lt;p&gt;&lt;b&gt;AT89C1051/2052/4052&lt;/b&gt;

&lt;i&gt;&lt;p&gt;&lt;author&gt;Created by Ing. Miroslav Kovar @ soft&lt;/author&gt;</description>
<packages>
<package name="DIL28">
<wire x1="-17.78" y1="-6.35" x2="17.78" y2="-6.35" width="0.2" layer="21"/>
<wire x1="17.78" y1="-6.35" x2="17.78" y2="6.35" width="0.2" layer="21"/>
<wire x1="17.78" y1="6.35" x2="-17.78" y2="6.35" width="0.2" layer="21"/>
<wire x1="-17.78" y1="6.35" x2="-17.78" y2="1.27" width="0.2" layer="21"/>
<wire x1="-17.78" y1="1.27" x2="-16.51" y2="1.27" width="0.2" layer="21"/>
<wire x1="-16.51" y1="1.27" x2="-16.51" y2="-1.27" width="0.2" layer="21"/>
<wire x1="-16.51" y1="-1.27" x2="-17.78" y2="-1.27" width="0.2" layer="21"/>
<wire x1="-17.78" y1="-1.27" x2="-17.78" y2="-6.35" width="0.2" layer="21"/>
<pad name="1" x="-16.51" y="-7.62" drill="0.889" diameter="1.524" shape="square"/>
<pad name="2" x="-13.97" y="-7.62" drill="0.889" diameter="1.524" shape="octagon"/>
<pad name="3" x="-11.43" y="-7.62" drill="0.889" diameter="1.524" shape="octagon"/>
<pad name="4" x="-8.89" y="-7.62" drill="0.889" diameter="1.524" shape="octagon"/>
<pad name="5" x="-6.35" y="-7.62" drill="0.889" diameter="1.524" shape="octagon"/>
<pad name="6" x="-3.81" y="-7.62" drill="0.889" diameter="1.524" shape="octagon"/>
<pad name="7" x="-1.27" y="-7.62" drill="0.889" diameter="1.524" shape="octagon"/>
<pad name="8" x="1.27" y="-7.62" drill="0.889" diameter="1.524" shape="octagon"/>
<pad name="9" x="3.81" y="-7.62" drill="0.889" diameter="1.524" shape="octagon"/>
<pad name="10" x="6.35" y="-7.62" drill="0.889" diameter="1.524" shape="octagon"/>
<pad name="11" x="8.89" y="-7.62" drill="0.889" diameter="1.524" shape="octagon"/>
<pad name="12" x="11.43" y="-7.62" drill="0.889" diameter="1.524" shape="octagon"/>
<pad name="13" x="13.97" y="-7.62" drill="0.889" diameter="1.524" shape="octagon"/>
<pad name="14" x="16.51" y="-7.62" drill="0.889" diameter="1.524" shape="octagon"/>
<pad name="15" x="16.51" y="7.62" drill="0.889" diameter="1.524" shape="octagon"/>
<pad name="16" x="13.97" y="7.62" drill="0.889" diameter="1.524" shape="octagon"/>
<pad name="17" x="11.43" y="7.62" drill="0.889" diameter="1.524" shape="octagon"/>
<pad name="18" x="8.89" y="7.62" drill="0.889" diameter="1.524" shape="octagon"/>
<pad name="19" x="6.35" y="7.62" drill="0.889" diameter="1.524" shape="octagon"/>
<pad name="20" x="3.81" y="7.62" drill="0.889" diameter="1.524" shape="octagon"/>
<pad name="21" x="1.27" y="7.62" drill="0.889" diameter="1.524" shape="octagon"/>
<pad name="22" x="-1.27" y="7.62" drill="0.889" diameter="1.524" shape="octagon"/>
<pad name="23" x="-3.81" y="7.62" drill="0.889" diameter="1.524" shape="octagon"/>
<pad name="24" x="-6.35" y="7.62" drill="0.889" diameter="1.524" shape="octagon"/>
<pad name="25" x="-8.89" y="7.62" drill="0.889" diameter="1.524" shape="octagon"/>
<pad name="26" x="-11.43" y="7.62" drill="0.889" diameter="1.524" shape="octagon"/>
<pad name="27" x="-13.97" y="7.62" drill="0.889" diameter="1.524" shape="octagon"/>
<pad name="28" x="-16.51" y="7.62" drill="0.889" diameter="1.524" shape="octagon"/>
<text x="-13.97" y="1.27" size="1.524" layer="25">&gt;NAME</text>
<text x="-13.97" y="-3.175" size="1.524" layer="27">&gt;VALUE</text>
<text x="-18.0975" y="-6.35" size="1.27" layer="201" font="vector" ratio="12" rot="R90">&gt;NAME</text>
</package>
</packages>
<symbols>
<symbol name="ATMEGA48/88/168/328-PU(DIP28)">
<wire x1="-30.48" y1="22.86" x2="30.48" y2="22.86" width="0.254" layer="94"/>
<wire x1="30.48" y1="22.86" x2="30.48" y2="-22.86" width="0.254" layer="94"/>
<wire x1="30.48" y1="-22.86" x2="-30.48" y2="-22.86" width="0.254" layer="94"/>
<wire x1="-30.48" y1="-22.86" x2="-30.48" y2="22.86" width="0.254" layer="94"/>
<pin name="PB5(SCK/PCINT5)" x="-33.02" y="7.62" length="short" swaplevel="1"/>
<pin name="PB7(XTAL2/TOSC2/PCINT7)" x="-33.02" y="2.54" length="short" swaplevel="1"/>
<pin name="PB6(XTAL1/TOSC1/PCINT6)" x="-33.02" y="5.08" length="short" swaplevel="1"/>
<pin name="AREF" x="33.02" y="-12.7" length="short" direction="pas" rot="R180"/>
<pin name="AVCC" x="33.02" y="-10.16" length="short" direction="pwr" rot="R180"/>
<pin name="PB4(MISO/PCINT4)" x="-33.02" y="10.16" length="short" swaplevel="1"/>
<pin name="PB3(MOSI/OC2A/PCINT3)" x="-33.02" y="12.7" length="short" swaplevel="1"/>
<pin name="PB2(SS/OC1B/PCINT2)" x="-33.02" y="15.24" length="short" swaplevel="1"/>
<pin name="PB1(OC1A/PCINT1)" x="-33.02" y="17.78" length="short" swaplevel="1"/>
<pin name="PB0(ICP1/CLKO/PCINT0)" x="-33.02" y="20.32" length="short" swaplevel="1"/>
<pin name="PD7(AIN1/PCINT23)" x="33.02" y="2.54" length="short" swaplevel="1" rot="R180"/>
<pin name="PD6(AIN0/OC0A/PCINT22)" x="33.02" y="5.08" length="short" swaplevel="1" rot="R180"/>
<pin name="PD5(T1/OC0B/PCINT21)" x="33.02" y="7.62" length="short" swaplevel="1" rot="R180"/>
<pin name="PD4(T0/XCK/PCINT20)" x="33.02" y="10.16" length="short" swaplevel="1" rot="R180"/>
<pin name="PD3(INT1/OC2B/PCINT19)" x="33.02" y="12.7" length="short" swaplevel="1" rot="R180"/>
<pin name="PD2(INT0/PCINT18)" x="33.02" y="15.24" length="short" swaplevel="1" rot="R180"/>
<pin name="PD1(TXD/PCINT17)" x="33.02" y="17.78" length="short" swaplevel="1" rot="R180"/>
<pin name="PD0(RXD/PCINT16)" x="33.02" y="20.32" length="short" swaplevel="1" rot="R180"/>
<pin name="PC5(ADC5/SCL/PCINT13)" x="-33.02" y="-15.24" length="short" swaplevel="1"/>
<pin name="PC4(ADC4/SDA/PCINT12)" x="-33.02" y="-12.7" length="short" swaplevel="1"/>
<pin name="PC3(ADC3/PCINT11)" x="-33.02" y="-10.16" length="short" swaplevel="1"/>
<pin name="PC2(ADC2/PCINT10)" x="-33.02" y="-7.62" length="short" swaplevel="1"/>
<pin name="PC1(ADC1/PCINT9)" x="-33.02" y="-5.08" length="short" swaplevel="1"/>
<pin name="PC0(ADC0/PCINT8)" x="-33.02" y="-2.54" length="short" swaplevel="1"/>
<pin name="PC6(!RESET!/PCINT14)" x="-33.02" y="-17.78" length="short" swaplevel="1"/>
<text x="27.94" y="-15.875" size="2.54" layer="95" ratio="12" rot="R180">&gt;NAME</text>
<text x="27.94" y="-19.05" size="2.54" layer="96" ratio="12" rot="R180">&gt;VALUE</text>
</symbol>
<symbol name="!UCC+GND">
<text x="0.635" y="-2.54" size="1.27" layer="95" rot="R90">&gt;NAME</text>
<text x="2.2225" y="-4.7625" size="1.27" layer="95" rot="R90">GND</text>
<text x="0.9525" y="4.7625" size="1.27" layer="95" rot="R270">UCC</text>
<pin name="GND" x="0" y="-5.08" visible="pad" length="short" direction="pwr" rot="R90"/>
<pin name="UCC" x="0" y="5.08" visible="pad" length="short" direction="pwr" rot="R270"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="ATMEGA48/88/168/328-PU(DIP28)" prefix="IC" uservalue="yes">
<gates>
<gate name="IC" symbol="ATMEGA48/88/168/328-PU(DIP28)" x="0" y="0"/>
<gate name="PWR" symbol="!UCC+GND" x="0" y="33.02" addlevel="request"/>
</gates>
<devices>
<device name="PU" package="DIL28">
<connects>
<connect gate="IC" pin="AREF" pad="21"/>
<connect gate="IC" pin="AVCC" pad="20"/>
<connect gate="IC" pin="PB0(ICP1/CLKO/PCINT0)" pad="14"/>
<connect gate="IC" pin="PB1(OC1A/PCINT1)" pad="15"/>
<connect gate="IC" pin="PB2(SS/OC1B/PCINT2)" pad="16"/>
<connect gate="IC" pin="PB3(MOSI/OC2A/PCINT3)" pad="17"/>
<connect gate="IC" pin="PB4(MISO/PCINT4)" pad="18"/>
<connect gate="IC" pin="PB5(SCK/PCINT5)" pad="19"/>
<connect gate="IC" pin="PB6(XTAL1/TOSC1/PCINT6)" pad="9"/>
<connect gate="IC" pin="PB7(XTAL2/TOSC2/PCINT7)" pad="10"/>
<connect gate="IC" pin="PC0(ADC0/PCINT8)" pad="23"/>
<connect gate="IC" pin="PC1(ADC1/PCINT9)" pad="24"/>
<connect gate="IC" pin="PC2(ADC2/PCINT10)" pad="25"/>
<connect gate="IC" pin="PC3(ADC3/PCINT11)" pad="26"/>
<connect gate="IC" pin="PC4(ADC4/SDA/PCINT12)" pad="27"/>
<connect gate="IC" pin="PC5(ADC5/SCL/PCINT13)" pad="28"/>
<connect gate="IC" pin="PC6(!RESET!/PCINT14)" pad="1"/>
<connect gate="IC" pin="PD0(RXD/PCINT16)" pad="2"/>
<connect gate="IC" pin="PD1(TXD/PCINT17)" pad="3"/>
<connect gate="IC" pin="PD2(INT0/PCINT18)" pad="4"/>
<connect gate="IC" pin="PD3(INT1/OC2B/PCINT19)" pad="5"/>
<connect gate="IC" pin="PD4(T0/XCK/PCINT20)" pad="6"/>
<connect gate="IC" pin="PD5(T1/OC0B/PCINT21)" pad="11"/>
<connect gate="IC" pin="PD6(AIN0/OC0A/PCINT22)" pad="12"/>
<connect gate="IC" pin="PD7(AIN1/PCINT23)" pad="13"/>
<connect gate="PWR" pin="GND" pad="8 22"/>
<connect gate="PWR" pin="UCC" pad="7"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
</libraries>
<attributes>
</attributes>
<variantdefs>
</variantdefs>
<classes>
<class number="0" name="default" width="0" drill="0">
</class>
</classes>
<parts>
<part name="IC1" library="atmel_tiny24-44-84tiny48-88mega48-88-168-328" deviceset="ATMEGA48/88/168/328-PU(DIP28)" device="PU"/>
</parts>
<sheets>
<sheet>
<plain>
</plain>
<instances>
<instance part="IC1" gate="IC" x="0" y="0"/>
</instances>
<busses>
</busses>
<nets>
<net name="N$1" class="0">
<segment>
<pinref part="IC1" gate="IC" pin="PB0(ICP1/CLKO/PCINT0)"/>
<wire x1="-33.02" y1="20.32" x2="-53.34" y2="20.32" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$2" class="0">
<segment>
<pinref part="IC1" gate="IC" pin="PB1(OC1A/PCINT1)"/>
<wire x1="-33.02" y1="17.78" x2="-53.34" y2="17.78" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$3" class="0">
<segment>
<pinref part="IC1" gate="IC" pin="PB2(SS/OC1B/PCINT2)"/>
<wire x1="-33.02" y1="15.24" x2="-53.34" y2="15.24" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$4" class="0">
<segment>
<pinref part="IC1" gate="IC" pin="PB3(MOSI/OC2A/PCINT3)"/>
<wire x1="-33.02" y1="12.7" x2="-40.64" y2="12.7" width="0.1524" layer="91"/>
<wire x1="-40.64" y1="12.7" x2="-53.34" y2="12.7" width="0.1524" layer="91"/>
<wire x1="-40.64" y1="12.7" x2="-40.64" y2="40.64" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$5" class="0">
<segment>
<pinref part="IC1" gate="IC" pin="PB4(MISO/PCINT4)"/>
<wire x1="-33.02" y1="10.16" x2="-38.1" y2="10.16" width="0.1524" layer="91"/>
<wire x1="-38.1" y1="10.16" x2="-48.26" y2="10.16" width="0.1524" layer="91"/>
<wire x1="-48.26" y1="10.16" x2="-48.26" y2="2.54" width="0.1524" layer="91"/>
<wire x1="-48.26" y1="2.54" x2="-53.34" y2="2.54" width="0.1524" layer="91"/>
<wire x1="-38.1" y1="10.16" x2="-38.1" y2="40.64" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$6" class="0">
<segment>
<pinref part="IC1" gate="IC" pin="PB5(SCK/PCINT5)"/>
<wire x1="-33.02" y1="7.62" x2="-35.56" y2="7.62" width="0.1524" layer="91"/>
<wire x1="-35.56" y1="7.62" x2="-45.72" y2="7.62" width="0.1524" layer="91"/>
<wire x1="-45.72" y1="7.62" x2="-45.72" y2="0" width="0.1524" layer="91"/>
<wire x1="-45.72" y1="0" x2="-53.34" y2="0" width="0.1524" layer="91"/>
<wire x1="-35.56" y1="7.62" x2="-35.56" y2="40.64" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$7" class="0">
<segment>
<pinref part="IC1" gate="IC" pin="PC6(!RESET!/PCINT14)"/>
<wire x1="-33.02" y1="-17.78" x2="-35.56" y2="-17.78" width="0.1524" layer="91"/>
<wire x1="-35.56" y1="-17.78" x2="-53.34" y2="-17.78" width="0.1524" layer="91"/>
<wire x1="-35.56" y1="-17.78" x2="-35.56" y2="-27.94" width="0.1524" layer="91"/>
</segment>
</net>
</nets>
</sheet>
</sheets>
</schematic>
</drawing>
</eagle>
