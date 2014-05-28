# Author:       Arthur Cavallari
# GitHub:       http://github.com/arthurcavallari
# LinkedIn:     http://linkedin.com/in/arthurcavallari

require_relative 'helper_methods'

class Table
  include HelperMethods
  attr_reader :width, :height
  
  def initialize(width, height)
    raise TypeError, 'Width and height must be valid integers!' unless numeric?(width) and numeric?(height)

    @width = to_numeric!(width)
    @height = to_numeric!(height)
  end
end