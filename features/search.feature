Feature: Search for phones

  Scenario: Phones should be ordered by points
    Given I am on main page
    When I fill in textarea with 'samsung galaxy core prime, z1 compact'
    And I click 'Search and sort phones' button
    Then I wait for 'Loading' is not visible
    Then I should see 'Sony Xperia Z1 Compact' before 'Samsung Galaxy Core Prime'

  Scenario: User searches for one phone and query is saved
    Given I am on main page
    When I fill in textarea with 'LG L9'
    And I click 'Search and sort phones' button
    And I should see 'Loading' 2 times
    Then '#phone_names' field value should be 'LG L9'

  Scenario: User searches for phones, points and prices are visible
    Given I am on main page
    When I fill in textarea with 'sony z3, sony z2'
    And I click 'Search and sort phones' button
    Then I wait for 'Loading' is not visible
    And I should see 'Sony Xperia Z3' on page
    And points are correct for 'Sony Xperia Z3'
    And price is correct for 'Sony Xperia Z3'
    And I should see 'Sony Xperia Z2' on page
    And points are correct for 'Sony Xperia Z2'
    And price is correct for 'Sony Xperia Z2'

  Scenario: User searches for tablets, points and prices are visible
    Given I am on main page
    When I fill in textarea with 'sony z4 tablet, ipad pro'
    And I click 'Search and sort phones' button
    Then I wait for 'Loading' is not visible
    And I should see 'Sony Xperia Z4 Tablet' on page
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
    Then I wait for 'Loading' is not visible
    And I should see 'No data' on page
