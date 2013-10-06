OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '200686890113774', '346a7c4dbb7115ae13b7e48dab226b6f'
end