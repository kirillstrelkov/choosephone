Feature: Search for phones
  Scenario: User can see form
    Given I am on main page
    Then I should see main form
    And I should see textarea field
    And I should not see 'Clear' button
    And I should see 'Search' button

  Scenario: User compares two phones
    Given I am on main page
    When I fill in textarea with 'IPhone 5, Sony z1'
    And I click 'Clear' button
    Then I should not see 'IPhone 5, Sony z1' on page

  Scenario: User compares two phones 2
    Given I am on main page
    When I fill in textarea with 'LG L9, LG Nexus 5'
    And I click 'Search' button
    Then I should see 'LG Nexus 5' before 'LG Optimus L9'
  
  Scenario: User searches for one phone and query is saved
    Given I am on main page
    When I fill in textarea with 'LG L9'
    And I click 'Search' button
    Then '#phone_names' field value should be 'LG L9'
    And I should see 'LG Optimus L9' on page

  Scenario: Query is removed when user clicks on 'Clear' button
    Given I am on main page
    When I fill in textarea with 'IPhone 5, Sony z1'
    And I click 'Clear' button
    Then I should not see 'name_url' on page
    Then I should not see 'IPhone 5, Sony z1' on page
    
  Scenario: User searches for phones tech data should be visible
    Given I am on main page
    When I fill in textarea with 'LG L9'
    And I click 'Search' button
    Then '#phone_names' field value should be 'LG L9'
    And I should see 'LG Optimus L9' on page
    And I should see ' Battery power' on page


