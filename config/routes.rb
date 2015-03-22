Rails.application.routes.draw do

  post :slack_itc_autoingestion, to: 'slack_itc_autoingestion/slack#receiver'

end
