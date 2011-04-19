require 'spec_helper'

describe Race, '#run' do
  it 'adds a run to the race' do
    race = Race.new
    
    race.run stub(:user, id: 'user-1')
    
    race.runs.should == [Run.new(runner_id: 'user-1')]
  end
end

describe Race, '#drop_out' do
  it 'removes the run' do
    run1 = stub(:run_1, runner_id: 'user-1')
    run2 = stub(:run_2, runner_id: 'user-2')
    race = Race.new runs: [run1, run2]
    
    race.drop_out stub(:user, id: 'user-1')
    
    race.runs.should == [run2]
  end
end

describe Race, '.by_runner_id' do
  it 'maps each runner' do
    Race.by_runner_id.should map(Race.new(runs: [Run.new(runner_id: 'user-1')])).to(['user-1', 1])
  end
end

describe Race, '#results' do
  it 'loads the users' do
  end
  
  it 'sorts the runs by time' do
    run1 = stub(:run1, time: '21:36').as_null_object
    run2 = stub(:run2, time: '').as_null_object
    run3 = stub(:run3, time: '12:56').as_null_object
    race = Race.new runs: [run1, run2, run3], database: stub.as_null_object
    race.results.should == [run3, run1, run2]
  end
end

describe Race, '#runners' do
  it "should not ask couch but return an empty array if there are no runs, because bigcouch doesn't like empty keys" do
    Race.new.runners.should == []
  end
end