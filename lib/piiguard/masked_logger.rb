module Piiguard
  class MaskedLogger
    def initialize(logger)
      @logger = logger
    end

    def debug(message = nil, &block)
      log(:debug, message, &block)
    end

    def info(message = nil, &block)
      log(:info, message, &block)
    end

    def warn(message = nil, &block)
      log(:warn, message, &block)
    end

    def error(message = nil, &block)
      log(:error, message, &block)
    end

    def fatal(message = nil, &block)
      log(:fatal, message, &block)
    end

    def unknown(message = nil, &block)
      log(:unknown, message, &block)
    end

    def method_missing(method, *args, &block)
      @logger.send(method, *args, &block)
    end

    def respond_to_missing?(method, include_private = false)
      @logger.respond_to?(method, include_private) || super
    end

    private

    def log(level, message = nil)
      msg = message || (block_given? ? yield : nil)
      return unless msg

      masked_msg = Piiguard.mask(msg.to_s)

      @logger.public_send(level, masked_msg)
    end
  end
end