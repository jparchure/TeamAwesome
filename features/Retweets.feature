Feature: view all the tweets associated with an account that have been retweeted

	As a twitter user for marketing
	So that I can assess impact of my tweets
	I want to be able to see my Tweets that have been retweeted

Background: I have logged in

Scenario: view all retweets associated with my account
  Given I am on the TeamAwesome home page
  When I click on retweets of me button
  Then I should see all of my retweets
