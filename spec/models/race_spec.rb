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