require 'aws-sdk-geoplaces'
require 'geokit'

module Geokit
  module Geocoders

    # and use :aws_geoplaces to specify this geocoder in your list of geocoders.
    class AwsGeoplacesGeocoder < Geocoder

      # Use via:
      #   Geokit::Geocoders::AwsGeoplacesGeocoder.region = "<your aws region>"
      #   Geokit::Geocoders::AwsGeoplacesGeocoder.access_key_id = "<your key>"
      #   Geokit::Geocoders::AwsGeoplacesGeocoder.secret_access_key = "<your secret>"
      config :region, :access_key_id, :secret_access_key

      private

      def self.do_geocode(address, options = {})
        client = Aws::GeoPlaces::Client.new(
          region: region,
          credentials: Aws::Credentials.new( access_key_id, secret_access_key )
        )
        res = client.geocode(query_text: address)
        return GeoLoc.new unless res.successful?

        parse_response res
      end

      def self.parse_response(res)
        return GeoLoc.new unless res.result_items.size > 0
        result_item = res.result_items.first

        extract_geoloc result_item
      end

      def self.extract_geoloc(result_item)
        loc = new_loc
        loc.lat = result_item.position[1]
        loc.lng = result_item.position[0]

        set_address_components(result_item, loc)
        set_precision(result_item, loc)
        set_bounds(result_item, loc)

        loc.success  = true
        loc
      end

      def self.set_address_components(result_item, loc)
        address = result_item.address

        loc.country      = address.country.name
        loc.country_code = address.country.code_2
        loc.city         = address.locality
        loc.district     = address.district
        loc.zip          = address.postal_code

        if address.region.present?
          loc.state_code = address.region.code
          loc.state_name = address.region.name
          loc.state      = address.region.name
        end

        if address.sub_region.present?
          loc.county     = address.sub_region.name
        end

        if result_item.place_type.to_s == "PointAddress"
          loc.street_address = "#{address.address_number} #{address.street}"
          loc.street_name    = address.street
          loc.street_number  = address.address_number
          loc.full_address   = address.label
        end
      end

      PRECISION_MAP = {
        "PointAddress" => "address",
        "Street"       => "street",
        "Locality"     => "city",
        "PostalCode"   => "zip",
        "Region"       => "state",
        "Country"      => "country"
      }

      def self.set_precision(result_item, loc)
        loc.precision = PRECISION_MAP[result_item.place_type] || 'unknown'
      end

      def self.set_bounds(result_item, loc)
        map_view = result_item.map_view

        loc.suggested_bounds = Bounds.normalize(
          [ map_view[1], map_view[0] ],
          [ map_view[3], map_view[2] ]
        )
      end
    end

  end
end
