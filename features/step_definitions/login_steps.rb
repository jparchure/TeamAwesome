Given /^I have one\s+user "([^\"]*)" with email "([^\"]*)" and password "([^\"]*)"$/ do |name, email, password|
  @user = User.new({:email => email, :name => name, :password => password, :password_confirmation => password})
  @user.save!
end

OmniAuth.config.test_mode = true
OmniAuth.config.add_mock(:twitter, {
  :provider => 'twitter',
  :uid => '12345',
  :nickname => 'fooman',
  :user_info => {
    :first_name => 'Foo',
    :last_name => 'Man'
  },
  :credentials => {
    :token => 'h0MgV3Rzrr9nxFthM1THA',
    :secret => '75Wj9bVDJrKz2Y74MFgQzi6QgHXgXFPJs7A0wPq1nU'
  },
  :home_timeline => {}
})

Given /^(?:|I )am on the login page/ do
  visit login_path
end

Given /^(?:|I )am on the streams page/ do
  visit streams_path
end

When /^(?:|I )fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end

When /^(?:|I )press "([^"]*)"$/ do |button|
  click_button(button)
end

Given /^I am an authenticated Twitter user$/ do
  visit oauth/twitter
end

Given /^I am an authenticated user$/ do
  name = 'example'
  email = 'example@example.com'
  password = 'secret!'

  Given %{I have one user "#{name}" with email "#{email}" and password "#{password}"}
  And %{I am on the login page}
  And %{I fill in "Email" with "#{email}"}
  And %{I fill in "Password" with "#{password}"}
  And %{I press "Sign in"}
  And %{I am an authenticated Twitter user}
end

When /^(?:|I )follow "([^"]*)"$/ do |link|
  click_link(link)
end 
