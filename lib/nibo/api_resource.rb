module Nibo
  module ApiResource
    BASE_URL = 'http://api.nibo.com.br/public/v1'

    def url_encode(key)
      URI.escape(key.to_s, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
    end

    def encode(params)
      params.map { |k,v| "#{k}=#{url_encode(v)}" }.join('&')
    end

    def api_request(url, method, params = nil)
      time_stamp = Time.now.utc.strftime('%Y%m%d%H%M')
      url = "#{BASE_URL}#{url}"
      headers = {authorization: "Basic #{Base64.strict_encode64("#{Nibo.api_key}:#{Nibo.generate_hash(time_stamp)}")}",
                 Timestamp: time_stamp,
                 User: Nibo.user,
                 content_type: 'application/json',
                 accept: 'application/json'}

      if method == :get && params
        params_encoded = encode(params)
        url = "#{url}?#{params_encoded}"
        params = nil
      end

      response = case method
            when :get
              RestClient.get(url, headers)
            when :post
              RestClient.post(url, params.to_json, headers)
          end

      JSON.parse(response).deep_symbolize_keys
    end

    def self.included(base)
      base.extend(ApiResource)
    end
  end
end
