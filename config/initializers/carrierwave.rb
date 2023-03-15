CarrierWave.configure do |config|
  config.storage = :file
  config.enable_processing = false
  config.root = Rails.root.join('public')
  config.cache_dir = 'uploads'
end