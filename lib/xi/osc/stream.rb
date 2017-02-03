require 'thread'
require 'osc-ruby'

module Xi::OSC
  module Stream
    def initialize(clock, server: 'localhost', port:, **opts)
      super(clock, **opts)
      @osc = OSC::Client.new(server, port)
    end

    private

    def send_msg(address, *args)
      msg = message(address, *args)
      logger.debug([__method__, msg.address] + msg.to_a)
      send_osc_msg(msg)
    end

    def send_bundle(address, *args, at: Time.now)
      msg = message(address, *args)
      bundle = OSC::Bundle.new(at, msg)
      logger.debug([__method__, msg.address, at.to_i, at.usec] + msg.to_a)
      send_osc_msg(bundle)
    end

    def message(address, *args)
      OSC::Message.new(address, *args)
    end

    def send_osc_msg(msg)
      @osc.send(msg)
    rescue StandardError => err
      logger.error(err)
    end
  end
end
