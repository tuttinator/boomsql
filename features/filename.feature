Feature: Passing an argument
  In order to parse an SQL file
  I want to execute boomsql with a file
  So that boomsql will execute that sql query

  Scenario: App is passed a file name
    When I run `boomsql spec/fixtures/infoesearch_qa_sessions.sql`
    Then the exit status should be 0
