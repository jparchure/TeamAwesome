require 'spec_helper'

describe SessionsController do

  describe 'create new session' do
    before :each do 
      @user = double()
      User.should_receive(:find_by_email).with('example@email.com').and_return(@user)
    end
    describe 'correct email/password combination' do
      before :each do
        @user.stub(:authenticate).with('secret').and_return(true)
      end
      it 'should set session email' do
        @user.stub(:oauth_token).and_return(nil)
        post :create, {:session => {:email => 'example@email.com', :password => 'secret', :twitterChange => 'on'}}
        session[:email].should == 'example@email.com'
      end
      it 'should redirect to twitter authorization page if user checked twitterChange' do
        post :create, {:session => {:email => 'example@email.com', :password => 'secret'}, :twitterChange => 'on'}
        response.should redirect_to('/auth/twitter')
      end
      describe 'user did not check twitterChange' do
        describe 'no oath token' do
          it 'should redirect to twitter authorization page' do
            @user.stub(:oauth_token).and_return(nil)
            post :create, {:session => {:email => 'example@email.com', :password => 'secret'}, :twitterChange => 'off'}
            response.should redirect_to('/auth/twitter')
          end
        end
        describe 'oath token exists' do
          before :each do
            @user.stub(:oauth_token).and_return('token')
            @user.stub(:oauth_token_secret).and_return('secret!')
            @user.stub(:twitterName).and_return('twitter name')
            post :create, {:session => {:email => 'example@email.com', :password => 'secret'}, :twitterChange => 'off'}
          end
          it 'should assign session variables' do
            session[:oauth_token].should == 'token'
            session[:oauth_token_secret] = 'secret!'
            session[:screen_name].should == 'twitter name'
          end
          it 'should redirect to streams' do
            response.should redirect_to streams_path
          end
        end
      end
    end
    describe 'incorrect email/password combination' do
      before :each do
        @user.stub(:authenticate).with('secret').and_return(false)
        post :create, {:session => {:email => 'example@email.com', :password => 'secret'}}
      end
      it 'should create flash message' do
        flash[:warning].should == 'Invalid email/password combination'
      end
      it 'should redirect to login path' do
        response.should render_template 'new'
      end
    end
  end

end
