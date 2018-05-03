# frozen_string_literal: true

module ServiceLayer
  # Implements Openstack Neutron API
  class NetworkingService < Core::ServiceLayer::Service
    include NetworkingServices::Network
    include NetworkingServices::Subnet
    include NetworkingServices::Port
    include NetworkingServices::FloatingIp
    include NetworkingServices::SecurityGroup
    include NetworkingServices::SecurityGroupRule
    include NetworkingServices::Router
    include NetworkingServices::Rbac
    include NetworkingServices::Quota
    include NetworkingServices::DhcpAgent
    include NetworkingServices::Asr

    def available?(_action_name_sym = nil)
      elektron.service?('network')
    end

    def elektron_networking
      @elektron_networking ||= elektron.service(
        'network', path_prefix: '/v2.0'
      )
    end

    def available_extensions
      elektron_networking.get('extensions').body['extensions']
    end

    def extension?(alias_name)
      !available_extensions.find { |extension| extension['alias'] == alias_name}.nil?
    end

    def asr_extension?
      extension?('asr1k_devices')
    end
  end
end
