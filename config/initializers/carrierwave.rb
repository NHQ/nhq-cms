CarrierWave.configure do |config|
  config.cache_dir = "#{Rails.root}/tmp/uploads"
  config.root = Rails.root.join('tmp') # adding these...
  config.cache_dir = 'carrierwave' # ...two lines

  config.s3_access_key_id = ENV['s3_access_key_id'] || 'AKIAJSM25IMEGKLQ7TKA'
  config.s3_secret_access_key = ENV['s3_secret_access_key'] || '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'
  config.s3_bucket = ENV['s3_bucket'] || 'clown'
end