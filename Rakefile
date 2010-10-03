require 'rake/testtask'

task :gem => "gem:build"


namespace :gem do
  desc "Build the jammit gem"
  task :build do
    sh "mkdir -p pkg"
    sh "gem build jammit-s3.gemspec"
  end


end

