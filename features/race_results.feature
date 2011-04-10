Feature: Race Results

Scenario: enter and see race results
  Given I am signed in as "Paul"
    And a race "Scotruby 5K"
    And a user "Alex"
    And a user "Dave"
    And "Alex" is running the race "Scotruby 5K"
    And "Dave" is running the race "Scotruby 5K"
  When I enter the following race results for "Scotruby 5K"
    | Alex | 21:25 |
    | Dave | 23:58 |
    And I sign out
    And I go to the results for "Scotruby 5K"
  Then I should see that "Alex" finished on position "1" after "21:25"
    And I should see that "Dave" finished on position "2" after "23:58"
    And I should see that "Alex" finished before "Dave"