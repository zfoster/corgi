# Corgi!
[![Build Status](https://travis-ci.org/southpolesteve/corgi.png?branch=master)](https://travis-ci.org/southpolesteve/corgi)
[![Dependency Status](https://gemnasium.com/southpolesteve/corgi.png)](https://gemnasium.com/southpolesteve/corgi)
[![Code Climate](https://codeclimate.com/github/southpolesteve/corgi.png)](https://codeclimate.com/github/southpolesteve/corgi)
[![Coverage Status](https://coveralls.io/repos/southpolesteve/corgi/badge.png)](https://coveralls.io/r/southpolesteve/corgi)

MADi is an open source community network that uses your existing social connections to identify and show you the Greater Madison tech and entrepreneurship events you need to know about.

## Setup

- Deploy to heroku
- Add sentry
- Migrate database on heroku
- Add hstore to database
- Setup config (ask current developer for application.yml local config)

### Configuration

Corgi stores all configuration in environment variables on heroku.

#### Rails Secret Key

`rake secret`

### Contribute

- Fork the project
- Work on a current issue or, if you have an idea, submit an issue
- Submit a pull request (with tests!)