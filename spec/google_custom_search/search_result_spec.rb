require 'spec'
require 'hpricot'
require File.expand_path("#{File.dirname(__FILE__)}/../spec_helper")

describe GoogleCustomSearch::SearchResult do

  RESULTS_XML = <<xml
<GSP VER="3.2">
<TM>0.129014</TM><Q>Wicked</Q>
<PARAM name="cx" value="abcd" original_value="abcd" url_escaped_value="abcd" js_escaped_value="abcd"/>
<PARAM name="client" value="google-csbe" original_value="google-csbe" url_escaped_value="google-csbe" js_escaped_value="google-csbe"/>
<PARAM name="output" value="xml_no_dtd" original_value="xml_no_dtd" url_escaped_value="xml_no_dtd" js_escaped_value="xml_no_dtd"/>
<PARAM name="q" value="Wicked" original_value="Wicked" url_escaped_value="Wicked" js_escaped_value="Wicked"/>
<PARAM name="site" value="culturaldistrict.org" original_value="culturaldistrict.org" url_escaped_value="culturaldistrict.org" js_escaped_value="culturaldistrict.org"/>
<PARAM name="adkw" value="AELymgX673ECcjZDQxtHuHEb5eHdobDdCLAvA552m-THsHQIu0ADF7SYAAoooi6mXsZjdqeBc-erFEdiD5Ir7Jml7ViklMSxqaFvPG05sJJoTebK88Rys-Q" original_value="AELymgX673ECcjZDQxtHuHEb5eHdobDdCLAvA552m-THsHQIu0ADF7SYAAoooi6mXsZjdqeBc-erFEdiD5Ir7Jml7ViklMSxqaFvPG05sJJoTebK88Rys-Q" url_escaped_value="AELymgX673ECcjZDQxtHuHEb5eHdobDdCLAvA552m-THsHQIu0ADF7SYAAoooi6mXsZjdqeBc-erFEdiD5Ir7Jml7ViklMSxqaFvPG05sJJoTebK88Rys-Q" js_escaped_value="AELymgX673ECcjZDQxtHuHEb5eHdobDdCLAvA552m-THsHQIu0ADF7SYAAoooi6mXsZjdqeBc-erFEdiD5Ir7Jml7ViklMSxqaFvPG05sJJoTebK88Rys-Q"/>
<PARAM name="hl" value="en" original_value="en" url_escaped_value="en" js_escaped_value="en"/>
<PARAM name="oe" value="UTF-8" original_value="UTF-8" url_escaped_value="UTF-8" js_escaped_value="UTF-8"/>
<PARAM name="ie" value="UTF-8" original_value="UTF-8" url_escaped_value="UTF-8" js_escaped_value="UTF-8"/>
<PARAM name="boostcse" value="0" original_value="0" url_escaped_value="0" js_escaped_value="0"/>
<Context><title>Cultural District Search Engine</title></Context><ARES/><RES SN="1" EN="10">
<M>33</M>
<FI/><NB><NU>/custom?q=Wicked&amp;hl=en&amp;safe=off&amp;client=google-csbe&amp;cx=004905679161489350096:rymp5afccji&amp;boostcse=0&amp;site=culturaldistrict.org&amp;output=xml_no_dtd&amp;ie=UTF-8&amp;oe=UTF-8&amp;ei=wFH_TdLGI8fKgQfGpMXwCg&amp;start=10&amp;sa=N</NU>
</NB>

<RG START="1" SIZE="10"/><RG START="1" SIZE="1"/><R N="1"><U>http://pgharts.culturaldistrict.org/production/26485</U><UE>http://pgharts.culturaldistrict.org/production/26485</UE><T>&lt;b&gt;Wicked&lt;/b&gt; Pittsburgh Benedum Center Tickets</T><RK>0</RK><S>&lt;b&gt;Wicked&lt;/b&gt; Pittsburgh Benedum Center Tickets Entertainment Weekly calls &lt;b&gt;WICKED&lt;/b&gt; &amp;quot;the &lt;br&gt;  best musical of the decade,” and when it first played Pittsburgh in 2006, &lt;b&gt;...&lt;/b&gt;</S><LANG>en</LANG><Label>_cse_rymp5afccji</Label><HAS><L/><C SZ="25k" CID="zZcvqAH799sJ"/><RT/></HAS><ELIGIBLE_FOR_VISUAL_SNIPPET/></R>
<RG START="2" SIZE="1"/><R N="2"><U>http://pgharts.culturaldistrict.org/production/26485/wicked?cid=CT_05122011_FB_Wicked_WickedPresale</U><UE>http://pgharts.culturaldistrict.org/production/26485/wicked%3Fcid%3DCT_05122011_FB_Wicked_WickedPresale</UE><T>&lt;b&gt;Wicked&lt;/b&gt; Pittsburgh Benedum Center Tickets</T><RK>0</RK><BYLINEDATE>1305231821</BYLINEDATE><S>May 12, 2011 &lt;b&gt;...&lt;/b&gt; &lt;b&gt;Wicked&lt;/b&gt; Pittsburgh Benedum Center Tickets Entertainment Weekly calls &lt;b&gt;WICKED&lt;/b&gt; &amp;quot;the &lt;br&gt;  best musical of the decade,” and when it first played &lt;b&gt;...&lt;/b&gt;</S><LANG>en</LANG><Label>3</Label><Label>4</Label><HAS><L/><C SZ="26k" CID="unFTTJ48B_oJ"/><RT/></HAS><ELIGIBLE_FOR_VISUAL_SNIPPET/></R>
<RG START="3" SIZE="1"/><R N="3"><U>http://www.culturaldistrict.org/tickets/tickets/reserve.aspx?performanceNumber=24471</U><UE>http://www.culturaldistrict.org/tickets/tickets/reserve.aspx%3FperformanceNumber%3D24471</UE><T>Idina Menzel Pittsburgh Heinz Hall Tickets</T><RK>0</RK><S>Broadway powerhouse Idina Menzel – the Tony award-winning &amp;quot;Elphaba&amp;quot; from &lt;br&gt;  international blockbuster &lt;b&gt;Wicked&lt;/b&gt; – performs for one-night-only at Heinz Hall &lt;br&gt;  with &lt;b&gt;...&lt;/b&gt;</S><LANG>en</LANG><Label>3</Label><Label>4</Label><HAS><L/><C SZ="25k" CID="LixRI1ZIT5oJ"/><RT/></HAS><ELIGIBLE_FOR_VISUAL_SNIPPET/></R>
<RG START="4" SIZE="1"/><R N="4"><U>http://pgharts.culturaldistrict.org/calendar/daily/2011/10/1</U><UE>http://pgharts.culturaldistrict.org/calendar/daily/2011/10/1</UE><T>The Pittsburgh Cultural Trust: Event Calendar: Saturday October 01 &lt;b&gt;...&lt;/b&gt;</T><RK>0</RK><S>&lt;b&gt;Wicked&lt;/b&gt;. 2:00 PM. Presented By: PNC Broadway Across America - Pittsburgh | Venue: &lt;br&gt;  Benedum Center. The untold story of the witches of Oz &lt;b&gt;...&lt;/b&gt;</S><LANG>en</LANG><Label>3</Label><Label>4</Label><HAS><L/><C SZ="31k" CID="-OI1Yk1Uu00J"/><RT/></HAS><ELIGIBLE_FOR_VISUAL_SNIPPET/></R>
<RG START="5" SIZE="1"/><R N="5"><U>http://pgharts.culturaldistrict.org/pct_home/subscriptions/pnc-broadway-subscriber-benefits/</U><UE>http://pgharts.culturaldistrict.org/pct_home/subscriptions/pnc-broadway-subscriber-benefits/</UE><T>PNC Broadway Subscriber Benefits</T><RK>0</RK><S>You&amp;#39;ll also be able to swap out of a subscription series show into a special as &lt;br&gt;  they are announced (excludes &lt;b&gt;Wicked&lt;/b&gt;.) You can swap your tickets out of only &lt;b&gt;...&lt;/b&gt;</S><LANG>en</LANG><Label>_cse_rymp5afccji</Label><HAS><L/><C SZ="17k" CID="wlaQgeznJUsJ"/><RT/></HAS><ELIGIBLE_FOR_VISUAL_SNIPPET/></R>
<RG START="6" SIZE="1"/><R N="6" MIME="application/pdf"><U>http://pgharts.culturaldistrict.org/uploads/File/PCT%20Group%20Sales/Broadway/bwy_WICKED_groupsales.pdf</U><UE>http://pgharts.culturaldistrict.org/uploads/File/PCT%2520Group%2520Sales/Broadway/bwy_WICKED_groupsales.pdf</UE><T>September 7-October 2, 2011 • Benedum Center</T><RK>0</RK><S>Visit &lt;b&gt;wicked&lt;/b&gt;.pgharts.org for information. $4 per order handling fee is added to &lt;br&gt;  final purchase. prices, dates and times are subject to change without notice &lt;b&gt;...&lt;/b&gt;</S><LANG>en</LANG><Label>_cse_rymp5afccji</Label><PageMap><DataObject type="metatags"><Attribute name="creationdate" value="D:20110506145045-04'00'"/><Attribute name="creator" value="Adobe InDesign CS3 (5.0.4)"/><Attribute name="producer" value="Adobe PDF Library 8.0"/><Attribute name="moddate" value="D:20110506145046-04'00'"/></DataObject></PageMap><HAS><L/><C SZ="" CID="D57QXYGUDqAJ"/><RT/></HAS><ELIGIBLE_FOR_VISUAL_SNIPPET BLOB_REF="ADGEESicCNeh5IbblmeWGTjD7GhHhT-x68j4uxcR1ABteSioixexJKoYjJy8N-QGkEid67mu1eQMILVLRJlcms6fB7PrpRy_Jbq_4DXkV0G-1mEXtPrlG5c5L6_iX055ApzMWVGgP6nC"/></R>
<RG START="7" SIZE="1"/><R N="7"><U>http://www.culturaldistrict.org/calendar/daily/2011/9/11</U><UE>http://www.culturaldistrict.org/calendar/daily/2011/9/11</UE><T>CulturalDistrict.org: Event Calendar: Sunday September 11, 2011</T><RK>0</RK><S>&lt;b&gt;Wicked&lt;/b&gt;. 1:00 PM. Presented By: PNC Broadway Across America - Pittsburgh | Venue: &lt;br&gt;  Benedum Center. The untold story of the witches of Oz &lt;b&gt;...&lt;/b&gt;</S><LANG>en</LANG><Label>3</Label><Label>4</Label><HAS><L/><C SZ="31k" CID="kLpVCLvWg9MJ"/><RT/></HAS><ELIGIBLE_FOR_VISUAL_SNIPPET/></R>
<RG START="8" SIZE="1"/><R N="8"><U>http://www.culturaldistrict.org/calendar/daily/2011/9/8</U><UE>http://www.culturaldistrict.org/calendar/daily/2011/9/8</UE><T>CulturalDistrict.org: Event Calendar: Thursday September 08, 2011</T><RK>0</RK><S>&lt;b&gt;Wicked&lt;/b&gt;. 2:00 PM. Presented By: PNC Broadway Across America - Pittsburgh | Venue: &lt;br&gt;  Benedum Center. The untold story of the witches of Oz &lt;b&gt;...&lt;/b&gt;</S><LANG>en</LANG><Label>3</Label><Label>4</Label><HAS><L/><C SZ="31k" CID="401rjaqny8oJ"/><RT/></HAS><ELIGIBLE_FOR_VISUAL_SNIPPET/></R>
<RG START="9" SIZE="1"/><R N="9"><U>http://www.culturaldistrict.org/calendar/daily/2011/9/24</U><UE>http://www.culturaldistrict.org/calendar/daily/2011/9/24</UE><T>CulturalDistrict.org: Event Calendar: Saturday September 24, 2011</T><RK>0</RK><S>&lt;b&gt;Wicked&lt;/b&gt;. 2:00 PM. Presented By: PNC Broadway Across America - Pittsburgh | Venue: &lt;br&gt;  Benedum Center. The untold story of the witches of Oz &lt;b&gt;...&lt;/b&gt;</S><LANG>en</LANG><Label>3</Label><Label>4</Label><HAS><L/><C SZ="34k" CID="vvjjOCKmgKIJ"/><RT/></HAS><ELIGIBLE_FOR_VISUAL_SNIPPET/></R>
<RG START="10" SIZE="1"/><R N="10"><U>http://www.culturaldistrict.org/calendar/daily/2011/9/30</U><UE>http://www.culturaldistrict.org/calendar/daily/2011/9/30</UE><T>CulturalDistrict.org: Event Calendar: Friday September 30, 2011</T><RK>0</RK><S>&lt;b&gt;Wicked&lt;/b&gt;. 8:00 PM. Presented By: PNC Broadway Across America - Pittsburgh | Venue: &lt;br&gt;  Benedum Center. The untold story of the witches of Oz &lt;b&gt;...&lt;/b&gt;</S><LANG>en</LANG><Label>3</Label><Label>4</Label><HAS><L/><C SZ="31k" CID="BqNFJisYpOkJ"/><RT/></HAS><ELIGIBLE_FOR_VISUAL_SNIPPET/></R>
</RES>
</GSP>
xml

  RESULTS_XML_NO_RESULTS = <<xml
<GSP VER="3.2">
<TM>0.166453</TM>
<Q>ffffggggg</Q>
<PARAM name="cx" value="abcd" original_value="abcd" url_escaped_value="abcd" js_escaped_value="abcd"/>
<PARAM name="client" value="google-csbe" original_value="google-csbe" url_escaped_value="google-csbe" js_escaped_value="google-csbe"/>
<PARAM name="output" value="xml_no_dtd" original_value="xml_no_dtd" url_escaped_value="xml_no_dtd" js_escaped_value="xml_no_dtd"/>
<PARAM name="q" value="ffffggggg" original_value="ffffggggg" url_escaped_value="ffffggggg" js_escaped_value="ffffggggg"/>
<PARAM name="site" value="culturaldistrict.org" original_value="culturaldistrict.org" url_escaped_value="culturaldistrict.org" js_escaped_value="culturaldistrict.org"/>
<PARAM name="adkw" value="AELymgXMiR0AyItzzgcJ88snCQ2ZQzi95BHYCpbuWqtNT-FkkxqTr3DTojcP0wKL9BMQD_VtA2nqsPZBKc_VkpC2x_UStZxn28VD4JyE6g1V53hVHpaf2js" original_value="AELymgXMiR0AyItzzgcJ88snCQ2ZQzi95BHYCpbuWqtNT-FkkxqTr3DTojcP0wKL9BMQD_VtA2nqsPZBKc_VkpC2x_UStZxn28VD4JyE6g1V53hVHpaf2js" url_escaped_value="AELymgXMiR0AyItzzgcJ88snCQ2ZQzi95BHYCpbuWqtNT-FkkxqTr3DTojcP0wKL9BMQD_VtA2nqsPZBKc_VkpC2x_UStZxn28VD4JyE6g1V53hVHpaf2js" js_escaped_value="AELymgXMiR0AyItzzgcJ88snCQ2ZQzi95BHYCpbuWqtNT-FkkxqTr3DTojcP0wKL9BMQD_VtA2nqsPZBKc_VkpC2x_UStZxn28VD4JyE6g1V53hVHpaf2js"/>
<PARAM name="hl" value="en" original_value="en" url_escaped_value="en" js_escaped_value="en"/>
<PARAM name="oe" value="UTF-8" original_value="UTF-8" url_escaped_value="UTF-8" js_escaped_value="UTF-8"/>
<PARAM name="ie" value="UTF-8" original_value="UTF-8" url_escaped_value="UTF-8" js_escaped_value="UTF-8"/>
<PARAM name="boostcse" value="0" original_value="0" url_escaped_value="0" js_escaped_value="0"/>
<Spelling>
<Suggestion q="ffggggg"><b><i>ffggggg</i></b></Suggestion>
</Spelling>
<ARES/>
</GSP>
xml

  it "should find the estimated count from the given search result json data" do
    result = GoogleCustomSearch::SearchResult.new Hpricot(RESULTS_XML)
    result.estimated_count.should == 33
  end


  it "should return the range of results" do
    result = GoogleCustomSearch::SearchResult.new Hpricot(RESULTS_XML)
    result.range.should == (1..10)
  end

  describe "items" do
    it "should return the search result items" do
      result = GoogleCustomSearch::SearchResult.new Hpricot(RESULTS_XML)
      result.items.size.should == 10
    end

    it "should return the title of search item" do
      result = GoogleCustomSearch::SearchResult.new Hpricot(RESULTS_XML)
      result.items.first.title.should == "<b>Wicked</b> Pittsburgh Benedum Center Tickets"
    end
  end


end