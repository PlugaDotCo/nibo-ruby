require 'spec_helper'

describe Nibo::ApiResource do
  context Nibo::ApiResource::Create do
    it 'should create a new accountect in Nibo API' do
      Nibo.api_key = '47d9290a1c4c46efaaf0173369da2d8c'
      Nibo.api_secret = 'f13dd0cfd2a945b384e43cb0150904e3e756200308374982a71ee2e496fbb51cf4f670ae729d48ffb2284d1720c4d66a'
      Nibo.user = 'test@test.com'
      time_stamp =  Time.now.utc.strftime('%d/%m/%Y')

      params = {Description: 'Conta de Teste',
                 Balance: 1000,
                 BalanceDate: time_stamp}

      account = Nibo::Account.create(params)

      expect(account.OrganizationId).to_not be_nil
      expect(account.AccountId).to_not be_nil
      expect(account.Description).to eq('Conta de Teste')
      expect(account.Balance).to eq(0.0)
      expect(account.BalanceDate).to eq('0001-01-01T00:00:00')
    end
  end

  context Nibo::ApiResource::Retrieve do
    it 'should retrieve a accountect from Nibo API' do
      Nibo.api_key = '47d9290a1c4c46efaaf0173369da2d8c'
      Nibo.api_secret = 'f13dd0cfd2a945b384e43cb0150904e3e756200308374982a71ee2e496fbb51cf4f670ae729d48ffb2284d1720c4d66a'
      Nibo.user = 'agranado@smartcoin.com.br'
      account_id = '10968472-9926-453b-a0b1-fc74f029d512'

      account = Nibo::Account.retrieve(account_id)

      expect(account.OrganizationId).to eq("5d2b63a1-29ed-4204-b713-708c4afc0238")
      expect(account.AccountId).to eq("10968472-9926-453b-a0b1-fc74f029d512")
      expect(account.Description).to eq("Banco do Brasil")
      expect(account.Balance).to eq(0.0)
      expect(account.BalanceDate).to eq("0001-01-01T00:00:00")
    end
  end
end