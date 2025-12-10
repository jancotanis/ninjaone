# frozen_string_literal: true

require 'logger'
require 'test_helper'

AUTH_LOGGER = 'auth_test.log'
File.delete(AUTH_LOGGER) if File.exist?(AUTH_LOGGER)

describe 'auth' do
  before do
    NinjaOne.reset
  end
  it '#1 not logged in' do
    c = NinjaOne.client({ logger: Logger.new(AUTH_LOGGER) })
    assert_raises NinjaOne::ConfigurationError do
      c.login
    end
  end
  it '#2 logged in' do
    NinjaOne.configure do |config|
      config.client_id     = ENV['NINJA1_CLIENT_ID']
      config.client_secret = ENV['NINJA1_CLIENT_SECRET']
      config.endpoint      = ENV['NINJA1_ENDPOINT']
    end
    c = NinjaOne.client({ logger: Logger.new(AUTH_LOGGER) })
    refute_empty c.login, '.login'
  end
  it '#3 no endpoint' do
    NinjaOne.configure do |config|
      config.username = 'john'
      config.password = 'doe'
    end
    c = NinjaOne.client({ logger: Logger.new(AUTH_LOGGER) })
    assert_raises NinjaOne::ConfigurationError do
      c.login
    end
  end
  it '#4 wrong client id' do
    NinjaOne.configure do |config|
      config.client_id     = 'john'
      config.client_secret = 'doe'
      config.endpoint      = ENV['NINJA1_ENDPOINT']
    end
    c = NinjaOne.client({ logger: Logger.new(AUTH_LOGGER) })
    assert_raises NinjaOne::AuthenticationError do
      c.login
    end
  end
  it '#5 wrong secret' do
    NinjaOne.configure do |config|
      config.client_id     = ENV['NINJA1_CLIENT_ID']
      config.client_secret = 'doe'
      config.endpoint      = ENV['NINJA1_ENDPOINT']
    end
    c = NinjaOne.client({ logger: Logger.new(AUTH_LOGGER) })
    assert_raises NinjaOne::AuthenticationError do
      c.login
    end
  end
end
