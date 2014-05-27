# Author:       Arthur Cavallari
# GitHub:       http://github.com/arthurcavallari
# LinkedIn:     http://linkedin.com/in/arthurcavallari

module HelperMethods
    def numeric? str
        true if Integer(str)
    rescue ArgumentError, TypeError
        false
    end

    def to_numeric! str
        Integer(str)
    rescue ArgumentError, TypeError
        nil
    end
end
