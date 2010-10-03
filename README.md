# Jammit S3

## Introduction

Jammit S3 is a jammit wrapper that provides appropriate hooks so you can easily deploy your assets to s3/cloudfront

It's especially great for Heroku user who use generated assets such as coffee-script and sass. jammit-s3 includes a script you can use as a hook to recompile and upload all your assets.


## Installation

To install jammit-s3, just use:

    gem install jammit-s3

If you are using Rails3, add it to your project's `Gemfile`:

    gem 'jammit-s3'


## Configuration

Within your `config/assets.yml`, just add a toplevel key called `s3_bucket` that contains the bucketname you want to use. If jammit-s3 doesn't find the bucket, it will try to create it. Bucketnames need to be globally unique. Learn more about bucketnames [here](http://support.rightscale.com/06-FAQs/FAQ_0094_-_What_are_valid_S3_bucket_names%3F)

    s3_bucket: my-awesome-jammit-bucket

## Deployment

To deploy your files to s3, just the jammit-s3 command at your project's root.

    jammit-s3

If using it in the context of your Rails3 app, I'd recommend using `bundle exec`

    bundle exec jammit-s3

## Saving Authentication Info

Every time you run jammit-s3 it will ask you for your Amazon credentials. To avoid this, you can set them in your `config/assets.yml`

    s3_access_key_id: 03HDMNF59CWZ2J24T702
    s3_secret_access_key: 1TzRlDmuH8DoOlJ2tlwW8qx+i+Pfe0jzIouWI2BL

Replace these with your own access keys, found [here](https://aws-portal.amazon.com/gp/aws/developer/account/index.html?ie=UTF8&action=access-key).

As you probably don't want to check this data into source control, I'd recommend you just set it to an environment variable on your local box, and use ERB

    s3_access_key_id: <%= ENV['S3_ACCESS_KEY_ID'] %>
    s3_secret_access_key: <%= ENV['S3_SECRET_ACCESS_KEY'] %>

You can then set these env variables in your .bash_profile




## Using Cloudfront

To use cloudfront, just enable it in your config/assets.yml by adding a toplevel key:

    use_cloudfront: true

For this to work you need to make sure you have the cloudfront enabled via you Amazon acccount page. Go here: http://aws.amazon.com/cloudfront/ and click "Sign Up"


## Jammit Documentation

For documentation, usage, and examples, see:
http://documentcloud.github.com/jammit/

To suggest a feature or report a bug:
http://github.com/documentcloud/jammit/issues/

For internal source docs, see:
http://documentcloud.github.com/jammit/doc/
