require 'spec_helper'

describe Nibo::ApiResource do
  let(:time_stamp) {Time.now}

  before(:each) do
    Nibo.api_key = '47d9290a1c4c46efaaf0173369da2d8c'
   Nibo.api_secret = 'f13dd0cfd2a945b384e43cb0150904e3e756200308374982a71ee2e496fbb51cf4f670ae729d48ffb2284d1720c4d66a'
   Nibo.user = 'test@test.com'
  end

  context Nibo::ApiResource::Create do
    it 'should create a new accountect in Nibo API' do
      params = {Description: 'Banco do Brasil',
                 Balance: 1000,
                 BalanceDate: time_stamp.strftime('%d/%m/%Y')}

      account = Nibo::Account.create(params)

      expect(account.OrganizationId).to_not be_nil
      expect(account.AccountId).to_not be_nil
      expect(account.Description).to eq('Banco do Brasil')
      expect(account.Balance).to eq(1000.0)
      expect(account.BalanceDate).to eq(time_stamp.strftime('%Y-%d-%mT00:00:00'))
    end
  end

  context Nibo::ApiResource::Retrieve do
    it 'should retrieve an account from Nibo API' do
      account_id = '10968472-9926-453b-a0b1-fc74f029d512'

      account = Nibo::Account.retrieve(account_id)

      expect(account.OrganizationId).to eq("5d2b63a1-29ed-4204-b713-708c4afc0238")
      expect(account.AccountId).to eq("10968472-9926-453b-a0b1-fc74f029d512")
      expect(account.Description).to eq("Banco do Brasil")
      expect(account.Balance).to eq(1000.0)
      expect(account.BalanceDate).to eq('2015-08-05T00:00:00')
    end
  end

  context Nibo::ApiResource::List do
    it 'should list all accounts from Nibo API' do
      accounts = Nibo::Account.list

      expect(accounts.size).to eq(2)
    end
  end

  context Nibo::ApiResource::Delete do
    it 'should delete an account from Nibo API' do
      account_id = '10968472-9926-453b-a0b1-fc74f029d512'

      account = Nibo::Account.delete(account_id)

      expect(account).to eq('deleted')
    end
  end
end