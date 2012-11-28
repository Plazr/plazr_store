Feature: Product Classification
  In order to sort products
  As a user registered
  I want to assign feedback on products purchased

  Stakeholder: User
  Priority: High

  Background: I should be registered and authenticated
    Given I am registered user
    And there are other users registered
    And I am on the front page of a product
    And I want to assign feedback on products purchased

  Scenario: See all feedbacks successfully
		Given I am registered
		And there are other users registered
		And I am on the front page
		And I want to see all the feedback
		When I press the all feedback button
		Then I should see all the feedback posted for other users

  Scenario: Change definitions store
    When I press change store button
    And open back office store
    And I make changes on back office
    And I submit the changes
    Then I should be redirect to home page of store
    And I should see the changes in store


high
Requisito # 14. - Classificação dos produtos 
Descrição: Clientes têm a possibilidade de atribuir feedback aos produtos adquiridos. 
Stakeholder: Utilizador
Utilizador Prioridade: Alta 
Critérios de Ajuste: A classificação do produto deve ser atualizada de acordo com a pontuação dos utilizadores.