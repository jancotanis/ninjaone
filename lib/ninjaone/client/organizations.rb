# frozen_string_literal: true

module NinjaOne
  class Client
    # Contains Organizations API calls for Ninja One.
    #
    # @see https://app.ninjarmm.com/apidocs/?links.active=core#/organization Ninja One Developer Documentation
    module Organizations
      # Dynamically defines methods for interacting with NinjaOne API resources.
      #
      # Depending on the arguments, this will define methods to:
      # - Fetch all records for a resource
      # - Fetch a specific record by ID
      #
      # @param method [Symbol] The method name for fetching all records.
      # @param singular_method [Symbol, nil] The method name for fetching a single record by ID. Optional.
      # @param path [String] The API path for the resource. Defaults to the method name.
      #
      # @example Defining endpoints
      #   api_endpoint :companies, :company
      #   # Defines:
      #   # - `companies(params = {})` to fetch all companies.
      #   # - `company(id, params = {})` to fetch a single company by ID.
      def self.api_endpoint_suffix(method, suffix)
        # Define method to fetch a single record by ID
        name = "#{method}_#{suffix.gsub(/[-\/]/,'_')}"

        send(:define_method, name) do |id, params = {}|
          get(api_url("#{method}/#{id}/#{suffix}"), params)
        end
      end

      api_endpoint_suffix(:organization, 'locations')
      api_endpoint_suffix(:organization, 'end-users')
      api_endpoint_suffix(:organization, 'custom-fields')
      api_endpoint_suffix(:organization, 'devices')
      api_endpoint_suffix(:organization, 'locations/backup/usage')

      # Returns a location backup usage
      def organization_backup_usage_by_location(id, location_id, params={})
        get(api_url("organization/#{id}/locations/#{location_id}/backup/usage"), params)
      rescue Faraday::ServerError
        # it looks like a server error is thrown when no backup is available; fake it by returning anempty array
        []
      end
    end
  end
end
