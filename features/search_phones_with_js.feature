@javascript
Feature: Search for phones

  Scenario: User can see basic form
    Given I am on main page
    Then I should see main form
    And I should see textarea field
    And I should see 'Clear' button
    And I should see 'Search and sort phones' button
    And I should not see 'Please enable Javascript otherwise this application is useless' on page

  Scenario: User clicks on 'Search and sort phones' with no phones
    Given I am on main page
    And I click 'Search and sort phones' button
    Then I should see 'Please type interested phones in text field.' on page

  Scenario: Query is removed when user clicks on 'Clear' button
    Given I am on main page
    When I fill in textarea with 'IPhone 5, Sony z1'
    And I click 'Clear' button
    Then I should not see 'IPhone 5, Sony z1' on page

  Scenario: User compares two phones 2, phone with more points should be the first one
    Given I am on main page
    When I fill in textarea with 'LG L9, Nexus 5'
    And I click 'Search and sort phones' button
    Then I wait for 'Loading' is not visible
    Then I should see 'LG Nexus 5' before 'LG Optimus L9'

  Scenario: User searches for one phone and query is saved
    Given I am on main page
    When I fill in textarea with 'LG L9'
    And I click 'Search and sort phones' button
    Then '#phone_names' field value should be 'LG L9'

  Scenario: User searches for phones, points and prices are visible
    Given I am on main page
    When I fill in textarea with 'sony z3, sony z2'
    And I click 'Search and sort phones' button
    Then I should see 'Sony Xperia Z3' on page
    And points are correct for 'Sony Xperia Z3'
    And price is correct for 'Sony Xperia Z3'
    And I should see 'Sony Xperia Z2' on page
    And points are correct for 'Sony Xperia Z2'
    And price is correct for 'Sony Xperia Z2'

  Scenario: User searches for tablets, points and prices are visible
    Given I am on main page
    When I fill in textarea with 'sony z4 tablet, ipad pro'
    And I click 'Search and sort phones' button
    Then I should see 'Sony Xperia Z4 Tablet' on page
    And points are correct for 'Sony Xperia Z4 Tablet'
    And price is correct for 'Sony Xperia Z4 Tablet'
    And I should see 'Apple iPad Pro' on page
    And points are correct for 'Apple iPad Pro'
    And price is correct for 'Apple iPad Pro'

  Scenario: User searches for too old phone
    Given I am on main page
    When I fill in textarea with 'lg p500'
    And I click 'Search and sort phones' button
    Then I should see 'lg p500' on page
    And I should see 'No data' on page
