# Instruction To use
  * **bundle install**
  * We are using **postgres** database so config database.yml file
  * **rake db:migrate**
  * **rake db:seed** is used to run the fake data for headlines app, it also creates admin user is admin@example.com and password is password
  * Now user can signup and can create links/news/title that will be visible for all the user and also upvote and down vote option will be enabled if user is logged in
  * admin has option to approve that