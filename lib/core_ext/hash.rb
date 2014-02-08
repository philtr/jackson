class Hash
  def compact
    self.reject do |key, value|
      value.blank?
    end
  end

  def compact!
    self.reject! do |key, value|
      value.blank?
    end
  end
end
