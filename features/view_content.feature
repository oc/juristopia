Feature: View content
  To understand the meaning of content
  visitors and contributors of juristopia should
  be able to easily annotate data
  
  Scenario: 8 pages 
    Given the following pages:
      | name                | content                                                                      | 
      | Home                | Welcome to juristopia [Help]                                                 | 
      | Help                | Help understanding juristopia. Children: [> HelpPage]                        | 
      | AllPages            | {L}                                                                          |
      | AllOccurrenceTypes  | {L occurrence_type }                                                         | 
      | AllAssociationTypes | {L association_type }                                                        | 
      | IsA                 | {== association_type } {L}                                                   | 
      | ExternalSource      | {== occurrence_type } {L}                                                    | 
      | HelpPage            | Specific [= Help] more: (ExternalSource : http://google.com/?q=wiki)         |
                                                                                      
  Scenario: List                                                                          
    GivenScenario 8 pages
    When I visit /Home
    Then I should see the following:
      | Home        |
      | Welcome     |
      | to          |
      | juristopia  |
      | Help        |
      | Associations |
      | LinkTo      |
      | Help        |

  Scenario: List pages
    GivenScenario 8 pages
    When I visit /AllPages
    Then I should see the following:
      | Home                |
      | Help                |
      | HelpPage            |
      | AllPages            |
      | AllAssociationPages |
      | AllOccurrencePages  |
        
  Scenario: List association types
    GivenScenario 8 pages
    When I visit /AllAssociationTypes
    Then I should see the following:
      | IsA                       |
  
  Scenario: List occurrences types
    GivenScenario 8 pages
    When I visit /AllOccurrenceTypes
    Then I should see the following:
      | ExternalSource           |
  
  Scenario: View HelpPage
    GivenScenario 8 pages
    When I visit /HelpPage
    Then I should see the following:
      | Help     |
      | IsA      |
      | Specific |
      | ExternalSource |
      | http://google.com/?q=wiki |
  