module Nibo
  class Account < Nibo::Object
    include ApiResource
    include ApiResource::Create
    include ApiResource::Retrieve
    include ApiResource::List
    include ApiResource::Delete

    def self.url_method(method)
      case method
        when :get
          '/GetAccount'
        when :post
          '/CreateAccount'
        when :delete
          '/DeleteAccount'
      end

    end

    def self.object_param(param, method)
      case method
        when :get, :delete
          {accountId: param}
        when :post
          param
      end
    end
  end
end
