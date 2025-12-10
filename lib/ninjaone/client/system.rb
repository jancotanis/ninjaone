# frozen_string_literal: true

module NinjaOne
  class Client
    # Contains Core system Entities and Resources API calls for Ninja One.
    #
    # @see https://app.ninjarmm.com/apidocs/?links.active=core#/system Ninja One Developer Documentation
    module System

      Client::api_endpoint(:contacts, :contact)
      Client::api_endpoint(:organizations,:organization)
      Client::api_endpoint(:organizations_detailed)
      Client::api_endpoint(:policies)
      Client::api_endpoint(:jobs)
      Client::api_endpoint(:activities)
      Client::api_endpoint(:alerts)
      Client::api_endpoint(:automation_scripts, nil, 'automation/scripts')
      Client::api_endpoint(:devices)
      Client::api_endpoint(:devices_detailed)
      Client::api_endpoint(:enabled_notification_channels, nil, 'notification-channels/enabled')
      Client::api_endpoint(:notification_channels)
      Client::api_endpoint(:groups)
      Client::api_endpoint(:locations)
      Client::api_endpoint(:roles)
      Client::api_endpoint(:tasks)
      Client::api_endpoint(:software_products)
      Client::api_endpoint(:users)
      Client::api_endpoint(:user_end_users, nil, 'user/end-users')
      Client::api_endpoint(:user_roles, nil, 'user/roles')
      Client::api_endpoint(:user_technicians, nil, 'user/technicians')
      Client::api_endpoint(:devices_search, nil, 'devices/search')
      
      def search_devices(query_string, options={})
        devices_search(options.merge({q:query_string}))
      end

    end
  end
end
