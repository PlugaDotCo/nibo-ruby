require 'spec_helper'

describe Nibo::Category do

  it 'should list all categories' do
    skip('This API is not avaible yet')
    Nibo.api_key = '47d9290a1c4c46efaaf0173369da2d8c'
    Nibo.api_secret = 'f13dd0cfd2a945b384e43cb0150904e3e756200308374982a71ee2e496fbb51cf4f670ae729d48ffb2284d1720c4d66a'
    Nibo.user = 'test@test.com'

    categories = Nibo::Category.list

    expect(categories.size).to eq(2)
  end
end