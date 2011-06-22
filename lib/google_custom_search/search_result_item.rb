require 'hpricot'
require 'cgi'
module GoogleCustomSearch

  class SearchResultItem

    attr_reader :title, :content, :url

    def initialize(search_item)
      @title = CGI.unescapeHTML((search_item/"t").innerHTML)
      @content = CGI.unescapeHTML((search_item/"s").innerHTML)
      @url = (search_item/"u").innerHTML
    end
  end
end
