module Nibo
  module ApiResource
    module Create
      def create(params)
        method = :post
        url_with_method = "#{url}#{url_method(method)}"
        params = object_param(params, method)

        response = api_request(url_with_method,method,params)
        create_from(response)
      end

      def self.included(base)
        base.extend(Create)
      end
    end
  end
end