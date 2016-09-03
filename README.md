## README [![Build Status](https://travis-ci.org/codealchemy/BookLibrary.svg?branch=master)](https://travis-ci.org/codealchemy/BookLibrary) [![Code Climate](https://codeclimate.com/github/codealchemy/BookLibrary/badges/gpa.svg)](https://codeclimate.com/github/codealchemy/BookLibrary) [![Test Coverage](https://codeclimate.com/github/codealchemy/BookLibrary/badges/coverage.svg)](https://codeclimate.com/github/codealchemy/BookLibrary/coverage)

BookLibrary is a Ruby on Rails application to manage a library of items that
are checked out and in by users.

Application basics:

*   Ruby version: `2.3.1`
*   Rails version: `4.2.7.1`

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
