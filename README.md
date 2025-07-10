# geokit_aws_geoplaces
Geokit module to use AWS GeoPlaces service for geocoding


Custom [geokit](https://github.com/geokit/geokit) geocoder for [AWS Geoplaces](https://aws.amazon.com/location/) service.

[API Documentation](https://docs.aws.amazon.com/cli/latest/reference/geo-places/)


## Installation

Add this line to your application's Gemfile:

    gem 'geokit_aws_geoplaces'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install geokit_aws_geoplaces

## Configuration


```ruby
    # This is your AWS credentials. Setting it up is beyond the scope of this
    # document, but be sure that your IAM profile is allowed to use the GeoPlaces service
    # See https://aws.amazon.com/location/
    Geokit::Geocoders::AwsGeospacesGeocoder.region = 'your-aws-region (us-east-1?)'
    Geokit::Geocoders::AwsGeospacesGeocoder.access_key_id = 'YOUR_ACCESS_KEY_ID'
    Geokit::Geocoders::AwsGeospacesGeocoder.secret_access_key = 'YOUR_SECRET_ACCESS_KEY'
```


## Usage

```ruby
    # use :aws_geospaces to specify this geocoder in your list of geocoders.
    Geokit::Geocoders::AwsGeospacesGeocoder.geocode("Sunnyvale, CA")
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/geokit_aws_geospaces/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request