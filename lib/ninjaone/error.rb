# frozen_string_literal: true

module NinjaOne
  # Base error class for all exceptions raised by the NinjaOne API.
  # This allows rescuing all NinjaOne-related errors in a single block if desired.
  # Example:
  #   begin
  #     # Code that interacts with the NinjaOne API
  #   rescue NinjaOne::NinjaOneError => e
  #     puts "An error occurred: #{e.message}"
  #   end
  class NinjaOneError < StandardError; end

  # Raised when the NinjaOne API configuration is incomplete or incorrect.
  # This might occur if required configuration options such as `client_id`, `client_secret`,
  # or `endpoint` are missing or improperly set.
  #
  # Example:
  #   raise NinjaOne::ConfigurationError, "Endpoint, Client ID and Secret must be configured"
  class ConfigurationError < NinjaOneError; end

  # Raised when authentication to the NinjaOne API fails.
  # This might be due to incorrect credentials, an expired token, or insufficient permissions.
  #
  # Example:
  #   raise NinjaOne::AuthenticationError, "Invalid client credentials"
  #
  # @see https://developers.skykick.com/Guides/Authentication
  class AuthenticationError < NinjaOneError; end
end
