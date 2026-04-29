# frozen_string_literal: true
require "piiguard/railtie" if defined?(Rails)
require_relative "piiguard/version"
require "ostruct"
require "piiguard/masked_logger"

module Piiguard
  
  EMAIL_REGEX = /\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b/i
  PHONE_REGEX = /\b\d{10}\b/

  class << self
    attr_accessor :custom_filters, :enabled, :config
    def config
      @config ||= OpenStruct.new(
        mask_email: true,
        mask_phone: true
      )
    end
  end

  def self.configure
    self.config ||= OpenStruct.new(
      mask_email: true,
      mask_phone: true
    )
    yield(config)
  end

  self.enabled = true

  def self.default_filters
    [
      :email,
      :phone,
      :mobile,
      :password,
      :token,
      :api_key
    ]
  end

  def self.filters
    (default_filters + (custom_filters || [])).uniq
  end

  def self.mask(data)
    case data
    when String
      mask_string(data)
    when Hash
      data.each_with_object({}) do |(k,v), result|
        result[k] = mask(v)
      end
    when Array
      data.map { |v| mask(v) }
    else
      data
    end
  end

  def self.mask_string(text)
    result = text

    if config&.mask_email
      result = result.gsub(EMAIL_REGEX, "[EMAIL]")
    end

    if config&.mask_phone
      result = result.gsub(PHONE_REGEX, "[PHONE]")
    end

    result
  end
end
