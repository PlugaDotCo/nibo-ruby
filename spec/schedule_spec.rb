require 'spec_helper'

describe Nibo::Schedule do

  it 'should create a new Schedule', wip: true do
    Nibo.api_key = '47d9290a1c4c46efaaf0173369da2d8c'
    Nibo.api_secret = 'f13dd0cfd2a945b384e43cb0150904e3e756200308374982a71ee2e496fbb51cf4f670ae729d48ffb2284d1720c4d66a'
    Nibo.user = 'test@test.com'

    params = {CategoryId: 'dfd9fabe-bd8d-432b-9a4b-34184ea71269',
              EntityId: '585d14ca-fa54-44ed-98cc-89b32d085211',
              Value: 15.00, IsFlagged: false}

    schedule = Nibo::Schedule.create(params)

    expect(schedule.OrganizationId).to_not be_nil
    expect(schedule.ScheduleId).to_not be_nil
    expect(schedule.Value).to eq(15.0)
    expect(schedule.PaidValue).to eq(0.0)
    expect(schedule.IsFlagged).to be_falsey
    expect(schedule.EntityId).to eq(params[:EntityId])
    expect(schedule.CategoryId).to eq(params[:CategoryId])
  end
end