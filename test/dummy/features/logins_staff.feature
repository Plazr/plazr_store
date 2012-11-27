Feature: Establish logins for staff

  In order to organize the stores
  As a owner of the store
  I want to be able to define my store by categories 	
  
  Stakeholder: Owner
  Priority: High

  Scenario: Assign a category to a store
    Given I am on create store page
    And I am setting the type of store
    When I select the categories
    And I press submition button 
    Then I should see success message
    And the store is associated with these categories

  Scenario: Edit store
    Given I am on edit store page
    And I am editing the type of store
    When I select the new categories
    And I press submition button 
    Then I should see success message
    And the store is associated with these new categories



Requisito # 25. - Estabelecer logins para staff 
Descrição: Deve ser possível a criação de contas dedicadas ao staff da loja online. Estas contas terão acesso à área de administração da loja onde poderão gerir inventário, processar encomendas, etc., de acordo com as permissões que estiverem associadas à conta.
Stakeholder: Proprietário de loja online 
Prioridade: Alta 
Critérios de Ajuste: O staff das lojas terá a sua conta própria e assim os respetivos privilégios para fazerem a administração da sua página.