## Sape gem for Ruby On Rails

[![Gem Version](https://badge.fury.io/rb/sape.png)](http://badge.fury.io/rb/sape)
[![Build Status](https://travis-ci.org/krim/sape.svg?branch=master)](https://travis-ci.org/krim/sape)

### Rewritten from scratch

### Changes
* parsing json file instead of php serialized string
* storing in database instead of text file
* requesting by rake task instead of checking on every page load
* customizable rails friendly erb templates

### Installation
Include the gem in your Gemfile:
```ruby
gem 'sape'
```

#### Preparing db
* `rails g sape:migration`
* `rake db:migrate`

#### Generating config
* create config/sape.yml
```yml
sape_user: _YOUR_SAPE_HASH_
host:
  - example.com
  - subdomain1.example.com
  - subdomain1.example.com
charset: UTF-8
```

#### Inserting links
Simply put helper call in desired place. Like this:
```ruby
<% # SIMPLE LINKS, custom parameter 'site_host', default: request.host %>
<%= sape_links -%>

<% # BLOCK LINKS, custom parameter 'site_host', default: request.host %>
<%= sape_links_block -%>

<% # CONTEXT LINKS, custom parameter 'site_host', default: request.host %>
<%= sape_context_links text -%>
```

#### Fetching links
* `rake sape:fetch`

Run it by cron or use whenever gem or something other way you like.

#### Customizing templates (optional)
* run `rails g sape:views` for generate views(you can choose erb/haml/slim)
* run `rails g sape:install` to add sape.css to yours app/assets/stylesheets for block links


Templates will be copied to views/sape folder.

### Notes
* In _link.html.erb first and last string inserting sape code recognized by sape bots. It should not be removed. Also important to levae url untouched.

For more information please follow http://www.sape.ru/

License
-------
This project rocks and uses MIT-LICENSE.
Copyright © 2014 Pavel Rodionov
