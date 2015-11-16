require 'spec_helper'

describe Nibo::Account, vcr: {match_requests_on: [:host]} do
  let(:time_stamp) {Time.now}

  it 'should get url for account' do
    expect(Nibo::Account.url).to eq('/Account')
  end

  it 'should create an account' do
    Nibo.api_key = '47d9290a1c4c46efaaf0173369da2d8c'
    Nibo.api_secret = 'f13dd0cfd2a945b384e43cb0150904e3e756200308374982a71ee2e496fbb51cf4f670ae729d48ffb2284d1720c4d66a'
    Nibo.user = 'test@test.com'

    params = {Description: 'Banco do Brasil',
              Balance: 100.0,
              BalanceDate: time_stamp.strftime('%m/%d/%Y')}

    account = Nibo::Account.create(params)

    expect(account.OrganizationId).to_not be_nil
    expect(account.AccountId).to_not be_nil
    expect(account.Description).to eq('Banco do Brasil')
    expect(account.Balance).to eq(100.0)
    expect(account.BalanceDate).to eq(time_stamp.strftime('%Y-%m-%dT00:00:00'))
  end

  context 'Account alread exist' do
    before(:each) do
      Nibo::Account.list.each do |account|
        Nibo::Account.delete(account.AccountId)
      end

      params = {Description: 'Banco do Brasil',
              Balance: 100.0,
              BalanceDate: time_stamp.strftime('%m/%d/%Y')}

      Nibo::Account.create(params)
      @account = Nibo::Account.create(params)
    end

    it 'should get account' do
      account_id = @account.AccountId
      Nibo.api_key = '47d9290a1c4c46efaaf0173369da2d8c'
      Nibo.api_secret = 'f13dd0cfd2a945b384e43cb0150904e3e756200308374982a71ee2e496fbb51cf4f670ae729d48ffb2284d1720c4d66a'
      Nibo.user = 'test@test.com'

      result = {"OrganizationId" => "5d2b63a1-29ed-4204-b713-708c4afc0238","AccountId" => @account.AccountId,"Description" => "Banco do Brasil","Balance" => 0.0,"BalanceDate" => "0001-01-01T00:00:00"}.to_json
      allow(RestClient).to receive(:get).and_return(result)
      account = Nibo::Account.retrieve(account_id)

      expect(account.OrganizationId).to eq('5d2b63a1-29ed-4204-b713-708c4afc0238')
      expect(account.AccountId).to eq(account.AccountId)
      expect(account.Description).to eq('Banco do Brasil')
      expect(account.Balance).to eq(0.0)
      expect(account.BalanceDate).to eq('0001-01-01T00:00:00')
    end

    it 'should list all accounts' do
      accounts = Nibo::Account.list

      expect(accounts.size).to eq(2)
    end

    it 'should delete an account from Nibo API' do
      account_id = @account.AccountId

      account = Nibo::Account.delete(account_id)

      expect(account).to eq('deleted')
    end
  end
end
