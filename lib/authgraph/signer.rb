module Authgraph
  class Signer

    def initialize
    end

    def sign(string, secret_key)
      digest = OpenSSL::Digest::SHA256.new
      OpenSSL::HMAC.hexdigest(digest, secret_key, string)
    end

  end
end