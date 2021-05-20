# !/usr/bin/ruby
module Print
  class Table
    attr_accessor :datas
    attr_accessor :columns
    def initialize(labels, datas)
      self.datas = datas
      @columns = labels.each_with_object({}) { |(col,label),h|
       h[col] = {
         label: label,
         width: [datas.map { |g| g[col].size }.max, label.size].max }
       }
    end
    def print_header
     puts "| #{ @columns.map { |_,g| g[:label].ljust(g[:width]) }.join(' | ') } |"
    end

    def print_divider
     puts "+-#{ @columns.map { |_,g| "-"*g[:width] }.join("-+-") }-+"
    end

    def print_line(h)
     str = h.keys.map { |k| h[k].ljust(@columns[k][:width]) }.join(" | ")
     puts "| #{str} |"
    end
    def print
      print_divider
      print_header
      print_divider
      @datas.each { |h| print_line(h) }
      print_divider
    end
  end
end
