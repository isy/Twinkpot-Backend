if defined?(AssetSync)
  AssetSync.configure do |config|
    config.fog_provider          = 'AWS'
    Fog.credentials              = { path_style: true }
    config.aws_access_key_id     = ENV['S3_ACCESS_KEY_ID']
    config.aws_secret_access_key = ENV['S3_SECRET_ACCESS_KEY']
    config.fog_directory         = 'twinkpot'
    config.fog_region            = 'ap-northeast-1'
    config.existing_remote_files = 'delete'
    config.gzip_compression      = true
    config.manifest              = true

    config.add_local_file_paths do
      Dir.chdir(Rails.root.join('public')) do
        Dir[File.join('packs', '/**/**')]
      end
    end
  end
end