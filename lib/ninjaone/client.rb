# frozen_string_literal: true

module NinjaOne

  # The `NinjaOne::Client` class acts as a wrapper for the NinjaOne REST API.
  # This class inherits from the `NinjaOne::API` class and includes modules that group
  # the API methods according to the structure in the NinjaOne API documentation.
  #
  # @note All methods are grouped in separate modules for better organization and follow the structure provided in the official API documentation.
  # @see https://developers.skykick.com/Guides/Authentication
  class Client < API

    # Constructs url resource name from url path
    #
    # @param path [String] Resource name
    # @return [String] translated from /- to  _
    def self.resource_to_name(path)
      path.to_s.gsub(/[-\/]/,'_')
    end

    # Dynamically defines methods for interacting with NinjaOne API resources.
    #
    # Depending on the arguments, this will define methods to:
    # - Fetch all records for the given scope
    # - Fetch a resource specific record by ID
    #
    # @param scope [Symbol] The method name for fetching all records.
    # @param resource [String] If given, fetches all records for scope by id. If empty string, it will load single scope record
    #
    # Paging is not supported.
    #
    # @example Defining endpoints
    #   api_endpoint :companies, :company
    #   # Defines:
    #   # - `companies(params = {})` to fetch all companies.
    #   # - `company(id, params = {})` to fetch a single company by ID.
    def self.define_endpoint(scope, resource = nil)
      if resource
        name = self.resource_to_name(scope)
        name = "#{name}_#{self.resource_to_name(resource)}" if resource && !resource.empty?
        # change to nil if resource is empty so we ar eable to generate /scope/id/resource
        # but also /scope/id without training / 
        resource = resource&.empty? ? nil : resource
        send(:define_method, name) do |id, params = {}|
          get(api_url([scope, id, resource].compact.join('/')), params)
        end
      else
        name = self.resource_to_name(scope)
        send(:define_method, name) do |params = {}|
          get(api_url(scope), params)
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
