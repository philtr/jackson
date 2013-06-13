class Auth
  attr_accessor :provider, :uid, :info, :credentials, :extra

  class Info < OpenStruct; end
  class Credentials < OpenStruct; end
  class Extra < OpenStruct; end

  def initialize(auth_hash)
    @auth_hash = auth_hash
    @provider = auth_hash["provider"]
    @uid = auth_hash["uid"]
    @info = Auth::Info.new(auth_hash["info"].to_h)
    @credentials = Auth::Credentials.new(auth_hash["credentials"].to_h)
    @extra = Auth::Extra.new(auth_hash["extra"].to_h)
  end

  def to_h
    @auth_hash
  end
end
