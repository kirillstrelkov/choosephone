Feature: Search for phones

  Scenario: Phones should be ordered by points
    Given I am on main page
    When I fill in textarea with 'samsung galaxy core prime, z1 compact'
    And I click 'Search and sort phones' button
    Then I wait for 'Loading' is not visible
    Then I should see 'Sony Xperia Z1 Compact' before 'Samsung Galaxy Core Prime'

  Scenario: User searches for one phone and query is saved
    Given I am on main page
    When I fill in textarea with 'lg optimus l9'
    And I click 'Search and sort phones' button
    Then '#phone_names' field value should be 'lg optimus l9'

  Scenario: User searches for phones, points and prices are visible
    Given I am on main page
    When I fill in textarea with 'sony z3, samsung s7'
    And I click 'Search and sort phones' button
    Then I wait for 'Loading' is not visible
    And I should see 'Sony Xperia Z3' on page
    And points are correct for 'Sony Xperia Z3'
    And price is correct for 'Sony Xperia Z3'
    And I should see 'Samsung Galaxy S7' on page
    And points are correct for 'Samsung Galaxy S7'
    And price is correct for 'Samsung Galaxy S7'

  Scenario: User searches for tablets, points and prices are visible
    Given I am on main page
    When I fill in textarea with 'samsung tab s3, ipad pro'
    And I click 'Search and sort phones' button
    Then I wait for 'Loading' is not visible
    And I should see 'Samsung Galaxy Tab S3' on page
    And points are correct for 'Samsung Galaxy Tab S3'
    And price is correct for 'Samsung Galaxy Tab S3'
    And I should see 'Apple iPad Pro' on page
    And points are correct for 'Apple iPad Pro'
    And price is correct for 'Apple iPad Pro'

  Scenario: User searches for too old phone
    Given I am on main page
    When I fill in textarea with 'lg p500'
    And I click 'Search and sort phones' button
    Then I should see 'lg p500' on page
    And I should see 'No data' on page
