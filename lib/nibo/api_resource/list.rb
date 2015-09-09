module Nibo
  module ApiResource
    module List
      def list(type=nil)
        method = :get
        url_with_method = "#{url}#{url_method(method)}s"
        params = object_param(type, method) if type

        response = api_request(url_with_method,method,params)

        response.map{ |object| create_from(object)}
      end

      def self.included(base)
        base.extend(List)
      end
    end
  end
end