# frozen_string_literal: true

module NinjaOne
  class Client
    # Contains Device-related API calls for Ninja One.
    #
    # @see https://app.ninjarmm.com/apidocs/?links.active=core#/Devices Ninja One Developer Documentation - Device section
    module Devices
      # Defines a device-specific API endpoint method dynamically.
      #
      # This helper creates instance methods in the form of:
      #   device_<method>(id, params = {})
      #
      # Example:
      #   device_endpoint(:jobs)
      #   # => defines #device_jobs(id, params = {})
      #
      # @param method [Symbol]
      #   The method name suffix to generate (e.g., :jobs, :alerts).
      #
      # @param path [String]
      #   The API path segment. Defaults to the method name with
      #   underscores replaced by hyphens.
      #
      # @return [void]
      def self.device_endpoint(method, path = method.to_s.tr('_', '-'))
        # Define method to fetch all records for device
        send(:define_method, "device_#{method}") do |id, params = {}|
          get(api_url("device/#{id}/#{path}"), params)
        end
      end

      # Retrieves a single device by ID.
      #
      # @param id [Integer, String]
      #   The NinjaOne device ID.
      #
      # @param params [Hash, nil]
      #   Optional query parameters.
      #
      # @return [Hash]
      #   The device details returned by the API.
      def device(id, params = nil)
        get(api_url("device/#{id}"), params)
      end

      # Device-related GET endpoints.
      #
      # Each symbol below dynamically generates a method:
      #   device_<endpoint>(id, params = {})
      #
      # Example:
      #   device_jobs(123)
      #   device_activities(123, since: '2026-01-01T00:00:00Z')
      #
      [:jobs, :activities, :alerts, :disks, :processors, :software, :volumes, :windows_services, :custom_fields,
       :os_patch_installs, :software_patch_installs, :last_logged_on_user, :network_interfaces, :os_patches, :software_patches].each do |m|
        device_endpoint(m)
      end
      device_endpoint(:policy_overrides, 'policy/overrides')
    end
  end
end
