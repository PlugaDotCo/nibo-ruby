module Nibo
  class Entity < Nibo::Object
    include ApiResource
    include ApiResource::Create
    include ApiResource::List

    def self.url_method(method)
      case method
        when :get
          '/GetEntitie'
        when :post
          '/CreateEntity'
      end
    end

    def self.object_param(param, method)
      case method
        when :get
          {type: param}
        when :post
          param
      end
    end
  end
end
