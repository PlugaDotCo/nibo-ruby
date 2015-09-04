module Nibo
  module ApiResource
    module Delete
      def delete(obj_id)
        method = :delete
        url_with_method = "#{url}#{url_method(method)}"
        params = object_param(obj_id, method)

        'deleted' if api_request(url_with_method,method,params).empty?
      end

      def self.included(base)
        base.extend(Delete)
      end
    end
  end
end