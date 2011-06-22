require 'hpricot'
module GoogleCustomSearch
  class SearchResult
    def initialize result
      @result = result
    end

    def estimated_count
      (@result/"res"/"m").innerHTML.to_i
    end

    def start_index
      @result.at('res').attributes['sn'].to_i
    end

    def end_index
      @result.at('res').attributes['en'].to_i
    end

    def items
      (@result/"r").collect { |result| SearchResultItem.new result }
    end

    def range
      start_index..end_index
    end

    def first_page?
      start_index == 1
    end

    def previous_page_number
      (start_index - 1) / 10 unless first_page?
    end

    def last_page?
      end_index >= estimated_count
    end

    def next_page_number
      (end_index / 10) + 1 unless last_page?
    end

  end
end