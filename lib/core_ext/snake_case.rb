# encoding: utf-8

class String
   # ruby mutation methods have the expectation to return self if a mutation occurred, nil otherwise. (see http://www.ruby-doc.org/core-1.9.3/String.html#method-i-gsub-21)
   def to_snake_case!
     gsub!(/(.)([A-Z])/,'\1_\2')
     downcase!
   end

   def to_snake_case
     dup.tap { |s| s.to_snake_case! }
   end
end
