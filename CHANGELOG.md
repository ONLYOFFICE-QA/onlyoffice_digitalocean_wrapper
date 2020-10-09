# Change log

## unreleased (master)

### New Features

* Add support of `markdownlint` in CI
* Add `rubocop` check in CI
* Add support of `rubocop-performance`, `rubocop-rake` and `rubocop-rspec`
* Add task to CI to check that 100% code documented
* Add params to `#read_token` method
* Add dependabot config

### Changes

* Use GitHub Actions instead of Travis CI
* Freeze specific `rubocop` version in gemspec
* Actualize rubocop todo to `0.92.0` and fix some issues
* Drop support of ruby <= 2.4 since they're EOLed
* Add missing documentation
* Move repo to `ONLYOFFICE-QA` organization
* Fix `rake` command for releasing gem on RubyGems
* Fix `CHANGELOG.md` file name case
* Freeze dependencies via adding Gemfile.lock to VCS
* Do no freeze specific version in `gemspec`

## 0.4.1 (2020-10-05)

### Fixes

* Get public ip of created Droplet

## 0.4.0 (2020-03-20)

### New features

* Droplet are created with enabled monitoring
* Add rake task to release gem

### Changes

* Cleanup gemspec
* `rake` is developer dependency
* Remove all kernel methods

## 0.3.0 (2020-02-27)

### New Features

* Update `droplet_kit` for major ver. 3
* Add check of droplet size for creation
* Do not force 2.0.1 of `droplet_kit`
* Change default region to `nyc3`
* Add ability to retry request if error happened
* Do not try to read new token if old token is incorrect
* Add Rakefile and tasks for releasing gem

### Changes

* `wait_until_droplet_have_status` now raise DropletOperationTimeout if timeout reached
* Remove `activesupport` dependency

## 0.2.0

* Force use ruby 2.2 to be able use `activesupport 5`

## 0.1.0

* Add ability to set tags for restored instances

## 0.0.1

* Initial release of `onlyoffice_webdriver_wrapper` gem
