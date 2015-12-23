Feature: Search for phones without javascript enabled

  Scenario: User goes to root page without language
    Given I am on '/' page
    Then I should be redirected to '/en'

  Scenario: User goes to phones/index page without language
    Given I am on '/phones/index' page
    Then I should be redirected to '/en/phones/index'

  Scenario: User goes to phones/compare page without language
    Given I am on '/phones/compare' page
    Then I should be redirected to '/en/phones/index'

  Scenario: User uses link without language
    Given I am on '/phones/compare?utf8=%E2%9C%93&phone_names=oneplus+x%2C+z3+compact%2C+z1+compact' page
    Then I should be redirected to '/en/phones/compare?utf8=%E2%9C%93&phone_names=oneplus+x%2C+z3+compact%2C+z1+compact'
