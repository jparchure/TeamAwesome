require 'twitter-text'
include Twitter::Autolink

class StreamsController < ApplicationController

def index
  @stream = Twitter.user_timeline("uiowa")
  @current_twitter_user = Twitter.user
end

def new
end

end
