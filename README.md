# Business and product manager
> A simple application for company and subscriber registrations, developed in two parts, front-end and back-end, using api / endpoint resource.
The backend is hosted on heroku.com and the front end hosted pages.github.io on another external server using the api.


![](header.png)

## Installation

Back-end: Ruby on Rails


```sh
git clone https://github.com/brenothales/rdstation-api.git
```

Installation of gem

```sh
cd rdstation-api && bundle install
```

Create database:

```sh
rails db:create && rails db:migrate
```

Start Serve

```sh
rails s
```
Front-end: Angular 5

```sh
git clone https://github.com/brenothales/rdstation-client
```

Install:

```sh
npm install && ng server
```

For local authentication use
```sh
https://mailcatcher.me/
```
## Usage example

Access the address will note that it will open in github, therefore the application is ho heroku. [Front-end](https://brenothales.github.io/
and [Back-end]https://rdstationapi.herokuapp.com/

## Authentication

```sh
username: demo@rdstation.com e passord:demo123456
```

## endpoint/api

* User|Auth
    * http://localhost:3000/api/v1/auth/
Company index
    * http://localhost:3000/api/v1/companies/
        [index, create, update, destroy]
Product
    * http://localhost:3000/api/v1/products/
        [create, update, destroy]
## Meta

Finish deploying the view of subscribers
