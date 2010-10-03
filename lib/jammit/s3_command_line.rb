require 'jammit/command_line'

require 's3'
module Jammit
  class S3CommandLine < CommandLine
    def initialize
      super
      upload_assets_to_s3
    end

    def upload_assets_to_s3
      verify_s3_configuration
      ensure_bucket_exists
      upload_assets
    end

    protected
      def verify_s3_configuration
        unless get_bucket_name.is_a?(String) && get_bucket_name.length > 0
          puts "\nA valid s3_bucket name is required."
          puts "Please add one to your Jammit config (config/assets.yml):\n\n"
          puts "s3_bucket: my-bucket-name\n\n"
          exit
        end
        unless get_access_key_id.is_a?(String) && get_access_key_id.length > 0
          puts "access_key_id: '#{get_access_key_id}' is not valid"
          exit
        end
        unless get_secret_access_key.is_a?(String) && get_secret_access_key.length > 0
          puts "secret_access_key: '#{get_secret_access_key}' is not valid"
          exit
        end
      end

      def upload_assets
        S3Uploader.new(s3_bucket).upload
      end

      def s3_service
        @s3_service ||= S3::Service.new(:access_key_id => get_access_key_id, :secret_access_key => get_secret_access_key)
      end

      def s3_bucket
        @s3_bucket ||= ensure_bucket_exists
      end

      def ensure_bucket_exists
        bucket_name = get_bucket_name

        # find or create the bucket
        bucket = begin
          s3_service.buckets.find(bucket_name)
        rescue S3::Error::NoSuchBucket
          puts "Bucket not found. Creating '#{bucket_name}'..."
          bucket = s3_service.buckets.build(bucket_name)

          begin
            bucket.save(get_bucket_location)
          rescue S3::Error::BucketAlreadyExists => e
            # tell them to pick another name
            puts e.message
            exit
          end
        end
        bucket
      end

      def get_bucket_name
        # TODO: use highline if needed
        Jammit.configuration[:s3_bucket]
      end

      def get_access_key_id
        # TODO: use highline if needed
        Jammit.configuration[:s3_access_key_id]
      end

      def get_secret_access_key
        # TODO: use highline if needed
        Jammit.configuration[:s3_secret_access_key]
      end

      def get_bucket_location
        location = Jammit.configuration[:s3_bucket_location]
        if location == "eu"
          :eu
        else
          :us
        end
      end
  end
end