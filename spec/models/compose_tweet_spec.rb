require 'spec_helper'

describe ComposeTweet do
  describe 'creating new compose tweet record' do
    it 'should call create method' do
      ComposeTweet.should_receive(:create).with(:tid=>'fake_id', :text=>'fake_text', :author=>'fake_author')
      ComposeTweet.create_compose_tweet('fake_id', 'fake_text', 'fake_author')
    end
  end
end


