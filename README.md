# Bonobot
![ci_cd](https://github.com/armandfardeau/bonobot/actions/workflows/ci_cd.yml/badge.svg)
[![codecov](https://codecov.io/gh/armandfardeau/bonobot/branch/master/graph/badge.svg?token=274POQGBAK)](https://codecov.io/gh/armandfardeau/bonobot)

BonoBot is a Ruby gem that helps with Rails monkey patching.

## Usage
### Status
#### Generate all status:
```bash
bundle exec rake bonobot:status
```
#### Generate a specific status:
```bash    
bundle exec rake bonobot:status:up_to_date 
bundle exec rake bonobot:status:out_of_date
bundle exec rake bonobot:status:missing
bundle exec rake bonobot:status:unused
```

### Add missing
```bash
bundle exec rake bonobot:add_missing
```

### Update out of date
```bash
bundle exec rake bonobot:update_out_of_date
```

### Customization
```bash
bundle exec rake bonobot:install
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'bonobot'
```

Or install it yourself as:

```bash
gem install bonobot
```

## Contributing

Contribution directions go here.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).