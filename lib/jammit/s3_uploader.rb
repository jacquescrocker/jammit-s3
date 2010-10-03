require 'mimemagic'

module Jammit
  class S3Uploader
    def initialize(bucket)
      @bucket = bucket
    end

    def upload
      puts "Pushing assets to S3 bucket: #{@bucket.name}"
      globs = []

      # add default package path
      if Jammit.gzip_assets
        globs << "public/#{Jammit.package_path}/**/*.gz"
      else
        globs << "public/#{Jammit.package_path}/**/*.css"
        globs << "public/#{Jammit.package_path}/**/*.js"
      end

      # add images
      globs << "public/images/**/*"

      # add custom configuration if defined
      s3_upload_files = Jammit.configuration[:s3_upload_files]
      globs << s3_upload_files if s3_upload_files.is_a?(String)
      globs += s3_upload_files if s3_upload_files.is_a?(Array)

      # upload all the globs
      globs.each do |glob|
        upload_from_glob(glob)
      end
    end

    def upload_from_glob(glob)
      puts "Pushing files from #{glob}"
      puts "#{ASSET_ROOT}/#{glob}"
      Dir["#{ASSET_ROOT}/#{glob}"].each do |local_path|
        next if File.directory?(local_path)
        remote_path = local_path.gsub(/^#{ASSET_ROOT}\/public\//, "")

        use_gzip = false

        # handle gzipped files
        if File.extname(remote_path) == ".gz"
          use_gzip = true
          remote_path = remote_path.gsub(/\.gz$/, "")
        end

        puts "pushing file to s3: #{remote_path}"

        # save to s3
        new_object = @bucket.objects.build(remote_path)
        new_object.content_type = MimeMagic.by_path(remote_path)
        new_object.content = open(local_path)
        new_object.content_encoding = "gzip" if use_gzip
        new_object.save
      end
    end

  end

end