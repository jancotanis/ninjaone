# frozen_string_literal: true

module NinjaOne

  # The `NinjaOne::Client` class acts as a wrapper for the NinjaOne REST API.
  # This class inherits from the `NinjaOne::API` class and includes modules that group
  # the API methods according to the structure in the NinjaOne API documentation.
  #
  # @note All methods are grouped in separate modules for better organization and follow the structure provided in the official API documentation.
  # @see https://developers.skykick.com/Guides/Authentication
  class Client < API
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
    def self.api_endpoint(method, singular_method = nil, path = method.to_s.tr('_', '-'))
      # Define method to fetch all records
      send(:define_method, method) do |params = {}|
        get_paged(api_url(path), params)
      end
      # Define method to fetch a single record by ID
      if singular_method
        send(:define_method, singular_method) do |id, params = {}|
          get(api_url("#{singular_method}/#{id}"), params)
        end
      end
    end

    # Dynamically require all files in the `client` directory.
    # This will load additional API modules as separate files for better modularity and code organization.
    Dir[File.expand_path('client/*.rb', __dir__)].each { |f| require f }

    # Include API client modules for specific NinjaOne API functionalities.
    # These modules provide methods for interacting with specific parts of the NinjaOne API,
    # such as managing backups and handling alerts.
    include NinjaOne::Client::System
    include NinjaOne::Client::Organizations
    include NinjaOne::Client::Backup
    include NinjaOne::Client::Devices

    # Constructs the full API URL for a given path.
    #
    # @param path [String] The API path.
    # @return [String] The full API URL.
    def api_url(path)
      "/v2/#{path}"
    end

  end
end
