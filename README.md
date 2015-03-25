# Slack iTunes Connect Autoingestion

This gem will add a Slack outgoing webhook endpoint for pulling iTunes Connect report data and then posting it to your Slack channels.

## Installation

Add this line to your application's Gemfile:
```ruby
gem 'slack_itc_autoingestion'
```

And then run:
```shell
$ bundle install
```

## Configuration
By default the config looks for options set in your environment variables. Override any the defaults in `config/initializers/slack_itc_autoingestion.rb`:

```ruby
SlackItcAutoingestion.configure do |config|
  config.itc_username = ENV['ITUNES_CONNECT_USERNAME']
  config.itc_password = ENV['ITUNES_CONNECT_PASSWORD']
  config.itc_vendor_id = ENV['ITUNES_CONNECT_VENDOR_ID']
  config.slack_token = ENV['SLACK_TOKEN']
  config.slack_webhook_url = ENV['SLACK_WEBHOOK_URL']
  config.slack_command = '/itc'
end
```

## Usage
In any public Slack channel you can type:
`/itc [report_date] [report_date] [date_type] [report_type]`

`report_date` is date in the format `YYYYMMDD`. Defaults to yesterday.
`date_type` is 'Daily' or 'Weekly'. Defaults to 'Daily'.
`report_type` is 'Summary' or 'Opt-In'. Defaults to 'Summary'.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/slack_itc_autoingestion/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
