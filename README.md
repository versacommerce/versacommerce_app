# VersaCommerce App Generator

VersaCommerce application generator for Rails 5.1+

## Description

This gem makes it easy to get a Rails 5.1+ app up and running with the VersaCommerce API.

The generator creates a basic SessionsController for authenticating with your shop and a HomeController which displays basic information about your products, orders and the shop itself.

*Note: It's recommended to use this on a new Rails project, so that the generator won't overwrite/delete some of your files.*

## Register your app first

To use the VersaCommerce API you will need an application registration for your store.

1. SignUp as an developer: http://app.versacommerce.de/developer/signup
2. Login to your developer account: http://app.versacommerce.de/developer
3. Register your app.


## Installation

``` sh
# Create a new rails app
$ rails new my_versacommerce_app
$ cd my_versacommerce_app

# Add the gem versacommerce_app to your Gemfile
$ gem 'versacommerce_app'
$ bundle install
```

## Usage

``` sh
$ rails generate versacommerce_app your_app_api_key your_app_secret
```

### Example

``` sh
$ rails generate versacommerce_app aabbcc1122334455667788 gghhhiijjkk998877665544
```

This will create a SessionsController and HomeController with their own views.

## Configuring VersaCommerce App

It's possible to set your API key and secret key from different sources:

* Configuration in a Rails `<environment>.rb` config file

``` ruby
config.versacommerce.api_key = 'your api key'
config.versacommerce.secret = 'your secret'
```

* Configuration loaded from `<environment>` key in `versacommerce_app.yml`

``` yaml
development:
  api_key: your api key
  secret: your secret
```

* Configuration loaded from .env file into ENV (additional gems like 'dotenv' might be needed)

## Next...

Start your application:

``` sh
$ rails server
```

Now visit http://localhost:3000 and register (install) your application with a VersaCommerce store. Even if Rails tells you to visit your app at http://0.0.0.0:3000, go to http://localhost:3000.

After your application has been given whatever API permissions, you're ready to start experimenting with the VersaCommerce API. Have Fun :)
