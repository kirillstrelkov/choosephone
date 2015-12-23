Feature: Search for phones without javascript enabled

  Scenario: User can see basic form
    Given I am on main page
    Then I should see main form
    And I should see textarea field
    And I should see 'Clear' button
    And I should see 'Search and sort phones' button
    And I should see 'Please enable Javascript otherwise this application is useless' on page

  Scenario: User searches for empty phone
    Given I am on main page
    And I click 'Search and sort phones' button
    Then I should see 'You did not enter any phone models' on page

  Scenario: Query is removed when user clicks on 'Clear' button
    Given I am on main page
    When I fill in textarea with 'IPhone 5, Sony z1'
    And I click 'Clear' button
    Then I should not see 'IPhone 5, Sony z1' on page

  Scenario: User compares two phones 2 with no js sorting should be preserved
    Given I am on main page
    When I fill in textarea with 'LG L9, Nexus 5'
    And I click 'Search and sort phones' button
    Then I should see 'LG Optimus L9' before 'LG Nexus 5'

  Scenario: User searches for one phone and query is saved
    Given I am on main page
    When I fill in textarea with 'LG L9'
    And I click 'Search and sort phones' button
    Then '#phone_names' field value should be 'LG L9'

  Scenario: User searches for phones then points and prices are loading
    Given I am on main page
    When I fill in textarea with 'sony z3, sony z2'
    And I click 'Search and sort phones' button
    Then I should see 'Sony Xperia Z3' on page
    And I should see 'Sony Xperia Z2' on page
    And I should see 'Loading' 4 times

    Scenario: User changes language after search
      Given I am on main page
      When I fill in textarea with 'sony z3, sony z2'
      And I click 'Search and sort phones' button
      And I click 'По-русски' link
      Then I should be redirected to '/ru/phones/compare?utf8=%E2%9C%93&phone_names=sony+z3%2C+sony+z2&commit=search'

      Scenario: User changes language after search
        Given I am on main page
        And I click 'По-русски' link
        Then I should be redirected to '/ru/index'
