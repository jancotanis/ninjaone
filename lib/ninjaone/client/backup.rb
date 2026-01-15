# frozen_string_literal: true

module NinjaOne
  class Client
    # Contains Backup-related API calls for Ninja One.
    #
    # @see https://app.ninjarmm.com/apidocs/?links.active=core#/Backup Ninja One Developer Documentation - Backup section
    module Backup
      # Dynamically defines methods for interacting with NinjaOne API resources.
      #
      # Depending on the arguments, this will define methods to:
      # - Fetch all records for a resource
      # - Fetch a specific record by ID
      #
      # @param method [Symbol] The method name for fetching all records.
      # @param path [String] The API path for the resource. Defaults to the method name.
      #
      # @example Defining endpoints
      #   api_endpoint :companies, :company
      #   # Defines:
      #   # - `companies(params = {})` to fetch all companies.
      #   # - `company(id, params = {})` to fetch a single company by ID.
      def self.backup_endpoint(method, path = method.to_s.tr('_', '-'))
        # Define method to fetch all records
        send(:define_method, method) do |params = {}|
          results = get(api_url(path), params)
          results.results
        end
      end

      # Backup endpoints (GET)
      backup_endpoint(:backup_jobs, 'backup/jobs')
      backup_endpoint(:backup_integrity_check_jobs, 'backup/integrity-check-jobs')

    end
  end
end
