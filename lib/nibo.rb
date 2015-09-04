require "json"
require "base64"
require "rest-client"
require "active_support/all"

require "nibo/version"

require "nibo/object"
require "nibo/api_resource"
require "nibo/api_resource/retrieve"

module Nibo
  @@api_key
  @@api_secret
  @@user

  def self.api_key=(api_key)
    @@api_key = api_key
  end

  def self.api_key
    @@api_key
  end

  def self.api_secret=(api_secret)
    @@api_secret = api_secret
  end

  def self.user=(user)
    @@user = user
  end

  def self.user
    @@user
  end

  def self.generate_hash(time_stamp)
    Base64.encode64(OpenSSL::HMAC.digest('sha1',
                                         Base64.decode64(Base64.encode64(@@api_secret).gsub("\n", '')),
                                         "#{@@api_key}|#{time_stamp}|#{@@user}|#{@@api_key}")).chomp
  end

  class Account < Nibo::Object
    include ApiResource
    include ApiResource::Retrieve

    def self.url
      "/#{CGI.escape(class_name)}"
    end

    def self.url_method(method)
      '/GetAccount'
    end

    def self.object_param(param)
      {accountId: param}
    end

    def self.class_name
      self.name.split('::')[-1]
    end
  end
end
