# frozen_string_literal: true

module NinjaOne
  class Client
    # Contains Organizations API calls for Ninja One.
    #
    # @see https://app.ninjarmm.com/apidocs/?links.active=core#/organization Ninja One Developer Documentation
    module Organizations

      Client::define_endpoint(:organization, 'locations')
      Client::define_endpoint(:organization, 'end-users')
      Client::define_endpoint(:organization, 'custom-fields')
      Client::define_endpoint(:organization, 'devices')
      Client::define_endpoint(:organization, 'locations/backup/usage')

      # Returns a location backup usage
      def organization_backup_usage_by_location(id, location_id, params={})
        get(api_url("organization/#{id}/locations/#{location_id}/backup/usage"), params)
      rescue Faraday::ServerError
        # it looks like a server error is thrown when no backup is available; fake it by returning an empty array
        []
      end
    end
  end
end
