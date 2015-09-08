require 'spec_helper'

describe Nibo::ApiResource do
  before(:each) do
    Nibo.api_key = '47d9290a1c4c46efaaf0173369da2d8c'
   Nibo.api_secret = 'f13dd0cfd2a945b384e43cb0150904e3e756200308374982a71ee2e496fbb51cf4f670ae729d48ffb2284d1720c4d66a'
   Nibo.user = 'test@test.com'
  end

  context Nibo::ApiResource::Create do
    it 'should create a new accountect in Nibo API' do
      time_stamp =  Time.now.utc.strftime('%d/%m/%Y')

      params = {Description: 'Banco do Brasil',
                 Balance: 1000,
                 BalanceDate: time_stamp}
      result = {"OrganizationId":"5d2b63a1-29ed-4204-b713-708c4afc0238","AccountId":"10968472-9926-453b-a0b1-fc74f029d512","Description":"Banco do Brasil","Balance":0.0,"BalanceDate":"0001-01-01T00:00:00"}.to_json
      allow(RestClient).to receive(:post).and_return(result)

      account = Nibo::Account.create(params)

      expect(account.OrganizationId).to_not be_nil
      expect(account.AccountId).to_not be_nil
      expect(account.Description).to eq('Banco do Brasil')
      expect(account.Balance).to eq(0.0)
      expect(account.BalanceDate).to eq('0001-01-01T00:00:00')
    end
  end

  context Nibo::ApiResource::Retrieve do
    it 'should retrieve an account from Nibo API' do
      account_id = '10968472-9926-453b-a0b1-fc74f029d512'
      result = {"OrganizationId":"5d2b63a1-29ed-4204-b713-708c4afc0238","AccountId":"10968472-9926-453b-a0b1-fc74f029d512","Description":"Banco do Brasil","Balance":0.0,"BalanceDate":"0001-01-01T00:00:00"}.to_json
      allow(RestClient).to receive(:get).and_return(result)

      account = Nibo::Account.retrieve(account_id)

      expect(account.OrganizationId).to eq("5d2b63a1-29ed-4204-b713-708c4afc0238")
      expect(account.AccountId).to eq("10968472-9926-453b-a0b1-fc74f029d512")
      expect(account.Description).to eq("Banco do Brasil")
      expect(account.Balance).to eq(0.0)
      expect(account.BalanceDate).to eq("0001-01-01T00:00:00")
    end
  end

  context Nibo::ApiResource::List do
    it 'should list all accounts from Nibo API' do
      result = [{"OrganizationId":"5d2b63a1-29ed-4204-b713-708c4afc0238","AccountId":"522baa54-e0f8-4f6e-930e-064f3080d061","Description":"Conta de Teste","Balance":0.0,"BalanceDate":"0001-01-01T00:00:00"},{"OrganizationId":"5d2b63a1-29ed-4204-b713-708c4afc0238","AccountId":"cacb2314-4d5c-4490-978d-13c82cff54f5","Description":"Conta de Teste","Balance":0.0,"BalanceDate":"0001-01-01T00:00:00"}].to_json
      allow(RestClient).to receive(:get).and_return(result)

      accounts = Nibo::Account.list

      expect(accounts.size).to eq(2)
    end
  end

  context Nibo::ApiResource::Delete do
    it 'should delete an account from Nibo API' do
      account_id = '10968472-9926-453b-a0b1-fc74f029d512'
      result = ''
      allow(RestClient).to receive(:delete).and_return(result)

      account = Nibo::Account.delete(account_id)

      expect(account).to eq('deleted')
    end
  end
end