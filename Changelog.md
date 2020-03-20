# Change log

# unreleased (master)

# 0.4.0 (2020-03-20)

## New features

* Droplet are created with enabled monitoring
* Add rake task to release gem

## Changes

* Cleanup gemspec
* `rake` is developer dependency
* Remove all kernel methods

# 0.3.0 (2020-02-27) 

## New Features

* Update `droplet_kit` for major ver. 3
* Add check of droplet size for creation
* Do not force 2.0.1 of `droplet_kit`
* Change default region to `nyc3`
* Add ability to retry request if error happened
* Do not try to read new token if old token is incorrect
* Add Rakefile and tasks for releasing gem

### changes
* `wait_until_droplet_have_status` now raise DropletOperationTimeout if timeout reached
* Remove `activesupport` dependency

# 0.2.0
* Force use ruby 2.2 to be able use `activesupport 5` 

# 0.1.0
* Add ability to set tags for restored instances

## 0.0.1
* Initial release of `onlyoffice_webdriver_wrapper` gem
