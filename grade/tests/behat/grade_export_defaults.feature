@core @core_grades
Feature: Site settings can be used to determine grade export defaults
  In order to change grade export defaults
  As an admin
  I need to modify gradebook related system settings

  Background:
    Given the following "courses" exist:
      | fullname | shortname | category | format |
      | Course 1 | C1        | 0        | topics |
    And I log in as "admin"
    And I navigate to "General settings" node in "Site administration > Grades"

  @javascript
  Scenario Outline: An admin can determine defaults for ods, txt and xlsx grade exports
    Given I set the following fields to these values:
      | Include feedback | <feedback> |
      | Real             | <real>     |
      | Percentage       | <percent>  |
      | Letter           | <letter>   |
      | decimal points   | <decimals> |
    And I press "Save changes"
    When I am on "Course 1" course homepage
    And I navigate to "Export > <format>" in the course gradebook
    And I press "Export format options"
    Then the following fields match these values:
      | Include feedback | <feedback> |
      | Real             | <real>     |
      | Percentage       | <percent>  |
      | Letter           | <letter>   |
      | decimal points   | <decimals> |

    Examples:
      | feedback | real | percent | letter | decimals | format                   |
      | 1        | 0    | 0       | 0      | 0        | Excel spreadsheet        |
      | 0        | 0    | 0       | 1      | 1        | OpenDocument spreadsheet |
      | 1        | 1    | 0       | 1      | 2        | Plain text file          |
      | 0        | 1    | 1       | 1      | 5        | Excel spreadsheet        |

  @javascript
  Scenario Outline: With XML exports the displaytype defaults to real if multiple are selected
    Given I set the following fields to these values:
      | Include feedback | <feedback> |
      | Real             | <real>     |
      | Percentage       | <percent>  |
      | Letter           | <letter>   |
      | decimal points   | <decimals> |
    And I press "Save changes"
    When I am on "Course 1" course homepage
    And I navigate to "Export > XML file" in the course gradebook
    And I press "Export format options"
    Then the following fields match these values:
      | Include feedback | <feedback> |
      | display type     | <type>     |
      | decimal points   | <decimals> |

    Examples:
      | feedback | real | percent | letter | decimals | type   |
      | 1        | 0    | 0       | 0      | 0        | Real   |
      | 0        | 0    | 0       | 1      | 1        | Letter |
      | 1        | 0    | 1       | 1      | 5        | Real   |
