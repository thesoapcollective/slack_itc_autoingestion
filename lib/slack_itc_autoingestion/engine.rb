module SlackItcAutoingestion
  class Engine < Rails::Engine
    initializer 'slack_itc_autogestion.assets.precompile' do |app|
      app.config.assets.precompile += %w( slack_itc_autoingestion/itunesconnect_app_icon.png )
    end
  end
end
