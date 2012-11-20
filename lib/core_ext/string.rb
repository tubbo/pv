class String
  def titleize
    self.split(" ").reduce("") { |phrase,token|
      phrase += token[0].upcase + token[1..-1] + " "
    }.strip
  end

  def blank?
    self == ""
  end
end
