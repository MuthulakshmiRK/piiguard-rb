require "rails/railtie"
require "piiguard/masked_logger"

module Piiguard
  class Railtie < Rails::Railtie
    initializer "piiguard.filter_parameters" do |app|
      app.config.filter_parameters += Piiguard.filters
    end

    initializer "piiguard.mask_logs" do
      Rails.application.config.after_initialize do
        Rails.logger = Piiguard::MaskedLogger.new(Rails.logger)
      end
    end
  end
end