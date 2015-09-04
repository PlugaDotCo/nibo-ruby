require 'spec_helper'

describe Nibo::Object do
  it 'should create object from hash' do
    params = {a: 'a', b: 2, c: 'c'}

    obj = Nibo::Object.create_from(params)

    expect(obj.a).to eq('a')
    expect(obj.b).to eq(2)
    expect(obj.c).to eq('c')
  end

  it 'should convert to hash' do
    params_2 = {a: 1, b: 'b'}
    params = {a: 'a', b: 'b', c: 1, d: Nibo::Object.create_from(params_2), e:[a: 'a', b: 1, c: Nibo::Object.create_from(params_2)]}
    obj = Nibo::Object.create_from(params)
    expect(obj.to_hash).to eq(params.merge({d: params_2, e: [a: 'a', b: 1, c: params_2]}))
  end

  it 'should convert to json' do
    params_2 = {a: 1, b: 'b'}
    params = {a: 'a', b: 'b', c: 1, d: Nibo::Object.create_from(params_2), e:[a: 'a', b: 1, c: Nibo::Object.create_from(params_2)]}
    obj = Nibo::Object.create_from(params)
    expect(obj.to_json).to eq(params.to_json)
  end

  it 'should convert to string' do
    params_2 = {a: 1, b: 'b'}
    params = {a: 'a', b: 'b', c: 1, d: Nibo::Object.create_from(params_2), e:[a: 'a', b: 1, c: Nibo::Object.create_from(params_2)]}
    obj = Nibo::Object.create_from(params)
    expect(obj.to_s).to eq(params.to_json.to_s)
  end
end