Feature: Races

Background:
  Given I am signed in as "Alex"

Scenario: add race
  When I add the race "Scotruby 5K" on the date "2011-04-09 8:00"
    And I go to my account
    And I follow "Scotruby 5K"
  Then I should see "April 09, 2011 08:00"

Scenario: run race
  Given a race "Scotruby 5K"
  When I run the race "Scotruby 5K"
    And I go to my account
  Then I should see that I'm running at "Scotruby 5K"
  When I go to the race "Scotruby 5K"
  Then I should see that "Alex" is running

Scenario: drop out of race
  Given a race "Scotruby 5K"
    And I'm running the race "Scotruby 5K"
  When I drop out of the race "Scotruby 5K"
    And I go to my account
  Then I should not see that I'm running at "Scotruby 5K"
  When I go to the race "Scotruby 5K"
  Then I should not see that "Alex" is running