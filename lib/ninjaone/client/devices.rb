# frozen_string_literal: true

module NinjaOne
  class Client
    # Contains Device-related API calls for Ninja One.
    #
    # @see https://app.ninjarmm.com/apidocs/?links.active=core#/Devices Ninja One Developer Documentation - Device section
    module Devices

      Client::define_endpoint(:device, '')

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
       :os_patch_installs, :software_patch_installs, :last_logged_on_user, :network_interfaces, :os_patches, :software_patches].each do |resource|
        Client::define_endpoint(:device, resource.to_s.gsub('_','-'))
      end
      Client::define_endpoint(:device, 'policy/overrides')
    end
  end
end
