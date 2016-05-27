require 'spec_helper'

describe Nibo::Entity, vcr: {match_requests_on: [:host]} do
  before(:each) do
    Nibo.api_key = '47d9290a1c4c46efaaf0173369da2d8c'
    Nibo.api_secret = 'f13dd0cfd2a945b384e43cb0150904e3e756200308374982a71ee2e496fbb51cf4f670ae729d48ffb2284d1720c4d66a'
    Nibo.user = 'test@test.com'
  end

  it 'should create a new entity Customer' do
    params = {name: 'Test Customer', email: 'email@test.com', type: 'Customer'}

    entity = Nibo::Entity.create(params)

    expect(entity.EntityId).to_not be_nil
    expect(entity.Type).to eq('Customer')
    expect(entity.Name).to eq('Test Customer')
    expect(entity.Email).to eq('email@test.com')
  end

  it 'should all entities from one type' do
    result = [{"EntityId" => "585d14ca-fa54-44ed-98cc-89b32d085211","Type" => "Customer","Name" => "Eu Teste","Email" => "eu@teste.com","Phone" => nil,"Mobile" => nil,"Contact" => nil,"Url" => nil,"IsCompany" => false,"CpfCnpj" => nil, "CompanyName" => nil,"Registration" => nil,"AddressLine1" => nil, "District" => nil,"City" => nil,"State" => nil,"ZipCode" => nil, "Country" => nil,"BankName" => nil,"BankAgency" => nil,"BankAccount" => nil},
              {"EntityId" => "2d995742-0225-45df-a328-11f68f3e5821","Type" => "Customer","Name" => "Recebimento Teste","Email" => nil,"Phone" => nil,"Mobile" => nil,"Contact" => nil,"Url" => nil,"IsCompany" => false,"CpfCnpj" => nil, "CompanyName" => nil,"Registration" => nil,"AddressLine1" => nil, "District" => nil,"City" => nil,"State" => nil,"ZipCode" => nil, "Country" => nil,"BankName" => nil,"BankAgency" => nil,"BankAccount" => nil}].to_json
    allow(RestClient).to receive(:get).and_return(result)

    entities = Nibo::Entity.list('Customer')

    expect(entities.size).to eq(2)
  end

  it 'should get a entity by some attribute' do
    entity = Nibo::Entity.find_by({type: 'Customer', email: 'eu@teste.com'})

    expect(entity.EntityId).to_not be_nil
    expect(entity.Type).to eq('Customer')
    expect(entity.Name).to eq('Eu Teste')
    expect(entity.Email).to eq('eu@teste.com')
  end

  it 'should not find a entity by some attribute' do
    entity = Nibo::Entity.find_by({type: 'Customer', email: 'wrong_eu@teste.com'})
    expect(entity).to be_nil
  end

  it 'should get a entity by some attribute', wip:  true do
    e1 = Nibo::Entity.create(name: 'Test Customer', email: 'email@test.com', CpfCnpj: '831.584.335-40', type: 'Customer')
    e2 = Nibo::Entity.create(name: 'Test Customer', email: 'email@test.com', CpfCnpj: '197.672.622-02', type: 'Customer')
    entity = Nibo::Entity.find_by(type: 'Customer', email: 'email@test.com', CpfCnpj: '831.584.335-40')

    expect(entity.EntityId).to_not be_nil
    expect(entity.Type).to eq('Customer')
    expect(entity.Name).to eq('Test Customer')
    expect(entity.Email).to eq('email@test.com')
    expect(entity.CpfCnpj).to eq('831.584.335-40')
  end
end