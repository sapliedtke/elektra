# frozen_string_literal: true

module ServiceLayer
  module NetworkingServices
    # Implements Openstack Port
    module Asr
      def asr_validate(router_id)
        elektron_networking.get("devices/#{router_id}/validate").body
      end

      def asr_sync(router_id)
        elektron_networking.put("devices/#{router_id}/sync").body
      end

      def asr_delete(router_id)
        elektron_networking.delete("devices/#{router_id}/teardown").body
      end

      def asr_interface_statistics(router_id)
        elektron_networking.get("devices/#{router_id}/interface_statistics").body
      end
    end
  end
end
