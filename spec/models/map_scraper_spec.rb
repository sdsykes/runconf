require 'spec_helper'

describe MapScraper, '#scrape_map' do
  before(:each) do
    @scaper = MapScraper.new
    @db = stub_db.as_null_object
    HTTParty.stub(get: '')
  end
  
  it "loads the race" do
    @db.should_receive(:load!).with('race-1').and_return(stub.as_null_object)
    
    @scaper.scrape_map 'race-1'
  end
  
  it "fetches the race page" do
    @db.stub(load!: stub(:race, runkeeper_url: 'http://runkeeper.com/race-1').as_null_object)
    
    HTTParty.should_receive(:get).with('http://runkeeper.com/race-1').and_return('')
    
    @scaper.scrape_map 'race-1'
  end
  
  it "stops if the race has no runkeeper url" do
    @db.stub(load!: stub(:race, runkeeper_url: ''))
    
    HTTParty.should_not_receive(:get)
    
    @scaper.scrape_map 'race-1'
  end
  
  it "adds the map points to the race" do
    race = stub(:race, runkeeper_url: 'http://runkpr.com/race-1').as_null_object
    @db.stub(load!: race)
    HTTParty.stub(get: File.read(Rails.root.join('spec', 'fixtures', 'race.html')))
    
    race.should_receive(:map_points=).with([[57.698476, 11.912015], [57.700904, 11.915347], [57.699118, 11.916075]])
    
    @scaper.scrape_map 'race-1'
  end
  
  it "saves the race" do
    race = stub(:race, runkeeper_url: 'http://runkpr.com/race-1').as_null_object
    @db.stub(load!: race)
    
    @db.should_receive(:save).with(race)
    
    @scaper.scrape_map 'race-1'
  end
end
