if Rails.env.development?
  CarrierWave.configure do |config|
    config.cache_storage = :file
  end
elsif Rails.env.test?
  CarrierWave.configure do |config|
    config.cache_storage = :file
  end
else
  CarrierWave.configure do |config|
    config.fog_credentials = {
        provider: 'AWS',
        aws_access_key_id: ENV['S3_ACCESS_KEY_ID'],
        aws_secret_access_key: ENV['S3_SECRET_ACCESS_KEY'],
        region: 'ap-northeast-1'
    }

    config.fog_directory  = 'twinkpot'
    config.cache_storage = :fog
    config.asset_host = 'https://d2s3o16np0186r.cloudfront.net/'
  end
end