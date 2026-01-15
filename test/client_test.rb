# frozen_string_literal: true

require 'logger'
require 'test_helper'

CLIENT_LOGGER = 'client_test.log'
File.delete(CLIENT_LOGGER) if File.exist?(CLIENT_LOGGER)

describe 'client' do
  before do
    NinjaOne.reset
    NinjaOne.configure do |config|
      config.client_id     = ENV['NINJA1_CLIENT_ID']
      config.client_secret = ENV['NINJA1_CLIENT_SECRET']
      config.endpoint      = ENV['NINJA1_ENDPOINT']
    end
    @client = NinjaOne.client({ logger: Logger.new(CLIENT_LOGGER) })
    @client.login
  end
  it '#0 touch config' do
    @client.config
  end
  it '#1 GET /v2/contacts' do
    c = @client.contacts
    if c.any?
      # get first
      contact = @client.contact(c.first.id)
      assert_equals c.first.name, contact.name
    else
      # no contact found
#      @client.contact(-1)
    end
  end
  [:organizations_detailed, :policies, :jobs, :activities, :alerts, :automation_scripts, :devices,
   :devices_detailed, :enabled_notification_channels, :notification_channels, :groups, :locations, :roles, :tasks,
   :software_products, :users, :user_end_users, :user_roles, :user_technicians].each do |method|
    it "#2 all System methods client.#{method}()" do
      _result = @client.send(method)
    end
  end
  it '#3 GET /v2/devices/search' do
    # not sure what th query format is
    _d = @client.search_devices('WORKSTATION')
  end
  it '#4 GET /v2/organization(s)' do
    o = @client.organizations
    if o.any?
      # get devices for first organization
      id = o.first.id
      organization = @client.organization(id)
      assert_equal organization.name, o.first.name
      locations = @client.organization_locations(id)
      _users = @client.organization_end_users(id)
      _custom_fields = @client.organization_custom_fields(id)
      _devices = @client.organization_devices(id)
      _backup = @client.organization_locations_backup_usage(id)
      _location_backup = @client.organization_backup_usage_by_location(id, locations.first.id) if locations.any?
    end
  end
end
