require 'hpricot'
require File.expand_path("#{File.dirname(__FILE__)}/../spec_helper")

describe GoogleCustomSearch::SearchResultItem do

  MOCK_XML =<<-xml
<GSP VER="3.2">
<TM>0.129014</TM><Q>Wicked</Q>
<PARAM name="cx" value="abcd" original_value="abcd" url_escaped_value="abcd" js_escaped_value="abcd"/>
<PARAM name="client" value="google-csbe" original_value="google-csbe" url_escaped_value="google-csbe" js_escaped_value="google-csbe"/>
<PARAM name="output" value="xml_no_dtd" original_value="xml_no_dtd" url_escaped_value="xml_no_dtd" js_escaped_value="xml_no_dtd"/>
<PARAM name="q" value="Wicked" original_value="Wicked" url_escaped_value="Wicked" js_escaped_value="Wicked"/>
<Context><title>Cultural District Search Engine</title></Context><ARES/><RES SN="1" EN="1">
<M>33</M>
<FI/><NB><NU>/custom?q=Wicked&amp;hl=en&amp;safe=off&amp;client=google-csbe&amp;cx=004905679161489350096:rymp5afccji&amp;boostcse=0&amp;site=culturaldistrict.org&amp;output=xml_no_dtd&amp;ie=UTF-8&amp;oe=UTF-8&amp;ei=wFH_TdLGI8fKgQfGpMXwCg&amp;start=10&amp;sa=N</NU>
</NB><RG START="1" SIZE="1"/><RG START="1" SIZE="1"/><R N="1"><U>http://pgharts.culturaldistrict.org/production/26485</U><UE>http://pgharts.culturaldistrict.org/production/26485</UE><T>&lt;b&gt;Wicked&lt;/b&gt; Pittsburgh Benedum Center Tickets</T><RK>0</RK><S>&lt;b&gt;Wicked&lt;/b&gt; Pittsburgh Benedum Center Tickets Entertainment Weekly calls &lt;b&gt;WICKED&lt;/b&gt; &amp;quot;the &lt;br&gt;  best musical of the decade,” and when it first played Pittsburgh in 2006, &lt;b&gt;...&lt;/b&gt;</S><LANG>en</LANG><Label>_cse_rymp5afccji</Label><HAS><L/><C SZ="25k" CID="zZcvqAH799sJ"/><RT/></HAS><ELIGIBLE_FOR_VISUAL_SNIPPET/></R>
</RES>
</GSP>
xml

  def item_xml
    results = Hpricot(MOCK_XML)
    (results/"r").first
  end


  it "should return the title of search item" do
    item = GoogleCustomSearch::SearchResultItem.new item_xml
    item.title.should == "<b>Wicked</b> Pittsburgh Benedum Center Tickets"
  end

  it "should return the url of search item" do
    item = GoogleCustomSearch::SearchResultItem.new item_xml
    item.url.should == "http://pgharts.culturaldistrict.org/production/26485"
  end

  it "should return the content of search item" do
    item = GoogleCustomSearch::SearchResultItem.new item_xml
    item.content.should_not be_nil
  end


end