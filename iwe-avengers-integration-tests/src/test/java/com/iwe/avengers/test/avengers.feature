Feature: Perform integrated tests on the Avengers registration API

Background:
* url 'https://tk82m6ewu2.execute-api.us-east-1.amazonaws.com/dev/'

* def getToken =
"""
function() {
 var TokenGenerator = Java.type('com.iwe.avengers.test.authorization.TokenGenerator');
 var sg = new TokenGenerator();
 return sg.getToken();
}
"""
* def token = call getToken

Scenario: Should return invalid access

Given path 'avengers', 'any-id'
When method get
Then status 401


Scenario: Should return not found Avenger

Given path 'avengers', 'not-found-id'
And header Authorization = 'Bearer ' + token
When method get

Then status 404

Scenario: Update Avenger by Id

Given path 'avengers'
And header Authorization = 'Bearer ' + token
And request {name: 'Iron Man', secretIdentity: 'Tony Stark'}
When method post
Then status 201
And match response == {id: '#string', name: 'Iron Man', secretIdentity: 'Tony Stark'}

* def savedAvenger = response

Given path 'avengers', savedAvenger.id
And header Authorization = 'Bearer ' + token
And request {name: 'Batman', secretIdentity: 'Bruce Wayne'}
When method put
Then status 200
And match response == {id: '#string', name: 'Batman', secretIdentity: 'Bruce Wayne'}

* def updatedAvenger = response

Given path 'avengers', updatedAvenger.id
And header Authorization = 'Bearer ' + token
When method get
Then status 200
And match response == updatedAvenger

Scenario: Must return 400 for invalid update payload

Given path 'avengers', 'aaaa-bbbb-cccc-dddd'
And header Authorization = 'Bearer ' + token
And request  {secretIdentity: 'Tony Stark'}
When method put
Then status 400

Scenario: Must return 404 avenger not found

Given path 'avengers', 'not-found-id'
And header Authorization = 'Bearer ' + token
And request  {name: 'Iron Man', secretIdentity: 'Tony Stark'}
When method put
Then status 404

Scenario: Delete Avenger by Id

Given path 'avengers'
And header Authorization = 'Bearer ' + token
And request {name: 'Iron Man', secretIdentity: 'Tony Stark'}
When method post
Then status 201
And match response == {id: '#string', name: 'Iron Man', secretIdentity: 'Tony Stark'}

* def savedAvenger = response

Given path 'avengers', savedAvenger.id
And header Authorization = 'Bearer ' + token
When method delete
Then status 204

Given path 'avengers', savedAvenger.id
And header Authorization = 'Bearer ' + token
When method get
Then status 404

Scenario: Delete Avenger by Id, should by not found 

Given path 'avengers', 'not-found-id'
And header Authorization = 'Bearer ' + token
When method delete
Then status 404


Scenario: Create Avenger

Given path 'avengers'
And header Authorization = 'Bearer ' + token
And request {name: 'Iron Man', secretIdentity: 'Tony Stark'}
When method post
Then status 201
And match response == {id: '#string', name: 'Iron Man', secretIdentity: 'Tony Stark'}

* def savedAvenger = response


Given path 'avengers', savedAvenger.id
And header Authorization = 'Bearer ' + token
When method get
Then status 200
And match response == savedAvenger


Scenario: Must return 400 for invalid creation payload

Given path 'avengers'
And header Authorization = 'Bearer ' + token
And request {secretIdentity: 'Tony Stark'}
When method post
Then status 400