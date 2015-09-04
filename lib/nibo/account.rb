module Nibo
  class Account < Nibo::Object
    include ApiResource
    include ApiResource::Create
    include ApiResource::Retrieve

    def self.url
      "/#{CGI.escape(class_name)}"
    end

    def self.url_method(method)
      case method
        when :get
          '/GetAccount'
        when :post
          '/CreateAccount'
      end

    end

    def self.object_param(param, method)
      case method
        when :get
          {accountId: param}
        when :post
          param
      end
    end

    def self.class_name
      self.name.split('::')[-1]
    end
  end
end
