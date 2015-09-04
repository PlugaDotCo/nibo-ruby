module Nibo
  module ApiResource
    module List
      def list
        method = :get
        url_with_method = "#{url}#{url_method(method)}s"

        response = api_request(url_with_method,method)

        response.map{ |object| create_from(object)}
      end

      def self.included(base)
        base.extend(List)
      end
    end
  end
end