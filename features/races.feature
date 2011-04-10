Feature: Races

Scenario: add race
  Given I am signed in
  When I add the race "Scotruby 5K" on the date "2011-04-09 8:00"
    And I go to my account
    And I follow "Scotruby 5K"
  Then I should see "April 09, 2011 08:00"