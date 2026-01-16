# NinjaOne RMM API

[![Version](https://img.shields.io/gem/v/ninjaone.svg)](https://rubygems.org/gems/ninjaone)

This is a wrapper for the ninjaone API.
You can see the [API endpoints](https://app.ninjarmm.com/apidocs/)

Currently only the GET requests to endpoints 
are implemented (readonly).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ninjaone'
```

And then execute:

```console
> bundle install
```

Or install it yourself as:

```console
> gem install ninjaone
```

## Usage

### Authentication

Before you start making the requests to API provide the client id and client secret
and email/password using the configuration wrapping.

```ruby
require 'ninjaone'

NinjaOne.configure do |config|
  config.client_id = ENV['NINJA1_CLIENT_ID']
  config.client_secret = ENV['NINJA1_CLIENT_SECRET']
  config.endpoint = ENV['NINJA1_ENDPOINT']
end
client = NinjaOne.client()
client.login

o = client.organizations

o.each do |organization|
  puts "#{organization.name}"
end
```

## Resources

### Authentication

```ruby
# setup configuration
#
client.login

```

|Resource|API endpoint|
|:--|:--|
|`login`|https://app.ninjarmm.com/apidocs/?links.active=authorization|

### System

Core system Entities and Resources

```ruby
subscriptions = client.subscriptions
```

|Resource|API endpoint|
|:--|:--|
|`contacts`, `contact(id)`|List contact and get contact details|
|`organizations`|list organizations|
|`policies`|list policies|
|`jobs`|list active jobs|
|`activities`|list activities|
|`alerts`|List active alerts (triggered conditions)|
|`automation_scripts`|List available automation scripts|
|`device_custom_fields`|List device custom fields|
|`devices`|List devices|
|`devices_detailed`|List devices(deatiled)|
|`notification_channels_enabled`|List enabled notification channels|
|`notification_channels`|List all notification channels|
|`notification_channels_detailed`|List all notification channels detailed|
|`groups`|List all groups (saved searches)|
|`locations`|List all locations|
|`roles`|List device roles|
|`tasks`|List scheduled tasks|
|`software_products`|List supported 3rd party software|
|`users`|List users|
|`search_devices(query_string)`|Find devices|
|`user_end_users`|End user list|
|`user_technicians`|Technicians list|
|`user_roles`|Get user roles|

### Organizations

All apis related to organizations

```ruby
org = client.organizations.first
org_devices = client.organization_devices(org.id)

```

|Resource|API endpoint|
|:--|:--|
|`organizations`,`organization(id)`|List organizations or get one by id|
|`organization_locations(id)`|Organization locations|
|`organization_end_users(id)`|List users|
|`organization_custom_fields(id)`|Organization custom fields|
|`organization_devices(id)`|Organization devices|
|`organization_locations_backup_usage(id)`|Organization location backup usage|
|`organization_backup_usage_by_location(id, location_id)`|Organization locations backup usage|

### Backup

All apis related to backup

```ruby
# get failed jobs using status filter
failed_jobs = client.backup_jobs(sf:'status = FAILED')
```

|Resource|API endpoint|
|:--|:--|
|`backup_jobs(params)`|Returns list of backup jobs. Params is a hash for filtering the result|
|`backup_integrity_check_jobs(params)`|Returns a list of integrity check jobs|

### Devices

All apis related to devices.

| Resource | API endpoint |
|:--|:--|
| `device(id, params = {})` | Retrieves the details of a single device by its device ID. |
| `device_jobs(id, params = {})` | Retrieves all jobs associated with the specified device. |
| `device_activities(id, params = {})` | Retrieves activities for the specified device (e.g. filtered using `since`). |
| `device_alerts(id, params = {})` | Retrieves alerts related to the specified device. |
| `device_disks(id, params = {})` | Retrieves disk information for the specified device. |
| `device_processors(id, params = {})` | Retrieves processor information for the specified device. |
| `device_software(id, params = {})` | Retrieves installed software for the specified device. |
| `device_volumes(id, params = {})` | Retrieves volume information for the specified device. |
| `device_windows_services(id, params = {})` | Retrieves Windows services for the specified device. |
| `device_custom_fields(id, params = {})` | Retrieves custom fields associated with the specified device. |
| `device_os_patch_installs(id, params = {})` | Retrieves operating system patch installation records for the specified device. |
| `device_software_patch_installs(id, params = {})` | Retrieves software patch installation records for the specified device. |
| `device_last_logged_on_user(id, params = {})` | Retrieves information about the last logged-on user of the device. |
| `device_network_interfaces(id, params = {})` | Retrieves network interface information for the specified device. |
| `device_os_patches(id, params = {})` | Retrieves available or installed operating system patches for the device. |
| `device_software_patches(id, params = {})` | Retrieves available or installed software patches for the device. |
| `device_policy_overrides(id, params = {})` | Retrieves policy overrides applied to the specified device. |


## Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/jancotanis/ninjaone).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
