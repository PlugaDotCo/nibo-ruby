require 'spec_helper'

describe Nibo do
  it 'has a version number' do
    expect(Nibo::VERSION).not_to be nil
  end

  it 'should generate hash for authentication' do
    user = 'agranado@smartcoin.com.br'
    api_key = '47d9290a1c4c46efaaf0173369da2d8c'
    api_secret = 'f13dd0cfd2a945b384e43cb0150904e3e756200308374982a71ee2e496fbb51cf4f670ae729d48ffb2284d1720c4d66a'
    time_stamp =  Time.now.utc.strftime('%Y%m%d%H%M')
    Nibo.api_key = api_key
    Nibo.api_secret = api_secret
    Nibo.user = user

    key = Base64.decode64(Base64.encode64(api_secret).gsub("\n", ''))
    #Create signature
    signature = "#{api_key}|#{time_stamp}|#{user}|#{api_key}"
    #HMCA (SHA-1) the signature
    hash = Base64.encode64(OpenSSL::HMAC.digest('sha1', key, signature)).chomp

    expect(Nibo.generate_hash(time_stamp)).to eq(hash)
  end
end
