require 'spec_helper'

describe FollowBackController do
  
  before :each do
    @current_user = double()
    User.stub(:find_by_email).and_return(@current_user)

    @user1 = double()
    @user2 = double()
    @user3 = double()
    @user1.stub(:name).and_return('someGuy')
    @user1.stub(:screen_name).and_return('someGuyUser')
    @user2.stub(:name).and_return('someOtherGuy')
    @user2.stub(:screen_name).and_return('someOtherGuyUser')
    @user3.stub(:name).and_return('aThirdGuy')
    @user3.stub(:screen_name).and_return('aThirdGuyUser')
  end

  describe 'show list of users who do not follow back' do
    
    it 'should make list of users who do not follow back available to the template' do
      Twitter.should_receive(:user)
      #Twitter.stub(:home_timeline).and_return(@timeline) 
      FollowBack.stub(:get_twitter_friends_with_cursor).and_return([[@user1, @user2, @user3], false])
      FollowBack.stub(:get_twitter_followers_with_cursor).and_return([[@user2], false])
      get :index
      assigns(:results).should == [['someGuy', 'someGuyUser'], ['aThirdGuy', 'aThirdGuyUser']]
    end
    it 'should notify the user if they follow no one' do
 
      #@emptyResult = double()
      #@fakeResult.stub(:each).and_return([])
      Twitter.should_receive(:user)
      #Twitter.stub(:home_timeline).and_return(@timeline) 
      @test = Array.new()
      FollowBack.stub(:get_twitter_friends_with_cursor).and_return([[]])
      FollowBack.stub(:get_twitter_followers_with_cursor).and_return([[@user2]])
      get :index
      assigns(flash[:notice]).should = "You don't follow anyone!"
    end
    it 'should notify the user if no one follows them' do
      
    end
    
  end
end
