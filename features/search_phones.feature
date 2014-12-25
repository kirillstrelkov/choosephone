Feature: Search for phones
  Scenario: Noscript message is not visible
    Given I am on main page
    Then I should not see noscript message

  Scenario: User can see basic form
    Given I am on main page
    Then I should see main form
    And I should see textarea field
    And I should see 'Clear' button
    And I should see 'Search' button

  Scenario: Query is removed when user clicks on 'Clear' button
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

  Scenario: User searches for phones points and prices are visible
    Given I am on main page
    When I fill in textarea with 'sony z3, sony z2'
    And I click 'Search' button
    Then I should see 'Sony Xperia Z3' on page
    And points are correct for 'Sony Xperia Z3'
    And I should see 'Sony Xperia Z2' on page
    And points are correct for 'Sony Xperia Z2'
