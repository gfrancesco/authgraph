module Authgraph
  class CanonicalRequest
  
    def initialize(request, secret_key)
      @original_request = request
      @secret_key = secret_key
    end

    def http_request_method
      "#{@original_request.method}"
    end

    def uri
      "#{escape(@original_request.path)}\n"
    end
    
    def query_string
      if @original_request.headers["rack.request.query_hash"].present?
        h = {}
        @original_request.headers["rack.request.query_hash"].each { |k,v| h[escape(k)] = escape v }
        h.sort.map { |a| a.join("=") }.join("&")
      else
        ""
      end
    end

    def headers
      # @original_request.headers.each {|k,v| puts k; puts v;}
      "#{cont}#{dat}#{hos}"
    end

    def payload
      body = @original_request.raw_post || ""
      Signer.new.sign(body, @secret_key)
    end

    def canonical_string
      [ http_request_method,
        uri,
        query_string,
        headers,
        payload
      ].join("\n")
    end

    private

    def cont
      "content-type:#{trimall(@original_request.headers["CONTENT_TYPE"])}\n"
    end

    def dat
      "date:#{trimall(@original_request.headers["DATE"])}\n"
    end

    def hos
      "host:#{trimall(@original_request.headers["HTTP_HOST"])}\n"
    end


    def trimall(h)
      h.chomp.strip.squeeze(" ")
    end

    def escape(s)
      URI.escape(s).gsub(/\+/, "%2b")
    end

  end
end