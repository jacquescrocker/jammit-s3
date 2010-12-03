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
          if Jammit.configuration[:use_cloudfront] && Jammit.configuration[:cloudfront_domain].present?
            asset_hostname = Jammit.configuration[:cloudfront_domain]
          else
            asset_hostname = "#{Jammit.configuration[:s3_bucket]}.s3.amazonaws.com"
          end

          if Jammit.package_assets and asset_hostname.present?
            ActionController::Base.asset_host = Proc.new do |source, request|
              "#{Jammit.configuration[:ssl] || request.protocol}://#{asset_hostname}"
            end
          end
        end
      end
    end
  end
end
