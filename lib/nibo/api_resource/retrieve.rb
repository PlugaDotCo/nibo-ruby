module Nibo
  module ApiResource
    module Retrieve
      def retrieve(obj_id)
        method = :get
        url_with_method = "#{url}#{url_method(method)}"
        params = object_param(obj_id)

        response = api_request(url_with_method,method,params)
        create_from(response)
      end

      def self.included(base)
        base.extend(Retrieve)
      end
    end
  end
end