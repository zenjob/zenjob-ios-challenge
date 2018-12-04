Welcome!
===================


This is your iOS app challenge as part of the Zenjob interview process. This repository should contain all necessary information to solve the tasks. As part of your challenge you will develop a iOS  **application** in **Swift** and an additional library set of your choice.

----------


Background
-------------
Zenjob helps business customers to staff job positions rapidly with qualified employees. Based on the description (what, when, where, who) of the companies we are creating job offers for our workers. A worker has the possibility to accept or decline an offer. If he accepts, we match them to job.  If he declines, we continue to offer the job to other worker.

Zenjob provides a mobile app to workers on Android and iOS. After login workers are able to see their offers, jobs and tasks. 

Challenge Overview
-------------

We want you to create a simple application in Swift with reduced functionality set. This means in detail:

 - login
 - a detailed view of an offer

Therefore we are granting you access to our API with the already created user. Please check your mail.

Important: We are securing the API calls with a JWT. No call except the login is authorized without a valid JWT (later more).  


API
-------------

- *baseUrl* https://staging-main.zenjob.org
- *username* "mobile@zenjob.com" (this is only valid user for login)
- *password* "becreative" (password of the user)
- *token*: received in response body after successful login request

----------

- login - request
	 - endpoint: {baseURL}/api/employee/v1/auth
	 - HTTP-method: POST
	 - HTTP-header: 
		 - Content-Type: "application/json"
	 - body (json):
		 - username: "{user}" 
		 - password: "{password}"

- login - response - success
	 - status: 200 OK
	 - body (json): (login-200-response.json)

----------

 - offers - request
	 - endpoint: /api/employee/v1/offers?offset=0
	 - HTTP-method: GET
	 - HTTP-header
		 - Authorization: "Bearer {token}"
	
- offers - response - success
	- status: 200 OK
	- body (json): (offers-200-response.json)

----------

 - offer - request
	 - endpoint: /api/employee/v1/offers/{id}
	 - HTTP-method: GET
	 - HTTP-header
		 - Authorization: "Bearer {token}"
	
 - offer - response - success
	- status: 200 OK
	- body (json): (offer-200-response.json)

----------	

 - SANDBOX create new offer - request
	 - endpoint: /api/employee/v1/sandbox/offer
	 - HTTP-method: POST
	 - HTTP-header
		 - Authorization: "Bearer {token}"
		 - Content-Type: "application/json"
	 - body (json):
		 - shifts: number
		 - instructions: boolean
		 
- example: {shifts: '1', instructions: 'true'
- effect: creates a new job offer for the current logged in user (listable in offers request)


Tasks
-------------

After this wall of text, hopefully you are still super excited about the tasks details.

notes: 
 + The entrypoint of the application is the login view.
 + We grant you access to zeplin. Use the screens as orientation. The more similar your result is looking to the provided screens in zeplin the better.

tasks:
- login
	 - create a login view with a form for login with username and password
		 - on successful login redirect to the list offers view 
- offers
	 - get offers list from api
	 - open first one from the list (or you can open randomly one from the list of offers)
- show offer
	 - get offer details from API
	 - render a detailed offer view with details you can find in the designs

Make you comfortable: after reading all of this you may have questions. Think about it and try to solve it on your own. If there is a major fuckup (api is wrong, information missing etc.) contact your challenge contact person directly. If you are struggling with solving a task: write it down in a structured and understandable way and submit it to your challenge contact person.

Guidelines: Would be great if we can see collection and stack view's in use, and coding UI skills (Don't use Storyboards). Main focus is detail page, login and offer list are just the way to the details page.  Design screen shots just use as guide line.
