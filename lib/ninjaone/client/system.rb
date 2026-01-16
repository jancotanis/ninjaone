# frozen_string_literal: true

module NinjaOne
  class Client
    # Contains Core system Entities and Resources API calls for Ninja One.
    #
    # @see https://app.ninjarmm.com/apidocs/?links.active=core#/system Ninja One Developer Documentation
    module System

      Client::define_endpoint(:contacts)
      Client::define_endpoint(:contact, '')
      Client::define_endpoint(:organizations)
      Client::define_endpoint(:organization, '')
      Client::define_endpoint('organizations-detailed')
      Client::define_endpoint(:policies)
      Client::define_endpoint(:jobs)
      Client::define_endpoint(:activities)
      Client::define_endpoint(:alerts)
      Client::define_endpoint('automation/scripts')
      Client::define_endpoint(:devices)
      Client::define_endpoint('devices-detailed')
      Client::define_endpoint('notification-channels/enabled')
      Client::define_endpoint('notification-channels')
      Client::define_endpoint(:groups)
      Client::define_endpoint(:locations)
      Client::define_endpoint(:roles)
      Client::define_endpoint(:tasks)
      Client::define_endpoint('software-products')
      Client::define_endpoint(:users)
      Client::define_endpoint('user/end-users')
      Client::define_endpoint('user/roles')
      Client::define_endpoint('user/technicians')
      Client::define_endpoint('devices/search')
      
      def search_devices(query_string, options={})
        devices_search(options.merge({q:query_string}))
      end

    end
  end
end
