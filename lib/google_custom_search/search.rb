require 'uri'
require 'open-uri'
require 'hpricot'

module GoogleCustomSearch

  class Search

    class << self
      attr_accessor :google_search_api_key
    end
    def initialize
      @page_index = 0
      @query_parameters = {
              :num => 10,
              :start => 1
      }
    end

    def for keyword
      uri = build_query_url(keyword)
      puts uri
      search_data = uri.read
      xml_data = Hpricot(search_data)
      GoogleCustomSearch::SearchResult.new xml_data
    end

    def with_page_index index
      @page_index = index - 1
      self
    end

    private
    def build_query_url(keyword)
      @query_parameters[:start] = @query_parameters[:num] * @page_index
      google_search_url = "http://www.google.com/cse?&client=google-csbe&output=xml_no_dtd"
      arguments = @query_parameters.collect { |key, value| "#{key}=#{value}" }
      arguments.sort!
      URI.parse("#{google_search_url}&cx=#{self.class.google_search_api_key}&q=#{keyword}&"+arguments.join("&"))
    end

  end

end