module Nibo
  class Entry < Nibo::Object
    include ApiResource
    include ApiResource::Create

    def self.url_method(method)
      case method
        when :post
          '/CreateEntry'
      end
    end

    def self.object_param(param, method)
      case method
        when :post
          param
      end
    end
  end
end
