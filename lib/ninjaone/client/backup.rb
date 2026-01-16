# frozen_string_literal: true

module NinjaOne
  class Client
    # Contains Backup-related API calls for Ninja One.
    #
    # @see https://app.ninjarmm.com/apidocs/?links.active=core#/Backup Ninja One Developer Documentation - Backup section
    module Backup

      # Backup endpoints (GET)
      Client::define_endpoint('backup/jobs')
      Client::define_endpoint('backup/integrity-check-jobs')
    end
  end
end
