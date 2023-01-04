# README

____

The "bbq" is a training program for various events.

____

## Versions

* Ruby version 3.1.2
* Rails version 7.0.3.1

## Start settings

```
bundle
bundle exec rails assets:precompile
```

## Database

Copy the database.yml.example file to the database.yml file.
Edit the database.yml file to configure for your database.

```
RAILS_ENV=production bundle exec rails db:migrate (for Production)
```
