# Slack iTunes Connect Autoingestion

This gem will add a Slack incoming webhook endpoint for pulling iTunes Connect report data and posting it back to your Slack channel.

## Installation

You can deploy a functioning app right to heroku:

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy?template=https://github.com/thesoapcollective/slack_itc_autoingestion-app)

Or for a DIY setup, add this line to your application's Gemfile:
```ruby
gem 'slack_itc_autoingestion'
```

And then run:
```shell
$ bundle install
```

## Configuration
You'll need to setup two integrations in your Slack:

1. An [Incoming Webhook](https://slack.com/services/new/incoming-webhook). The Webhook URL field will be used in your config below.
2. A [Slash Command](https://slack.com/services/new/slash-commands). The Command and Token fields will be used in your config below. The URL field should be something to the effect of https://example.com/slack_itc_autoingestion.

By default, the config looks for options set in your environment variables. Override the defaults in `config/initializers/slack_itc_autoingestion.rb`:

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
`/itc [report_date] [date_type] [report_type]`

`report_date` is date in the format `YYYYMMDD`. Defaults to 24 hours ago.

`date_type` is 'Daily' or 'Weekly'. Defaults to 'Daily'.

`report_type` is 'Summary' or 'Opt-In'. Defaults to 'Summary'.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/slack_itc_autoingestion/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
