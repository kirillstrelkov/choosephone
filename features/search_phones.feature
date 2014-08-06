Feature: Search for phones
  Scenario: User can see form
    Given I am on main page
    Then I should see main form
    And I should see textarea field
    And I should see 'Clear' button
    And I should see 'Search' button

  @javascript
  Scenario: User should be able to remove rubbish from textarea
    Given I am on main page
    When I fill in textarea with 'Something rubbish'
    And I click 'Clear' button
    Then I should not see 'Something rubbish'
    And textarea field should be empty
    And I should see main form

  Scenario: User compares two phones
    Given I am on main page
    When I fill in textarea with 'LG p500, LG p760'
    And I click 'Search' button
    Then I should see 'LG P760' before 'LG P500'
