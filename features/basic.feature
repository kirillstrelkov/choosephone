Feature: Basic feature

  Scenario: User can see basic form
    Given I am on main page
    Then I should see main form
    And I should see textarea field
    And I should see 'Clear' button
    And I should see 'Search and sort phones' button

  Scenario: User searches for empty phone
    Given I am on main page
    And I click 'Search and sort phones' button
    Then I should see 'Please type interested phones in text field.' on page

  Scenario: Query is removed when user clicks on 'Clear' button
    Given I am on main page
    When I fill in textarea with 'IPhone 5, Sony z1'
    And I click 'Clear' button
    Then I should not see 'IPhone 5, Sony z1' on page

  Scenario: User changes language
    Given I am on main page
    And I click 'По-русски' link
    Then I should be redirected to '/ru/index'
