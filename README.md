# OnlyofficeDigitaloceanWrapper

Gem for working with DigitalOcean API

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'onlyoffice_digitalocean_wrapper'
```

And then execute:

```bash
bundle
```

Or install it yourself as:

```bash
gem install onlyoffice_digitalocean_wrapper
```

## Configure

You should get access token via
visiting [this](https://cloud.digitalocean.com/account/api/tokens) url  
Access token can be initialized in two ways:

*. Save to `~/.do/access_token`  

```bash
mkdir ~/.do
echo 'token' > ~/.do/access_token
```

*. Set to `DO_ACCESS_TOKEN` env. Can be setup via `~/.bashrc`

```bash
echo "export DO_ACCESS_TOKEN='token' > ~/.bashrc
```
