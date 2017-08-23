# frozen_string_literal: true

class Object
  def deep_symbolize_keys
    return self.reduce({}) do |memo, (k, v)|
      memo.tap { |m| m[k.to_sym] = v.deep_symbolize_keys }
    end if self.is_a? Hash

    return self.reduce([]) do |memo, v| 
      memo << v.deep_symbolize_keys; memo
    end if self.is_a? Array
    
    self
  end

  # Return only key that doesn't have `nil` value
  def trim
    self.select { |_k, v| v.present? }
  end
end
