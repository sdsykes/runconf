require 'spec_helper'

describe SessionsController, 'create' do
  before(:each) do
    @db = stub_db load: nil, save: true
  end
  
  it "should use the nickname if the user has no name" do
    request.env["omniauth.auth"] = {'user_info' => {'nickname' => 'joe'}}
    
    User.should_receive(:new).with(hash_including(name: 'joe')).and_return(stub.as_null_object)

    post :create
  end
end
