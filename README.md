# GOOD-NIGHT
The app work to record user sleep time.

![Build Status](https://github.com/ryeoman/good-night/actions/workflows/ci.yml/badge.svg)

## Build Using
* ruby 3.3.6 (2024-11-05 revision 75015d4c1f) [arm64-darwin24]
* Rails 8.0.0

## System dependencies
* Postgresql 16

## How to Start The App?
* Install all pre-requisite.
* Run postgresql databse.
* Setup databse configuration in `.env`.
```
DATABASE_USERNAME=<database_username>
DATABASE_PASSWORD=<database_password>
DATABASE_HOSTNAME=<databse_hostname>
```
* Run `rails server`. by default you will see it's running at port 3000.

## Unit Test
* Run `rails test:all`. It will generate `/coverage` directory.
* Open `index.html` inside the `/coverage` directory. It will show a web view of the code coverage.
