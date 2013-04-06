module Authgraph

    def self.authentic?(request, secret_key)
      r = Request.new(request)
      return false unless secret_key && request && r.valid?
      c = CanonicalRequest.new(request, secret_key)
      signature = Signer.new.sign(c.canonical_string, secret_key)
      signature == r.signature
      # return signatures_match?(request, secret_key) && !request_too_old?(request)
    end

    # Returns the access id from the request's authorization header
    def self.user_key(request)
      Request.new(request).user_key
    end

    ### DEBUG HOOKS

    def self.canonical_string(request, secret_key)
      CanonicalRequest.new(request, secret_key).canonical_string
    end

    def self.signature(request, secret_key)
      c = CanonicalRequest.new(request, secret_key)
      signature = Signer.new.sign(c.canonical_string, secret_key)
    end

end
