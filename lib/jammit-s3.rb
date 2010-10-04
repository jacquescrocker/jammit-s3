require 'jammit/command_line'
require 'jammit/s3_command_line'
require 'jammit/s3_uploader'

module Jammit
  def self.upload_to_s3!(options = {})
    S3Uploader.new(options).upload
  end
end

if defined?(Rails)
  module Jammit
    class JammitRailtie < Rails::Railtie
      initializer "set asset host and asset id" do
        config.after_initialize do
          s3_bucket = Jammit.configuration[:s3_bucket]
          if Jammit.package_assets and s3_bucket.present?
            ActionController::Base.asset_host = "http://#{Jammit.configuration[:s3_bucket]}.s3.amazonaws.com"
          end
        end
      end
    end
  end
end