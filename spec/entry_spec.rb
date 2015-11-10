require 'spec_helper'

describe Nibo::Entry do
  before(:each) do
    Nibo.api_key = '47d9290a1c4c46efaaf0173369da2d8c'
    Nibo.api_secret = 'f13dd0cfd2a945b384e43cb0150904e3e756200308374982a71ee2e496fbb51cf4f670ae729d48ffb2284d1720c4d66a'
    Nibo.user = 'test@test.com'
  end

  it 'should create a new Entry in Nibo' do
    date = Time.now.utc.strftime('%Y-%m-%d')
    params = {
              AccountId: '991f6cc0-0234-4cc2-af5b-6099c912a54e',
              EntityId: '585d14ca-fa54-44ed-98cc-89b32d085211',
              Value: 120,
              Description: 'Description test',
              Date: "#{date}T00:00:00",
              IsTransfer: false
            }

    entry = Nibo::Entry.create(params)

    expect(entry.EntryId).to_not be_nil
    expect(entry.AccountId).to eq('991f6cc0-0234-4cc2-af5b-6099c912a54e')
    expect(entry.EntityId).to be_nil #eq('585d14ca-fa54-44ed-98cc-89b32d085211')
    expect(entry.Value).to eq(120.0)
    expect(entry.Description).to eq('Description test')
    expect(entry.Date).to eq("#{date}T00:00:00")
    expect(entry.IsTransfer).to be_falsey

  end
end