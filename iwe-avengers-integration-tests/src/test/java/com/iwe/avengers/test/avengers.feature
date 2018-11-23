Feature: Perform integrated tests on the Avengers registration API

Background:
* url 'https://tk82m6ewu2.execute-api.us-east-1.amazonaws.com/dev/'

Scenario: Get Avenger by Id

Given path 'avengers', 'aaaa-bbbb-cccc-dddd'
When method get
Then status 200
And match response == {id: '#string', name: 'Iron Man', secretIdentity: 'Tony Stark'}

Scenario: Update Avenger by Id

Given path 'avengers', 'aaaa-bbbb-cccc-dddd'
And request {name: 'Iron Man', secretIdentity: 'Tony Stark'}
When method put
Then status 200
And match response == {id: '#string', name: 'Iron Man', secretIdentity: 'Tony Stark'}

Scenario: Must return 400 for invalid update payload

Given path 'avengers', 'aaaa-bbbb-cccc-dddd'
And request  {secretIdentity: 'Tony Stark'}
When method put
Then status 400

Scenario: Get Avenger list

Given path 'avengers'
When method get
Then status 200
And match response == {id: '#string', name: '#string', secretIdentity: '#string'}

Scenario: Delete Avenger by Id

Given path 'avengers', 'aaaa-bbbb-cccc-dddd'
When method delete
Then status 204
And match response == ''

Scenario: Create Avenger

Given path 'avengers'
And request {name: 'Iron Man', secretIdentity: 'Tony Stark'}
When method post
Then status 201
And match response == {id: '#string', name: 'Iron Man', secretIdentity: 'Tony Stark'}

Scenario: Must return 400 for invalid creation payload

Given path 'avengers'
And request {secretIdentity: 'Tony Stark'}
When method post
Then status 400