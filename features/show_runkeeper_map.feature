Feature: Show runkeeper map

Background:
  Given I am signed in as "Alex"

Scenario: race has runkeeper url, so we scrape the map off of the page
  When I add the race "Scotruby 5K" with the runkeeper url "http://runkeeper.com/race-1"
    And I go to my account
    And I follow "Scotruby 5K"
  Then I should see the race map
