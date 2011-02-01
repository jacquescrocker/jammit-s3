Gem::Specification.new do |s|
  s.name      = 'jammit-s3'
  s.version   = '0.6.0.2'

  s.homepage    = "http://documentcloud.github.com/jammit/"
  s.summary     = "Asset Packaging for Rails with Deployment to S3/Cloudfront"
  s.description = <<-EOS
    Jammit-S3 is an extension to the awesome Jammit library that handles deployment to s3 and cloudfront.
  EOS

  s.authors           = ['Jacques Crocker']
  s.email             = 'railsjedi@gmail.com'
  s.rubyforge_project = 'jammit-s3'

  s.require_paths     = ['lib']
  s.executables       = ['jammit-s3']

  s.add_dependency 'jammit',    '>= 0.5.4'
  s.add_dependency 'mimemagic',  '>= 0.1.7'
  s.add_dependency 's3', ">= 0.3.7"
  s.add_dependency 'ruby-hmac'

  s.files = Dir['lib/**/*', 'bin/*', 'jammit-s3.gemspec', 'LICENSE', 'README']
end
