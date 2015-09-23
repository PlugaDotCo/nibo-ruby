module Nibo
  class Category < Nibo::Object
    include ApiResource
    include ApiResource::List

    def self.url
      "/#{CGI.escape(class_name)}"
    end

    def self.class_name
      self.name.split('::')[-1]
    end

    def self.url_method(method)
      case method
        when :get
          '/GetCategory'
      end

    end
  end
end
