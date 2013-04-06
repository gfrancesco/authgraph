module Authgraph
  class Request

    attr_reader :user_key, :signature

    def initialize(original_request)
      @original_request = original_request
      /Authgraph (?<user_key>[^:]+):(?<signature>[a-f0-9]{64})$/ =~ @original_request.authorization
      @user_key = user_key
      @signature = signature
    end

    def valid?
      @original_request.headers["DATE"].present? &&
      @original_request.media_type.present? &&
      @original_request.host.present? &&
      @original_request.authorization.present?
    end

  end
end