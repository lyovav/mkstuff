<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE eagle SYSTEM "eagle.dtd">
<eagle version="7.1.0">
<drawing>
<settings>
<setting alwaysvectorfont="no"/>
<setting verticaltext="up"/>
</settings>
<grid distance="0.1" unitdist="inch" unit="inch" style="lines" multiple="1" display="yes" altdistance="0.01" altunitdist="inch" altunit="inch"/>
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
<layer number="99" name="SpiceOrder" color="5" fill="1" visible="yes" active="yes"/>
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
<library name="lcd_2x16_led_backlight">
<description>HY-1602F: HD44780-based 2x16 LCD display with LED backlight produced by Shen Zhen AV-Display</description>
<packages>
<package name="HY-1602F">
<wire x1="-5.46" y1="2.5" x2="74.54" y2="2.5" width="0.127" layer="21"/>
<wire x1="74.54" y1="2.5" x2="74.54" y2="-33.5" width="0.127" layer="21"/>
<wire x1="74.54" y1="-33.5" x2="-5.46" y2="-33.5" width="0.127" layer="27"/>
<wire x1="-5.46" y1="-33.5" x2="-5.46" y2="2.5" width="0.127" layer="21"/>
<wire x1="-0.46" y1="-3" x2="69.54" y2="-3" width="0.127" layer="21"/>
<wire x1="69.54" y1="-3" x2="69.54" y2="-28" width="0.127" layer="21"/>
<wire x1="-0.46" y1="-3" x2="-0.46" y2="-28" width="0.127" layer="21"/>
<wire x1="-0.46" y1="-28" x2="69.54" y2="-28" width="0.127" layer="21"/>
<circle x="-2.96" y="0" radius="3.5693" width="0.127" layer="49"/>
<circle x="72.04" y="0" radius="3.5735" width="0.127" layer="49"/>
<circle x="72.04" y="-31" radius="3.5735" width="0.127" layer="49"/>
<circle x="-2.96" y="-31" radius="3.5693" width="0.127" layer="49"/>
<pad name="1" x="2.54" y="0" drill="1" diameter="1.9304" shape="long" rot="R90"/>
<pad name="2" x="5.08" y="0" drill="1" diameter="1.9304" shape="long" rot="R90"/>
<pad name="3" x="7.62" y="0" drill="1" diameter="1.9304" shape="long" rot="R90"/>
<pad name="4" x="10.16" y="0" drill="1" diameter="1.9304" shape="long" rot="R90"/>
<pad name="5" x="12.7" y="0" drill="1" diameter="1.9304" shape="long" rot="R90"/>
<pad name="6" x="15.24" y="0" drill="1" diameter="1.9304" shape="long" rot="R90"/>
<pad name="7" x="17.78" y="0" drill="1" diameter="1.9304" shape="long" rot="R90"/>
<pad name="8" x="20.32" y="0" drill="1" diameter="1.9304" shape="long" rot="R90"/>
<pad name="9" x="22.86" y="0" drill="1" diameter="1.9304" shape="long" rot="R90"/>
<pad name="10" x="25.4" y="0" drill="1" diameter="1.9304" shape="long" rot="R90"/>
<pad name="11" x="27.94" y="0" drill="1" diameter="1.9304" shape="long" rot="R90"/>
<pad name="12" x="30.48" y="0" drill="1" diameter="1.9304" shape="long" rot="R90"/>
<pad name="13" x="33.02" y="0" drill="1" diameter="1.9304" shape="long" rot="R90"/>
<pad name="14" x="35.56" y="0" drill="1" diameter="1.9304" shape="long" rot="R90"/>
<pad name="15" x="38.1" y="0" drill="1" diameter="1.9304" shape="long" rot="R90"/>
<pad name="16" x="40.64" y="0" drill="1" diameter="1.9304" shape="long" rot="R90"/>
<text x="-5.46" y="2.8" size="1.27" layer="25">&gt;NAME</text>
<hole x="-2.96" y="0" drill="2.5"/>
<hole x="72.04" y="0" drill="2.5"/>
<hole x="-2.96" y="-31" drill="2.5"/>
<hole x="72.04" y="-31" drill="2.5"/>
</package>
</packages>
<symbols>
<symbol name="LCD_SIL">
<wire x1="-7.62" y1="2.54" x2="-7.62" y2="-40.64" width="0.254" layer="94"/>
<wire x1="-7.62" y1="-40.64" x2="10.16" y2="-40.64" width="0.254" layer="94"/>
<wire x1="10.16" y1="-40.64" x2="10.16" y2="2.54" width="0.254" layer="94"/>
<wire x1="10.16" y1="2.54" x2="-7.62" y2="2.54" width="0.254" layer="94"/>
<wire x1="2.54" y1="0" x2="7.62" y2="0" width="0.254" layer="94"/>
<wire x1="7.62" y1="0" x2="7.62" y2="-38.1" width="0.254" layer="94"/>
<wire x1="7.62" y1="-38.1" x2="2.54" y2="-38.1" width="0.254" layer="94"/>
<wire x1="2.54" y1="-38.1" x2="2.54" y2="0" width="0.254" layer="94"/>
<text x="5.08" y="-30.48" size="1.27" layer="94" rot="R90">LCD 2x16 (LED backlight)</text>
<text x="-7.62" y="-43.18" size="1.27" layer="95">&gt;NAME</text>
<pin name="VSS" x="-12.7" y="0" length="middle" direction="pwr"/>
<pin name="VCC" x="-12.7" y="-2.54" length="middle" direction="pwr"/>
<pin name="VO" x="-12.7" y="-5.08" length="middle" direction="in"/>
<pin name="RS" x="-12.7" y="-7.62" length="middle" direction="in"/>
<pin name="R/W" x="-12.7" y="-10.16" length="middle" direction="in"/>
<pin name="E" x="-12.7" y="-12.7" length="middle" direction="in"/>
<pin name="DB0" x="-12.7" y="-15.24" length="middle"/>
<pin name="DB1" x="-12.7" y="-17.78" length="middle"/>
<pin name="DB2" x="-12.7" y="-20.32" length="middle"/>
<pin name="DB3" x="-12.7" y="-22.86" length="middle"/>
<pin name="DB4" x="-12.7" y="-25.4" length="middle"/>
<pin name="DB5" x="-12.7" y="-27.94" length="middle"/>
<pin name="DB6" x="-12.7" y="-30.48" length="middle"/>
<pin name="DB7" x="-12.7" y="-33.02" length="middle"/>
<pin name="LEDA" x="-12.7" y="-35.56" length="middle" direction="pas"/>
<pin name="LEDK" x="-12.7" y="-38.1" length="middle" direction="pas"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="LCD_2X16_SIL" prefix="LCD">
<gates>
<gate name="G$1" symbol="LCD_SIL" x="0" y="0"/>
</gates>
<devices>
<device name="" package="HY-1602F">
<connects>
<connect gate="G$1" pin="DB0" pad="7"/>
<connect gate="G$1" pin="DB1" pad="8"/>
<connect gate="G$1" pin="DB2" pad="9"/>
<connect gate="G$1" pin="DB3" pad="10"/>
<connect gate="G$1" pin="DB4" pad="11"/>
<connect gate="G$1" pin="DB5" pad="12"/>
<connect gate="G$1" pin="DB6" pad="13"/>
<connect gate="G$1" pin="DB7" pad="14"/>
<connect gate="G$1" pin="E" pad="6"/>
<connect gate="G$1" pin="LEDA" pad="15"/>
<connect gate="G$1" pin="LEDK" pad="16"/>
<connect gate="G$1" pin="R/W" pad="5"/>
<connect gate="G$1" pin="RS" pad="4"/>
<connect gate="G$1" pin="VCC" pad="2"/>
<connect gate="G$1" pin="VO" pad="3"/>
<connect gate="G$1" pin="VSS" pad="1"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="con-lstb">
<description>&lt;b&gt;Pin Headers&lt;/b&gt;&lt;p&gt;
Naming:&lt;p&gt;
MA = male&lt;p&gt;
# contacts - # rows&lt;p&gt;
W = angled&lt;p&gt;
&lt;author&gt;Created by librarian@cadsoft.de&lt;/author&gt;</description>
<packages>
<package name="MA05-2">
<description>&lt;b&gt;PIN HEADER&lt;/b&gt;</description>
<wire x1="-5.715" y1="2.54" x2="-4.445" y2="2.54" width="0.1524" layer="21"/>
<wire x1="-4.445" y1="2.54" x2="-3.81" y2="1.905" width="0.1524" layer="21"/>
<wire x1="-3.81" y1="1.905" x2="-3.175" y2="2.54" width="0.1524" layer="21"/>
<wire x1="-3.175" y1="2.54" x2="-1.905" y2="2.54" width="0.1524" layer="21"/>
<wire x1="-1.905" y1="2.54" x2="-1.27" y2="1.905" width="0.1524" layer="21"/>
<wire x1="-5.715" y1="2.54" x2="-6.35" y2="1.905" width="0.1524" layer="21"/>
<wire x1="-1.27" y1="1.905" x2="-0.635" y2="2.54" width="0.1524" layer="21"/>
<wire x1="-0.635" y1="2.54" x2="0.635" y2="2.54" width="0.1524" layer="21"/>
<wire x1="0.635" y1="2.54" x2="1.27" y2="1.905" width="0.1524" layer="21"/>
<wire x1="1.905" y1="2.54" x2="3.175" y2="2.54" width="0.1524" layer="21"/>
<wire x1="3.175" y1="2.54" x2="3.81" y2="1.905" width="0.1524" layer="21"/>
<wire x1="3.81" y1="1.905" x2="4.445" y2="2.54" width="0.1524" layer="21"/>
<wire x1="4.445" y1="2.54" x2="5.715" y2="2.54" width="0.1524" layer="21"/>
<wire x1="1.905" y1="2.54" x2="1.27" y2="1.905" width="0.1524" layer="21"/>
<wire x1="-3.81" y1="-1.905" x2="-4.445" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="-1.27" y1="-1.905" x2="-1.905" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="-1.905" y1="-2.54" x2="-3.175" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="-3.175" y1="-2.54" x2="-3.81" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="-6.35" y1="1.905" x2="-6.35" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="-6.35" y1="-1.905" x2="-5.715" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="-4.445" y1="-2.54" x2="-5.715" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="1.27" y1="-1.905" x2="0.635" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="0.635" y1="-2.54" x2="-0.635" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="-0.635" y1="-2.54" x2="-1.27" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="3.81" y1="-1.905" x2="3.175" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="5.715" y1="-2.54" x2="4.445" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="4.445" y1="-2.54" x2="3.81" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="1.27" y1="-1.905" x2="1.905" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="3.175" y1="-2.54" x2="1.905" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="6.35" y1="1.905" x2="6.35" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="5.715" y1="2.54" x2="6.35" y2="1.905" width="0.1524" layer="21"/>
<wire x1="6.35" y1="-1.905" x2="5.715" y2="-2.54" width="0.1524" layer="21"/>
<pad name="1" x="-5.08" y="-1.27" drill="1.016" shape="octagon"/>
<pad name="3" x="-2.54" y="-1.27" drill="1.016" shape="octagon"/>
<pad name="5" x="0" y="-1.27" drill="1.016" shape="octagon"/>
<pad name="7" x="2.54" y="-1.27" drill="1.016" shape="octagon"/>
<pad name="9" x="5.08" y="-1.27" drill="1.016" shape="octagon"/>
<pad name="2" x="-5.08" y="1.27" drill="1.016" shape="octagon"/>
<pad name="4" x="-2.54" y="1.27" drill="1.016" shape="octagon"/>
<pad name="6" x="0" y="1.27" drill="1.016" shape="octagon"/>
<pad name="8" x="2.54" y="1.27" drill="1.016" shape="octagon"/>
<pad name="10" x="5.08" y="1.27" drill="1.016" shape="octagon"/>
<text x="-5.588" y="-4.191" size="1.27" layer="21" ratio="10">1</text>
<text x="-6.35" y="2.921" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="0" y="-4.191" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<text x="4.572" y="2.921" size="1.27" layer="21" ratio="10">10</text>
<rectangle x1="-2.794" y1="-1.524" x2="-2.286" y2="-1.016" layer="51"/>
<rectangle x1="-5.334" y1="-1.524" x2="-4.826" y2="-1.016" layer="51"/>
<rectangle x1="-0.254" y1="-1.524" x2="0.254" y2="-1.016" layer="51"/>
<rectangle x1="4.826" y1="-1.524" x2="5.334" y2="-1.016" layer="51"/>
<rectangle x1="2.286" y1="-1.524" x2="2.794" y2="-1.016" layer="51"/>
<rectangle x1="-5.334" y1="1.016" x2="-4.826" y2="1.524" layer="51"/>
<rectangle x1="-2.794" y1="1.016" x2="-2.286" y2="1.524" layer="51"/>
<rectangle x1="-0.254" y1="1.016" x2="0.254" y2="1.524" layer="51"/>
<rectangle x1="2.286" y1="1.016" x2="2.794" y2="1.524" layer="51"/>
<rectangle x1="4.826" y1="1.016" x2="5.334" y2="1.524" layer="51"/>
</package>
<package name="MA07-1">
<description>&lt;b&gt;PIN HEADER&lt;/b&gt;</description>
<wire x1="-8.255" y1="1.27" x2="-6.985" y2="1.27" width="0.1524" layer="21"/>
<wire x1="-6.985" y1="1.27" x2="-6.35" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-6.35" y1="-0.635" x2="-6.985" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-6.35" y1="0.635" x2="-5.715" y2="1.27" width="0.1524" layer="21"/>
<wire x1="-5.715" y1="1.27" x2="-4.445" y2="1.27" width="0.1524" layer="21"/>
<wire x1="-4.445" y1="1.27" x2="-3.81" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-3.81" y1="-0.635" x2="-4.445" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-4.445" y1="-1.27" x2="-5.715" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-5.715" y1="-1.27" x2="-6.35" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="-8.89" y1="0.635" x2="-8.89" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="-8.255" y1="1.27" x2="-8.89" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-8.89" y1="-0.635" x2="-8.255" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-6.985" y1="-1.27" x2="-8.255" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-3.81" y1="0.635" x2="-3.175" y2="1.27" width="0.1524" layer="21"/>
<wire x1="-3.175" y1="1.27" x2="-1.905" y2="1.27" width="0.1524" layer="21"/>
<wire x1="-1.905" y1="1.27" x2="-1.27" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-1.27" y1="-0.635" x2="-1.905" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-1.905" y1="-1.27" x2="-3.175" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-3.175" y1="-1.27" x2="-3.81" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="-0.635" y1="1.27" x2="0.635" y2="1.27" width="0.1524" layer="21"/>
<wire x1="0.635" y1="1.27" x2="1.27" y2="0.635" width="0.1524" layer="21"/>
<wire x1="1.27" y1="-0.635" x2="0.635" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="1.27" y1="0.635" x2="1.905" y2="1.27" width="0.1524" layer="21"/>
<wire x1="1.905" y1="1.27" x2="3.175" y2="1.27" width="0.1524" layer="21"/>
<wire x1="3.175" y1="1.27" x2="3.81" y2="0.635" width="0.1524" layer="21"/>
<wire x1="3.81" y1="-0.635" x2="3.175" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="3.175" y1="-1.27" x2="1.905" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="1.905" y1="-1.27" x2="1.27" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="-0.635" y1="1.27" x2="-1.27" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-1.27" y1="-0.635" x2="-0.635" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="0.635" y1="-1.27" x2="-0.635" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="3.81" y1="0.635" x2="4.445" y2="1.27" width="0.1524" layer="21"/>
<wire x1="4.445" y1="1.27" x2="5.715" y2="1.27" width="0.1524" layer="21"/>
<wire x1="5.715" y1="1.27" x2="6.35" y2="0.635" width="0.1524" layer="21"/>
<wire x1="6.35" y1="-0.635" x2="5.715" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="5.715" y1="-1.27" x2="4.445" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="4.445" y1="-1.27" x2="3.81" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="6.985" y1="1.27" x2="8.255" y2="1.27" width="0.1524" layer="21"/>
<wire x1="8.255" y1="1.27" x2="8.89" y2="0.635" width="0.1524" layer="21"/>
<wire x1="8.89" y1="0.635" x2="8.89" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="8.89" y1="-0.635" x2="8.255" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="6.985" y1="1.27" x2="6.35" y2="0.635" width="0.1524" layer="21"/>
<wire x1="6.35" y1="-0.635" x2="6.985" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="8.255" y1="-1.27" x2="6.985" y2="-1.27" width="0.1524" layer="21"/>
<pad name="1" x="-7.62" y="0" drill="1.016" shape="long" rot="R90"/>
<pad name="2" x="-5.08" y="0" drill="1.016" shape="long" rot="R90"/>
<pad name="3" x="-2.54" y="0" drill="1.016" shape="long" rot="R90"/>
<pad name="4" x="0" y="0" drill="1.016" shape="long" rot="R90"/>
<pad name="5" x="2.54" y="0" drill="1.016" shape="long" rot="R90"/>
<pad name="6" x="5.08" y="0" drill="1.016" shape="long" rot="R90"/>
<pad name="7" x="7.62" y="0" drill="1.016" shape="long" rot="R90"/>
<text x="-8.89" y="1.651" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-8.255" y="-2.921" size="1.27" layer="21" ratio="10">1</text>
<text x="-2.54" y="-2.921" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<text x="7.239" y="1.651" size="1.27" layer="21" ratio="10">7</text>
<rectangle x1="-5.334" y1="-0.254" x2="-4.826" y2="0.254" layer="51"/>
<rectangle x1="-7.874" y1="-0.254" x2="-7.366" y2="0.254" layer="51"/>
<rectangle x1="-2.794" y1="-0.254" x2="-2.286" y2="0.254" layer="51"/>
<rectangle x1="2.286" y1="-0.254" x2="2.794" y2="0.254" layer="51"/>
<rectangle x1="-0.254" y1="-0.254" x2="0.254" y2="0.254" layer="51"/>
<rectangle x1="4.826" y1="-0.254" x2="5.334" y2="0.254" layer="51"/>
<rectangle x1="7.366" y1="-0.254" x2="7.874" y2="0.254" layer="51"/>
</package>
</packages>
<symbols>
<symbol name="MA05-2">
<wire x1="3.81" y1="-7.62" x2="-3.81" y2="-7.62" width="0.4064" layer="94"/>
<wire x1="1.27" y1="0" x2="2.54" y2="0" width="0.6096" layer="94"/>
<wire x1="1.27" y1="-2.54" x2="2.54" y2="-2.54" width="0.6096" layer="94"/>
<wire x1="1.27" y1="-5.08" x2="2.54" y2="-5.08" width="0.6096" layer="94"/>
<wire x1="-2.54" y1="0" x2="-1.27" y2="0" width="0.6096" layer="94"/>
<wire x1="-2.54" y1="-2.54" x2="-1.27" y2="-2.54" width="0.6096" layer="94"/>
<wire x1="-2.54" y1="-5.08" x2="-1.27" y2="-5.08" width="0.6096" layer="94"/>
<wire x1="-3.81" y1="7.62" x2="-3.81" y2="-7.62" width="0.4064" layer="94"/>
<wire x1="3.81" y1="-7.62" x2="3.81" y2="7.62" width="0.4064" layer="94"/>
<wire x1="-3.81" y1="7.62" x2="3.81" y2="7.62" width="0.4064" layer="94"/>
<wire x1="1.27" y1="5.08" x2="2.54" y2="5.08" width="0.6096" layer="94"/>
<wire x1="1.27" y1="2.54" x2="2.54" y2="2.54" width="0.6096" layer="94"/>
<wire x1="-2.54" y1="5.08" x2="-1.27" y2="5.08" width="0.6096" layer="94"/>
<wire x1="-2.54" y1="2.54" x2="-1.27" y2="2.54" width="0.6096" layer="94"/>
<text x="-3.81" y="-10.16" size="1.778" layer="96">&gt;VALUE</text>
<text x="-3.81" y="8.382" size="1.778" layer="95">&gt;NAME</text>
<pin name="1" x="7.62" y="-5.08" visible="pad" length="middle" direction="pas" swaplevel="1" rot="R180"/>
<pin name="3" x="7.62" y="-2.54" visible="pad" length="middle" direction="pas" swaplevel="1" rot="R180"/>
<pin name="5" x="7.62" y="0" visible="pad" length="middle" direction="pas" swaplevel="1" rot="R180"/>
<pin name="2" x="-7.62" y="-5.08" visible="pad" length="middle" direction="pas" swaplevel="1"/>
<pin name="4" x="-7.62" y="-2.54" visible="pad" length="middle" direction="pas" swaplevel="1"/>
<pin name="6" x="-7.62" y="0" visible="pad" length="middle" direction="pas" swaplevel="1"/>
<pin name="7" x="7.62" y="2.54" visible="pad" length="middle" direction="pas" swaplevel="1" rot="R180"/>
<pin name="9" x="7.62" y="5.08" visible="pad" length="middle" direction="pas" swaplevel="1" rot="R180"/>
<pin name="8" x="-7.62" y="2.54" visible="pad" length="middle" direction="pas" swaplevel="1"/>
<pin name="10" x="-7.62" y="5.08" visible="pad" length="middle" direction="pas" swaplevel="1"/>
</symbol>
<symbol name="MA07-1">
<wire x1="3.81" y1="-10.16" x2="-1.27" y2="-10.16" width="0.4064" layer="94"/>
<wire x1="1.27" y1="-2.54" x2="2.54" y2="-2.54" width="0.6096" layer="94"/>
<wire x1="1.27" y1="-5.08" x2="2.54" y2="-5.08" width="0.6096" layer="94"/>
<wire x1="1.27" y1="-7.62" x2="2.54" y2="-7.62" width="0.6096" layer="94"/>
<wire x1="1.27" y1="2.54" x2="2.54" y2="2.54" width="0.6096" layer="94"/>
<wire x1="1.27" y1="0" x2="2.54" y2="0" width="0.6096" layer="94"/>
<wire x1="1.27" y1="7.62" x2="2.54" y2="7.62" width="0.6096" layer="94"/>
<wire x1="1.27" y1="5.08" x2="2.54" y2="5.08" width="0.6096" layer="94"/>
<wire x1="-1.27" y1="10.16" x2="-1.27" y2="-10.16" width="0.4064" layer="94"/>
<wire x1="3.81" y1="-10.16" x2="3.81" y2="10.16" width="0.4064" layer="94"/>
<wire x1="-1.27" y1="10.16" x2="3.81" y2="10.16" width="0.4064" layer="94"/>
<text x="-1.27" y="-12.7" size="1.778" layer="96">&gt;VALUE</text>
<text x="-1.27" y="10.922" size="1.778" layer="95">&gt;NAME</text>
<pin name="1" x="7.62" y="-7.62" visible="pad" length="middle" direction="pas" swaplevel="1" rot="R180"/>
<pin name="2" x="7.62" y="-5.08" visible="pad" length="middle" direction="pas" swaplevel="1" rot="R180"/>
<pin name="3" x="7.62" y="-2.54" visible="pad" length="middle" direction="pas" swaplevel="1" rot="R180"/>
<pin name="4" x="7.62" y="0" visible="pad" length="middle" direction="pas" swaplevel="1" rot="R180"/>
<pin name="5" x="7.62" y="2.54" visible="pad" length="middle" direction="pas" swaplevel="1" rot="R180"/>
<pin name="6" x="7.62" y="5.08" visible="pad" length="middle" direction="pas" swaplevel="1" rot="R180"/>
<pin name="7" x="7.62" y="7.62" visible="pad" length="middle" direction="pas" swaplevel="1" rot="R180"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="MA05-2" prefix="SV" uservalue="yes">
<description>&lt;b&gt;PIN HEADER&lt;/b&gt;</description>
<gates>
<gate name="G$1" symbol="MA05-2" x="0" y="0"/>
</gates>
<devices>
<device name="" package="MA05-2">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="10" pad="10"/>
<connect gate="G$1" pin="2" pad="2"/>
<connect gate="G$1" pin="3" pad="3"/>
<connect gate="G$1" pin="4" pad="4"/>
<connect gate="G$1" pin="5" pad="5"/>
<connect gate="G$1" pin="6" pad="6"/>
<connect gate="G$1" pin="7" pad="7"/>
<connect gate="G$1" pin="8" pad="8"/>
<connect gate="G$1" pin="9" pad="9"/>
</connects>
<technologies>
<technology name="">
<attribute name="MF" value="" constant="no"/>
<attribute name="MPN" value="" constant="no"/>
<attribute name="OC_FARNELL" value="unknown" constant="no"/>
<attribute name="OC_NEWARK" value="unknown" constant="no"/>
</technology>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="MA07-1" prefix="SV" uservalue="yes">
<description>&lt;b&gt;PIN HEADER&lt;/b&gt;</description>
<gates>
<gate name="1" symbol="MA07-1" x="0" y="0"/>
</gates>
<devices>
<device name="" package="MA07-1">
<connects>
<connect gate="1" pin="1" pad="1"/>
<connect gate="1" pin="2" pad="2"/>
<connect gate="1" pin="3" pad="3"/>
<connect gate="1" pin="4" pad="4"/>
<connect gate="1" pin="5" pad="5"/>
<connect gate="1" pin="6" pad="6"/>
<connect gate="1" pin="7" pad="7"/>
</connects>
<technologies>
<technology name="">
<attribute name="MF" value="" constant="no"/>
<attribute name="MPN" value="" constant="no"/>
<attribute name="OC_FARNELL" value="unknown" constant="no"/>
<attribute name="OC_NEWARK" value="unknown" constant="no"/>
</technology>
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
<part name="LCD1" library="lcd_2x16_led_backlight" deviceset="LCD_2X16_SIL" device=""/>
<part name="SV1" library="con-lstb" deviceset="MA05-2" device=""/>
<part name="SV2" library="con-lstb" deviceset="MA07-1" device=""/>
<part name="SV3" library="con-lstb" deviceset="MA07-1" device=""/>
</parts>
<sheets>
<sheet>
<plain>
</plain>
<instances>
<instance part="IC1" gate="IC" x="7.62" y="7.62" rot="R180"/>
<instance part="LCD1" gate="G$1" x="63.5" y="50.8" rot="R90"/>
<instance part="SV1" gate="G$1" x="40.64" y="-40.64"/>
<instance part="SV2" gate="1" x="71.12" y="-38.1" rot="R90"/>
<instance part="SV3" gate="1" x="78.74" y="10.16" rot="R90"/>
</instances>
<busses>
</busses>
<nets>
<net name="N$1" class="0">
<segment>
<pinref part="SV3" gate="1" pin="1"/>
<wire x1="86.36" y1="17.78" x2="86.36" y2="20.32" width="0.1524" layer="91"/>
<wire x1="86.36" y1="20.32" x2="96.52" y2="20.32" width="0.1524" layer="91"/>
<pinref part="LCD1" gate="G$1" pin="DB7"/>
<wire x1="96.52" y1="20.32" x2="96.52" y2="38.1" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$2" class="0">
<segment>
<pinref part="SV3" gate="1" pin="2"/>
<wire x1="83.82" y1="17.78" x2="83.82" y2="22.86" width="0.1524" layer="91"/>
<wire x1="83.82" y1="22.86" x2="93.98" y2="22.86" width="0.1524" layer="91"/>
<pinref part="LCD1" gate="G$1" pin="DB6"/>
<wire x1="93.98" y1="22.86" x2="93.98" y2="38.1" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$3" class="0">
<segment>
<pinref part="SV3" gate="1" pin="3"/>
<wire x1="81.28" y1="17.78" x2="81.28" y2="25.4" width="0.1524" layer="91"/>
<wire x1="81.28" y1="25.4" x2="91.44" y2="25.4" width="0.1524" layer="91"/>
<wire x1="91.44" y1="25.4" x2="91.44" y2="40.64" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$4" class="0">
<segment>
<pinref part="SV3" gate="1" pin="4"/>
<wire x1="78.74" y1="17.78" x2="78.74" y2="27.94" width="0.1524" layer="91"/>
<wire x1="78.74" y1="27.94" x2="88.9" y2="27.94" width="0.1524" layer="91"/>
<wire x1="88.9" y1="27.94" x2="88.9" y2="40.64" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$5" class="0">
<segment>
<pinref part="SV3" gate="1" pin="5"/>
<pinref part="LCD1" gate="G$1" pin="E"/>
<wire x1="76.2" y1="17.78" x2="76.2" y2="38.1" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$6" class="0">
<segment>
<pinref part="SV3" gate="1" pin="6"/>
<pinref part="LCD1" gate="G$1" pin="R/W"/>
<wire x1="73.66" y1="17.78" x2="73.66" y2="38.1" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$7" class="0">
<segment>
<pinref part="SV3" gate="1" pin="7"/>
<pinref part="LCD1" gate="G$1" pin="RS"/>
<wire x1="71.12" y1="17.78" x2="71.12" y2="38.1" width="0.1524" layer="91"/>
</segment>
</net>
</nets>
</sheet>
</sheets>
<errors>
<approved hash="204,1,-33.02,10.16,IC1,AVCC,,,,"/>
<approved hash="205,1,0,0,IC1PWR,GND,,,,"/>
<approved hash="205,1,0,0,IC1PWR,UCC,,,,"/>
<approved hash="204,1,81.28,-30.48,LCD1,VSS,,,,"/>
<approved hash="204,1,78.74,-30.48,LCD1,VCC,,,,"/>
<approved hash="202,1,76.2,-30.48,LCD1,VO,,,,"/>
<approved hash="113,1,0,0,IC1,,,,,"/>
</errors>
</schematic>
</drawing>
</eagle>