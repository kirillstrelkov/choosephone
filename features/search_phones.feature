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
    And I click 'Search' button
    Then I should see 'Sony Xperia Z1' before 'Apple iPhone 5'
    
  Scenario: User compares two phones
    Given I am on main page
    When I fill in textarea with 'LG L9, LG Nexus 5'
    And I click 'Search' button
    Then I should see 'LG Nexus 5' before 'LG Optimus L9'
  
  Scenario: User searches for one phone and query is saved
    Given I am on main page
    When I fill in textarea with 'LG L9'
    And I click 'Search' button
    Then '#phones' field value should be 'LG L9'
    And I should see 'LG Optimus L9' on page
