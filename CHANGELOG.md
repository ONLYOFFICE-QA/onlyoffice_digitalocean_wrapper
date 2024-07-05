# Change log

## unreleased (master)

### New Features

* Add `ruby-3.2` to CI
* Add `ruby-3.3` to CI
* Add `ruby-head` to CI
* Add `yamllint` check in CI
* Add `droplet_ip` method to get `public`/`private` IP of droplet
* Add CI task to check that there is no running test droplets
* Add `dependabot` check for `GitHub Actions`
* Add `wait_until_droplet_have_status` option `interval` to specify interval between checks

### Fixes

* Fix `markdownlint` failure because of old `nodejs` in CI
* Fix `public_ip` method crash if there is no IP
* Fix test suite by replacing existing droplet name

### Changes

* Use new uploader for `codecov` instead of deprecated one
* Require `mfa` for releasing gem
* Do not allow parallel run in CI
* Check `dependabot` at 8:00 Moscow time daily
* Fix `rubocop-1.28.1` code issues
* Drop `ruby-2.6`, `ruby-2.7` support, since it's EOL'ed
* Remove `ruby-3.0` and `ruby-3.1` from CI to speed up CI
* Run `codecov` in CI only on latest ruby
* Migrate to `codecov-4` CI action

## 0.8.0 (2021-09-12)

### New features

* `SshChecker#ssh_up?` and `SshChecker#wait_until_ssh_up` methods

## 0.7.0 (2021-07-29)

### Changes

* New methods `project_by_name` and `get_project_id_by_name` to work with projects
* Remove `ruby-head` from test matrix

### Fixes

* Fix incorrect setting ruby version in build matrix

## 0.6.0 (2021-02-11)

### New Features

* Add `ruby-3.0` and `ruby-head` in CI

### Changes

* Replace usage of `onlyoffice_logger_helper` with default logger

## 0.5.0 (2020-10-13)

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
* Move all dependencies to `gemspec`
* Unique droplet name in tests. Allow parallel run

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
