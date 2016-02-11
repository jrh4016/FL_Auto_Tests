require 'calabash-android/operations'
require 'calabash-cucumber/operations'
require 'debugger'


class CalUtils
  $CHECK_DATE_FORMAT = '%-m/%-d/%Y'
  $SAVE_DATE_FORMAT = '%-d/%-m/%Y'

  @filters = [:type, :index, :marked, :id, :text, :enabled, :description, :view, :delay, :strict_wait, :timeout, :contentDescription]
  @iOS_filters = [@filters[0], @filters[1], @filters[2], @filters[4], @filters[6], @filters[7], @filters[8], @filters[9], @filters[10]]
  @android_filters = [@filters[0], @filters[1], @filters[3], @filters[4], @filters[8], @filters[9], @filters[10], @filters[11]]
  @predicable_filters = [@filters[4], @filters[6]]
  class << self; attr_accessor :debug_delay end
  class << self; attr_reader :filters , :iOS_filters, :android_filters, :predicable_filters end

  def initialize
    if ENV['MUT'] == 'AND'
      @operations = CalUtilsAnd.new
    elsif ENV['MUT'] == 'IOS'
      @operations = CalUtilsIos.new
    end
  end


  #
  # * *Args*    :
  #   - +filters+ -> hash of filters to search for element
  #           -> :type (high-level type/class of elem)
  #               iOS: label, control, buttonLabel, tableView, navigationBar
  #               And: imageButton, relativeLayout, textView, actionBar, frameLayout, editText
  #               both: button, view, imageView, strict_wait, timeout
  #               default: *
  #           -> :marked (searches via text and accessibility label - iOS)
  #           -> :id (unique id - Android)
  #           -> :text (exact text)
  #           -> :index (index of elem positioned in array of type elems)
  #           -> :view (class name -  iOS)
  #           -> :delay (seconds to wait for paint before querying)
  #           -> :description (elems full description - iOS)
  #           -> :strict_wait (true(default) - waits 10 secs for elem to appear and raises when not found; false - waits 2 secs and returns false if not found)
  #               in iOS you can predicate text and decsription queries with the value... 'LIKE fo*o*bar*'
  #                                                   'CONTAINS foo b'
  # * *Returns* :
  #   - element as a hash of attributes
  # * *Raises* :
  #   - +CalUtilsError+ -> No filters; Empty or nil filter; and Invalid filter key
  #
  def get_elems(filters)
    raise CalUtilsError, "No filters supplied!" if filters.empty?
    if filters['rect']
      return [filters] #if an actual element is 
    end
    predicate = predicate_filters(filters)
    filters = stringify_filters(filters)
    @operations.get_elems(filters, predicate)
  end

  def get_elem(filters)
    elem = get_elems(filters)
    raise CalUtilsError, "No element found matching your filters #{filters}!" if elem.empty?
    raise CalUtilsError, "#{elem.size} elements returned in query - please refine your filters or use 'get_elems'" if elem.size > 1
    elem[0]
  end

  def get_elem_attr(filters, attribute)
    predicate = predicate_filters(filters)
    filters = stringify_filters(filters)
    raise CalUtilsError, "Attribute must be a key" unless attribute.is_a? Symbol
    @operations.get_elem_attr(filters, predicate, attribute)
  end

  def get_labels(filters)
    raise CalUtilsError, "Label construct not available on Android platform" if ENV['AUT'] == 'AND'
    raise CalUtilsError, "No filters supplied!" if filters.empty?    predicate = predicate_filters(filters)
    filters = stringify_filters(filters)
    @operations.get_labels(filters, predicate)
  end

  def get_label(filters)
    label = get_labels(filters)
    raise CalUtilsError, "No label found matching your filters!" if label.empty?
    raise CalUtilsError, "#{label.size} labels returned in query - please refine your filters or use 'get_labels'" if label.size > 1
    label[0]
  end

  def set_text_field(filters, text)
    raise CalUtilsError, "No filters supplied!" if filters.empty?
    raise CalUtilsError, "Invalid filter suppied - evoke 'CalUtils.filters()' to list valid filter keys" if filters.keys.each.any? { |k| !CalUtils.is_filter?(k) }
    raise CalUtilsError, "No text supplied!" unless text
    predicate = predicate_filters(filters)
    filters = stringify_filters(filters)
    @operations.set_text_field(filters, predicate, text)
  end

  def search_list_for(name)
    raise CalUtilsError, "No text supplied!" unless name
    @operations.search_list_for name
  end

  def search_list_for_and_open(name)
    @operations.search_list_for_and_open name
  end

  # * *Args*    :
  #   - +direction+ -> symbols ':up' or ':down'
  #           - iOS scroll depth is 60% of the current view
  #           - Android scroll depth is 95% of the current view
  # * *Returns* :
  #   - hash of action status
  # * *Raises* :
  #   - +CalUtilsError+ -> Invalid scroll direction
  #
  def scroll_view(direction)
    raise CalUtilsError, "Invalid scrolling direction - must be ':up' or ':down'!" unless direction == :up or direction == :down
    @operations.scroll_view(direction)
  end

  def scroll_until_elem(filters, direction)
    raise CalUtilsError, "Invalid scrolling direction - must be ':up' or ':down'!" unless direction == :up or direction == :down
    predicate = predicate_filters(filters)
    filters = stringify_filters(filters)
    @operations.scroll_until_elem(filters, predicate, direction)
  end

  def scroll_row_until_elem(query_text, row_inc, index_num)
    @operations.scroll_row_until_elem(query_text, row_inc, index_num)
  end

  def go_back
    @operations.go_back
  end

  def date_picker_tomorrow_hour(hour)
    @operations.date_picker_tomorrow_hour(hour)
  end

  def dollar(text)
    puts 'hi there1'
    @operations.dollar(text)
  end


  ####################################################################################################################
  #													                          AND															                               #
  ####################################################################################################################
  class CalUtilsAnd
    include Calabash::Android::Operations

    def get_elems(filters, predicate)
      raise CalUtilsError, "Cannot query via iOS filters in Android" if has_iOS_filter?(filters)
      filters[:delay] = CalUtils.debug_delay if CalUtils.debug_delay
      sleep(filters[:delay]) if filters[:delay]
      query_string = appended_filters(filters)
      wait_for_elem(query_string, filters)
      query(query_string)
    end

    def get_elem_attr(filters, predicate, attribute)
      raise CalUtilsError, "Cannot query via iOS filters in Android" if has_iOS_filter?(filters)
      filters[:delay] = CalUtils.debug_delay if CalUtils.debug_delay
      sleep(filters[:delay]) if filters[:delay]
      query_string = appended_filters(filters)
      wait_for_elem(query_string, filters)
      query(query_string, attribute)
    end

    def set_text_field(filters, predicate, text)
      raise CalUtilsError, "Cannot query via iOS filters in Android" if has_iOS_filter?(filters)
      filters[:delay] = CalUtils.debug_delay if CalUtils.debug_delay
      sleep(filters[:delay]) if filters[:delay]
      query_string = appended_filters(filters)
      wait_for_elem(query_string, filters)
      raise CalUtilsError, "More than one element matches supplied filters, please refine your query" if query(query_string).size > 1
      query(query_string, :setText => text.to_s)
    end

    def scroll_view(direction)
      direction = 'scroll_down' if direction == :down
      direction = 'scroll_up' if direction == :up
      sleep 1.15
      performAction(direction)
    end

    def scroll_until_elem(filters, predicate, direction)
      raise CalUtilsError, "Cannot query via iOS filters in Android" if has_iOS_filter?(filters)
      raise CalUtilsError, "Cannot use :strict_wait and :timeout filters are not applicable when scrolling to an elem" if !filters[:strict_wait].nil? or !filters[:timeout].nil?
      filters[:delay] = CalUtils.debug_delay if CalUtils.debug_delay
      if filters[:delay] and filters[:delay] > 0.45
        sleep(filters[:delay])
      else
        sleep 0.45
      end
      query_string = appended_filters(filters)
      if direction == :down
        while query(query_string).empty? and query("button id:'buttonJump' index:0").empty?
          scroll_view(direction)
        end
      else
        while query(query_string).empty? and (query("button id:'jobs_all_tab' text:'ALL' index:0").empty? and query("button id:'searchCellButton' index:0").empty?)
          scroll_view(direction)
        end
      end
    end

    def scroll_row_until_elem(query_text, row_inc, index_num)
      sleep 0.25
      until element_exists(query_text)
        performAction('scroll_down')
        sleep 0.25
      end
    end

    def search_list_for(name)
      searchable_page_titles = ["Items", "Tasks", "Customers"]
      wait_for_elem("button id:'searchCellButton' text:'SEARCH' index:0", {strict_wait:false})
      is_page_searchable = searchable_page_titles.any? { |e| !query("textView id:'gd_action_bar_title' text:'#{e}' index:0").empty? }  
      query "editText id:'searchCellQuery' index:0", :setText => name.to_s
      touch "button id:'searchCellButton' text:'SEARCH' index:0"
    end

    def has_iOS_filter?(filters)
      filters.keys.each.any? { |k| CalUtils.is_iOS_filter?(k) }
    end

    def appended_filters(filters)
      filters[:type] = '*' if !filters[:type]
      query_string = filters[:type]
      filters.each { |k, v| query_string << " #{v.to_s}" if k != :type and k != :delay and k != :strict_wait and k != :timeout  }
      query_string.strip
    end

    def wait_for_elem(query_string, filters={})
      filters[:timeout] = 10 if filters[:timeout].nil?
      filters[:strict_wait] = true if filters[:strict_wait].nil? 
      if filters[:strict_wait]
        begin
          wait_for_elements_exist([query_string], screenshot_on_error: false, timeout:filters[:timeout], retry_frequency:0.12)
        rescue RuntimeError, NoMethodError
          raise CalUtilsError, "Waited #{filters[:timeout]} seconds and did not find element(s) - '#{query_string}'"
        end
      else
        begin
         wait_for_elements_exist([query_string], screenshot_on_error: false, timeout:filters[:timeout], retry_frequency:0.12)
        rescue RuntimeError, NoMethodError
          return false
        end
      end
    end

    def go_back
      wait_for_elem "frameLayout id:'content'", {}
      performAction 'go_back'
    end
    
    def date_picker_tomorrow_hour(hour)
      date = Time.now + 60*60*24

      date = date.strftime("%d-%m-%Y")
      performAction('set_date_with_index', date, '1')
      touch("CheckedTextView index:0")
      performAction('press_long_on_text', hour)
    end
  end


  ####################################################################################################################
  #													                          IOS															                               #
  ####################################################################################################################
  class CalUtilsIos
    include Calabash::Cucumber::Operations

    def get_elems(filters, predicate)
      raise CalUtilsError, "Cannot query via Android filters in iOS" if has_android_filter?(filters)
      wait_for_none_animating if filters[:type] != 'webDocumentView'
      filters[:delay] = CalUtils.debug_delay if CalUtils.debug_delay
      sleep(filters[:delay]) if filters[:delay]
      query_string = appended_filters(filters, predicate)
      #puts [query_string, filters, predicate].inspect
      wait_for_elem(query_string, filters, predicate)
      query(query_string)
    end

    def get_elem_attr(filters, predicate, attribute)
      raise CalUtilsError, "Cannot query via Android filters in iOS" if has_android_filter?(filters)
      wait_for_none_animating
      filters[:delay] = CalUtils.debug_delay if CalUtils.debug_delay
      sleep(filters[:delay]) if filters[:delay]
      query_string = appended_filters(filters, predicate)
      wait_for_elem(query_string, filters, predicate)
      query(query_string, attribute)
    end

    def set_text_field(filters, predicate, text)
      raise CalUtilsError, "Cannot query via Android filters in iOS" if has_android_filter?(filters)
      filters[:delay] = CalUtils.debug_delay if CalUtils.debug_delay
      sleep(filters[:delay]) if filters[:delay]
      query_string = appended_filters(filters, predicate)
      raise CalUtilsError, "More than one element matches supplied filters, please refine your query" if query(query_string).size > 1
      wait_for_none_animating
      wait_for_elem(query_string, filters, predicate)
      touch(query_string)
      wait_for_keyboard
      keyboard_enter_text(text)
      done rescue nil
      #done.nil?
      #debugger
      unless query("button marked:'DONE'").empty?
        touch("button marked:'DONE'")
      end
    end

    def get_labels(filters, predicate)
      wait_for_none_animating
      filters[:delay] = CalUtils.debug_delay if CalUtils.debug_delay
      sleep(filters[:delay]) if filters[:delay]
      query_string = appended_filters(filters, predicate)
      wait_for_elem(query_string, filters, predicate)
      label(query_string)
    end

    def scroll_view(direction)
      wait_for_none_animating
      sleep 0.5
      scroll('scrollView', direction)
    end

    def scroll_until_elem(filters, predicate, direction)
      raise CalUtilsError, "Cannot query via Android filters in iOS" if has_android_filter?(filters)
      filters[:delay] = CalUtils.debug_delay if CalUtils.debug_delay
      if filters[:delay] and filters[:delay] > 0.7
        sleep(filters[:delay])
      else
        sleep 0.75
      end
      scrolbale_page_titles = ["Jobs", "Items", "Tasks", "Customers", "BACK"]
      is_page_scrolable = scrolbale_page_titles.any? { |e| !query("view marked:'#{e}' index:0").empty? }
      if is_page_scrolable
        query_string = appended_filters(filters, predicate)
        if direction == :down
          while query(query_string).empty? and query("button marked:'top button'").empty?
            scroll_view(direction)
            wait_for_none_animating
          end
        else
          while query(query_string).empty? and (query("button marked:'SEARCH' index:0").empty? and query("button marked:'ALL' index:0").empty?)
            scroll_view(direction)
            wait_for_none_animating
          end
        end
      else
        raise CalUtilsError, 'Can only scroll pages with the titles "Jobs", "Items", "Tasks" and "Customers"'
      end
    end

    def scroll_row_until_elem(query_text, row_inc, index_num)
      n = 0
      wait_for_none_animating
      until element_exists(query_text)
        scroll_to_row("tableView index:#{index_num}", n)
        n+=row_inc
        sleep 0.75
      end
    end

    def search_list_for(name)
      searchable_page_titles = ["Items", "Tasks", "Customers", "Select Customer"]
      wait_for_none_animating
      wait_for_elem("button marked:'SEARCH'", {strict_wait:false}, nil)
      is_page_searchable = searchable_page_titles.any? { |e| !query("view marked:'#{e}' index:0").empty? or !query("label text:'NEW ASSET'").empty? }  
      raise CalUtilsError, 'Can only search pages with the titles "Items", "Tasks", "Customers" or with the button "NEW ASSET"' if !is_page_searchable
      touch("textField index:0")
      set_text("textField index:0", '')
      await_keyboard
      keyboard_enter_text(name)
      done
      touch("button marked:'SEARCH'")
    end

    def has_android_filter?(filters)
      filters.keys.each.any? { |k| CalUtils.is_android_filter?(k) }
    end

    def appended_filters(filters, predicate)
      filters[:type] = '*' if !filters[:type]
      query_string = filters[:type]
      query_string << predicate if predicate
      filters.each { |k, v| query_string << " #{v.to_s}" if k != :type and k != :delay and k != :strict_wait and k != :timeout }
      query_string.strip
    end

    def wait_for_elem(query_string, filters={}, predicate=nil)
      filters[:timeout] = 10 if filters[:timeout].nil?
      filters[:strict_wait] = true if filters[:strict_wait].nil? 
      if filters[:strict_wait]
        begin
          wait_for_elements_exist([query_string], screenshot_on_error: false, timeout:filters[:timeout], retry_frequency:0.12)
        rescue RuntimeError, NoMethodError
          raise CalUtilsError, "Waited #{filters[:timeout]} seconds and did not find element(s) - '#{query_string}'"
        end
      else
        begin
         wait_for_elements_exist([query_string], screenshot_on_error: false, timeout:filters[:timeout], retry_frequency:0.12)
        rescue RuntimeError, NoMethodError
          return false
        end
      end
     end

    def go_back
      wait_for_elem "button marked:'BACK' index:0", {}, nil
      wait_for_none_animating
      touch "button marked:'BACK' index:0"
    end

    def date_picker_tomorrow_hour(hour)
       date = query("datePicker", "date").first
           #t = time_interval(date)
           t = Time.parse(hour, Time.now)
           t = t + 60*60*24
           query("datePicker", setDate:t.to_datetime)
    end
  end
  
  
  
  
  
  


  # Exceptions
  class CalUtilsError < StandardError
  end


  # Public Helpers

  def self.is_filter?(filter_name)
    @filters.include?(filter_name)
  end

  def self.filter_is_predicable?(filter_name)
    @predicable_filters.include?(filter_name)
  end

  def self.is_android_filter?(filter_name)
    @android_filters.include?(filter_name) and filter_name != :type and filter_name != :index and filter_name != :text and filter_name != :delay and filter_name != :strict_wait and filter_name != :timeout 
  end

  def self.is_iOS_filter?(filter_name)
    @iOS_filters.include?(filter_name) and filter_name != :type and filter_name != :index and filter_name != :text and filter_name != :delay and filter_name != :strict_wait and filter_name != :timeout 
  end

  # Private Helpers
  private

  def predicate_filters(filters)
    count, predicate = 0
    filters.each do |k, v|
      if value_is_predicatable?(v.to_s)
        raise CalUtilsError, 'Cannot predicate filters on Android platform' if ENV['AUT'] == 'AND'
        raise CalUtilsError, 'Cannot predicate more than once in a query' if count > 0
        raise CalUtilsError, "Cannot predicate the '#{k.to_s}' filter" if !CalUtils.filter_is_predicable?(k)
        pred_as, value = "#{v.split(' ').first}", "#{v.split(pred_as)[1].lstrip}"       
        raise CalUtilsError, "Cannot supply unescaped single quotes in querys, please escape with '\\\\' (in value of '#{k.to_s}')" if value.include?("'") and not value.include?("\\'")
        predicate = " {#{k.to_s} #{pred_as} ".concat("'").concat(value).concat("'}")
        filters.delete(k)
        count = count + 1
      end
    end
    predicate
  end

  def stringify_filters(filters)
    filters.each do |k, v|
      if not value_is_predicate?(v.to_s)
        if k != :index and k != :delay and k != :type and k != :strict_wait and k != :timeout
          value = v.to_s()
          raise CalUtilsError, "Cannot supply unescaped single quotes in querys, please escape with '\\\\' (#{k.to_s}:#{value})" if value.include?("'") and not value.include?("\\'")
          filters[k] = "#{k.to_s}:".concat("'").concat(value).concat("'")
        else
          if k == :index and v.to_s != '0' and v.to_i == 0
            raise CalUtilsError, "Incorrect index value of: '#{v.to_s}'"
          elsif k == :index
            filters[k] = "index:#{v.to_i}"
          end
        end
      end
    end
  end

  def value_is_predicatable?(string)
    !!(/^(LIKE|BEGINSWITH|ENDSWITH|CONTAINS) [^ ]/ =~ string)
  end

  def value_is_predicate?(string)
    !!(/^ {[a-zA-z]+ (LIKE|BEGINSWITH|ENDSWITH|CONTAINS) [^ ]/ =~ string)
  end
end