##Sape module for Ruby On Rails

[![Gem Version](https://badge.fury.io/rb/sape.png)](http://badge.fury.io/rb/sape)
[![Build Status](https://travis-ci.org/iRet/sape.png?branch=master)](https://travis-ci.org/iRet/sape)

###Rewritten from scratch

### Changes
* parsing xml file instead of php serialized string
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
host: example.com
charset: UTF-8
```

#### Inserting links
Simply put helper call in desired place. Like this:
```ruby
<% # SIMPLE LINKS %>
<%= sape_links -%>

<% # BLOCK LINKS %>
<%= sape_links_block -%>
```

#### Fetching links
* `rake sape:fetch`

Run it by cron or use whenever gem or something other way you like.

#### Customizing templates (optional)
* `rails g sape:views`
* add `*= require sape` to application.css for block links

Templates will be copied to views/sape folder.

### Notes
* In _link.html.erb first and last string inserting sape code recognized by sape bots. It should not be removed. Also important to levae url untouched.

For more information please follow http://www.sape.ru/

License
-------
This project rocks and uses MIT-LICENSE.
Copyright © 2014 Pavel Rodionov