require 'spec'
require File.expand_path("#{File.dirname(__FILE__)}/../spec_helper")

describe GoogleCustomSearch::Search do

  MOCK_JSON = {"responseData"=>{"results"=>[{"GsearchResultClass"=>"GwebSearch", "title"=>"Tile of the page", "url"=>"http://www.localhost.site/tickets/tickets/production.aspx%3FperformanceNumber%3D17303", "cacheUrl"=>"http://www.google.com/search?q=cache:pGjUcr1qUkgJ:www.localhost.site", "content"=>"Search matching content", "visibleUrl"=>"www.localhost.site", "unescapedUrl"=>"http://www.localhost.site/tickets/tickets/production.aspx?performanceNumber=17303", "titleNoFormatting"=>"Tile of the page"}, {"GsearchResultClass"=>"GwebSearch", "title"=>"Tile of the page", "url"=>"http://www.localhost.site/tickets/tickets/reserve.aspx%3FperformanceNumber%3D21140", "cacheUrl"=>"http://www.google.com/search?q=cache:E5_VPQiQo3kJ:www.localhost.site", "content"=>"1234", "visibleUrl"=>"www.localhost.site", "unescapedUrl"=>"http://www.localhost.site/tickets/tickets/reserve.aspx?performanceNumber=21140", "titleNoFormatting"=>"Tile of the page"}, {"GsearchResultClass"=>"GwebSearch", "title"=>"Tile of the page", "url"=>"http://www.localhost.site/tickets/tickets/production.aspx%3FperformanceNumber%3D23379", "cacheUrl"=>"http://www.google.com/search?q=cache:V7cn6Foe2rMJ:www.localhost.site", "content"=>"abcd", "visibleUrl"=>"www.localhost.site", "unescapedUrl"=>"http://www.localhost.site/tickets/tickets/production.aspx?performanceNumber=23379", "titleNoFormatting"=>"Tile of the page"}, {"GsearchResultClass"=>"GwebSearch", "title"=>"Tile of the page", "url"=>"http://www.localhost.site/tickets/tickets/production.aspx%3FperformanceNumber%3D17350", "cacheUrl"=>"http://www.google.com/search?q=cache:fJurfpC17DYJ:www.localhost.site", "content"=>"uiuio", "visibleUrl"=>"www.localhost.site", "unescapedUrl"=>"http://www.localhost.site/tickets/tickets/production.aspx?performanceNumber=17350", "titleNoFormatting"=>"Tile of the page"}, {"GsearchResultClass"=>"GwebSearch", "title"=>"Tile of the page", "url"=>"http://www.localhost.site/tickets/tickets/production.aspx%3FperformanceNumber%3D23374", "cacheUrl"=>"http://www.google.com/search?q=cache:jExxaBgeDD0J:www.localhost.site", "content"=>"this looks great", "visibleUrl"=>"www.localhost.site", "unescapedUrl"=>"http://www.localhost.site/tickets/tickets/production.aspx?performanceNumber=23374", "titleNoFormatting"=>"Tile of the page"}, {"GsearchResultClass"=>"GwebSearch", "title"=>"Tile of the page", "url"=>"http://www.localhost.site/tickets/tickets/production.aspx%3FperformanceNumber%3D17353", "cacheUrl"=>"http://www.google.com/search?q=cache:h43Ggs_qthYJ:www.localhost.site", "content"=>"super duper content", "visibleUrl"=>"www.localhost.site", "unescapedUrl"=>"http://www.localhost.site/tickets/tickets/production.aspx?performanceNumber=17353", "titleNoFormatting"=>"Tile of the page"}, {"GsearchResultClass"=>"GwebSearch", "title"=>"Tile of the page", "url"=>"http://www.localhost.site/tickets/calendar/", "cacheUrl"=>"http://www.google.com/search?q=cache:cI47PY7ITc4J:www.localhost.site", "content"=>"this should be useful", "visibleUrl"=>"www.localhost.site", "unescapedUrl"=>"http://www.localhost.site/tickets/calendar/", "titleNoFormatting"=>"Tile of the page"}, {"GsearchResultClass"=>"GwebSearch", "title"=>"Tile of the page - Your Show Place!", "url"=>"http://localhost.site/%3Fop%3Dcontact", "cacheUrl"=>"http://www.google.com/search?q=cache:UUq_Mw_-UnIJ:localhost.site", "content"=>"cards game", "visibleUrl"=>"localhost.site", "unescapedUrl"=>"http://localhost.site/?op=contact", "titleNoFormatting"=>"Tile of the page - Your Show Place!"}], "cursor"=>{"estimatedResultCount"=>"409", "currentPageIndex"=>3, "moreResultsUrl"=>"http://www.google.com/cse?oe=utf8&ie=utf8&source=uds&cx=004905679161489350096%3Arymp5afccji&start=28&hl=en&q=org", "pages"=>[{"label"=>1, "start"=>"0"}, {"label"=>2, "start"=>"8"}, {"label"=>3, "start"=>"16"}, {"label"=>4, "start"=>"24"}, {"label"=>5, "start"=>"32"}, {"label"=>6, "start"=>"40"}, {"label"=>7, "start"=>"48"}, {"label"=>8, "start"=>"56"}]}, "context"=>{"title"=>"Cultural District Search Engine", "facets"=>[]}}, "responseDetails"=>nil, "responseStatus"=>200}

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

  ERROR_RESPONSE = {"responseData" => nil, "responseDetails" => "out of range start", "responseStatus" => 400}

  GoogleCustomSearch::Search.google_search_api_key = "abcd"

  describe "for" do

    it "should return the estimated results count for the given search" do
      mock_uri "http://www.google.com/cse?client=google-csbe&output=xml_no_dtd&cx=abcd&q=org&num=10&start=0", MOCK_XML
      search = GoogleCustomSearch::Search.new
      results = search.for("org")
      results.estimated_count.should == 33
    end

  end

  it "should return correct start and end index for results received" do
    result = MOCK_XML
    mock_uri "http://www.google.com/cse?client=google-csbe&output=xml_no_dtd&cx=abcd&q=org&num=10&start=10", result
    search = GoogleCustomSearch::Search.new
    results = search.with_page_index(2).for("org")
    results.start_index.should == 1
    results.end_index.should == 1
  end

  private
  def mock_uri url, result
    mock_uri = mock(URI)
    mock_uri.should_receive(:read).and_return(result)
    URI.should_receive(:parse).with(url).and_return(mock_uri)
  end
end