Feature: Payments
  In order to sell products
  As a registered owner of a store
  I want to provide different types of payment

  Stakeholder: Owner of an online store
  Priority: Essential    

  Background: I should be registered and authenticated
  	Given I am the registered user
    And there are other users
    And I am in a store
    And I select products to shopping cart
	And I want buy this products

  Scenario: Payment by Paypal
    When I press payment by paypal button
    Then the payment is successful to the owner of store
    And I should receive a successful notification
    And I should receive the shipment in my address

  Scenario: Payment by bank transfer
    When I press payment by bank transfer button
    And will display the IBAN and SWIFT Code (BIC Code)
    And I have to accomplish the transfer
    And I send proof of realization of the transfer
    Then the payment is successful to the owner of store
    And I should receive a successful notification
    And I should receive the shipment in my address

  Scenario: Payment by credit cards
    When I press payment by credit card button
    Then the payment is successful to the owner of store
    And I should receive a successful notification
    And I should receive the shipment in my address