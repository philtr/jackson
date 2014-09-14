class HashCompactor
  def self.call(hash)
    hash.reject do |key, value|
      value.blank?
    end
  end
end
