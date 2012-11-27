Feature: Establish logins for staff

  In order to help the owner manage your store
  As a owner of the store
  I want to be able to create accounts dedicated to staff
  
  Stakeholder: Owner
  Priority: High

  Scenario: Create accounts for staff
    Given I am on back office page
    When I select add new staff member button
    And I fill de form which name and mail
    And I press submition button
    Then I should see success message
    And the store is associated with these categories



Requisito # 25. - Estabelecer logins para staff 
Descrição: Deve ser possível a criação de contas dedicadas ao staff da loja online. Estas contas terão acesso à área de administração da loja onde poderão gerir inventário, processar encomendas, etc., de acordo com as permissões que estiverem associadas à conta.
Stakeholder: Proprietário de loja online 
Prioridade: Alta 
Critérios de Ajuste: O staff das lojas terá a sua conta própria e assim os respetivos privilégios para fazerem a administração da sua página.