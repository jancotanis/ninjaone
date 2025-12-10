# frozen_string_literal: true

require 'wrapi'
require File.expand_path('ninjaone/api', __dir__)
require File.expand_path('ninjaone/client', __dir__)
require File.expand_path('ninjaone/version', __dir__)

# The `NinjaOne` module is a wrapper around NinjaOne's API.
# It provides a client configuration, including default settings like endpoint URL and user agent.
# This module extends `WrAPI::Configuration` to provide configuration
# options and `WrAPI::RespondTo` for dynamic response handling.
module NinjaOne
  extend WrAPI::Configuration
  extend WrAPI::RespondTo

  # Default User-Agent header sent with API requests, including gem version information.
  DEFAULT_UA = "NinjaOne Ruby API wrapper #{NinjaOne::VERSION}"

  # Creates and returns a new NinjaOne API client with the given options.
  #
  # @param options [Hash] A hash of configuration options to initialize the client.
  #   This method merges the provided options with default values such as endpoint, user agent, and pagination class.
  #
  # @option options [String] :endpoint The base URL for the NinjaOne API (default: `DEFAULT_ENDPOINT`).
  # @option options [String] :user_agent The User-Agent header to send with each API request (default: `DEFAULT_UA`).
  #
  # @return [NinjaOne::Client] A new instance of the NinjaOne API client.
  #
  # @example Create a NinjaOne client:
  #   client = NinjaOne.client(endpoint: "https://api.custom-endpoint.com", user_agent: "Custom UA/1.0")
  def self.client(options = {})
    NinjaOne::Client.new({
      user_agent: DEFAULT_UA
    }.merge(options))
  end

  # Resets the NinjaOne configuration to default values.
  #
  # This method resets the configuration values to their defaults:
  # - `DEFAULT_ENDPOINT` for the API endpoint
  # - `DEFAULT_UA` for the User-Agent
  # - `DEFAULT_PAGINATION` for the pagination handling class
  #
  # @example Reset the NinjaOne configuration:
  #   NinjaOne.reset
  def self.reset
    super
    self.user_agent = DEFAULT_UA
  end
end
