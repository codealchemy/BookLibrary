## README ![CI](https://github.com/codealchemy/BookLibrary/workflows/CI/badge.svg) [![Code Climate](https://codeclimate.com/github/codealchemy/BookLibrary/badges/gpa.svg)](https://codeclimate.com/github/codealchemy/BookLibrary)

BookLibrary is a Ruby on Rails application to manage a library of items that
are checked out and in by users.

Application basics:

*   Ruby version: `2.6`
*   Rails version: `5.2`

*   Configuration
*   Postgres Database
*   Sendgrid for ActionMailer (sendgrid gem)
    https://github.com/stephenb/sendgrid

*   Database creation - to set up the database:
*   run `rake db:create`
*   then `rake db:migrate`

*   Deployment instructions
*   This project uses dotenv for environment variables, more here:
    https://github.com/bkeepers/dotenv
