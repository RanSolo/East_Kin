##
# This code was generated by
# \ / _    _  _|   _  _
#  | (_)\/(_)(_|\/| |(/_  v1.0.0
#       /       /
#
# frozen_string_literal: true

module Twilio
  module REST
    class Messaging < Domain
      class V1 < Version
        ##
        # PLEASE NOTE that this class contains beta products that are subject to change. Use them with caution.
        class DomainConfigList < ListResource
          ##
          # Initialize the DomainConfigList
          # @param [Version] version Version that contains the resource
          # @return [DomainConfigList] DomainConfigList
          def initialize(version)
            super(version)

            # Path Solution
            @solution = {}
          end

          ##
          # Provide a user friendly representation
          def to_s
            '#<Twilio.Messaging.V1.DomainConfigList>'
          end
        end

        ##
        # PLEASE NOTE that this class contains beta products that are subject to change. Use them with caution.
        class DomainConfigPage < Page
          ##
          # Initialize the DomainConfigPage
          # @param [Version] version Version that contains the resource
          # @param [Response] response Response from the API
          # @param [Hash] solution Path solution for the resource
          # @return [DomainConfigPage] DomainConfigPage
          def initialize(version, response, solution)
            super(version, response)

            # Path Solution
            @solution = solution
          end

          ##
          # Build an instance of DomainConfigInstance
          # @param [Hash] payload Payload response from the API
          # @return [DomainConfigInstance] DomainConfigInstance
          def get_instance(payload)
            DomainConfigInstance.new(@version, payload, )
          end

          ##
          # Provide a user friendly representation
          def to_s
            '<Twilio.Messaging.V1.DomainConfigPage>'
          end
        end

        ##
        # PLEASE NOTE that this class contains beta products that are subject to change. Use them with caution.
        class DomainConfigContext < InstanceContext
          ##
          # Initialize the DomainConfigContext
          # @param [Version] version Version that contains the resource
          # @param [String] domain_sid Unique string used to identify the domain that this
          #   config should be associated with.
          # @return [DomainConfigContext] DomainConfigContext
          def initialize(version, domain_sid)
            super(version)

            # Path Solution
            @solution = {domain_sid: domain_sid, }
            @uri = "/LinkShortening/Domains/#{@solution[:domain_sid]}/Config"
          end

          ##
          # Update the DomainConfigInstance
          # @param [Array[String]] messaging_service_sids A list of messagingServiceSids
          #   (with prefix MG)
          # @param [String] fallback_url Any requests we receive to this domain that do not
          #   match an existing shortened message will be redirected to the fallback url.
          #   These will likely be either expired messages, random misdirected traffic, or
          #   intentional scraping.
          # @param [String] callback_url URL to receive click events to your webhook
          #   whenever the recipients click on the shortened links
          # @param [String] messaging_service_sids_action An action type for
          #   messaging_service_sids operation (ADD, DELETE, REPLACE)
          # @return [DomainConfigInstance] Updated DomainConfigInstance
          def update(messaging_service_sids: nil, fallback_url: :unset, callback_url: :unset, messaging_service_sids_action: :unset)
            data = Twilio::Values.of({
                'MessagingServiceSids' => Twilio.serialize_list(messaging_service_sids) { |e| e },
                'FallbackUrl' => fallback_url,
                'CallbackUrl' => callback_url,
                'MessagingServiceSidsAction' => messaging_service_sids_action,
            })

            payload = @version.update('POST', @uri, data: data)

            DomainConfigInstance.new(@version, payload, domain_sid: @solution[:domain_sid], )
          end

          ##
          # Fetch the DomainConfigInstance
          # @return [DomainConfigInstance] Fetched DomainConfigInstance
          def fetch
            payload = @version.fetch('GET', @uri)

            DomainConfigInstance.new(@version, payload, domain_sid: @solution[:domain_sid], )
          end

          ##
          # Provide a user friendly representation
          def to_s
            context = @solution.map {|k, v| "#{k}: #{v}"}.join(',')
            "#<Twilio.Messaging.V1.DomainConfigContext #{context}>"
          end

          ##
          # Provide a detailed, user friendly representation
          def inspect
            context = @solution.map {|k, v| "#{k}: #{v}"}.join(',')
            "#<Twilio.Messaging.V1.DomainConfigContext #{context}>"
          end
        end

        ##
        # PLEASE NOTE that this class contains beta products that are subject to change. Use them with caution.
        class DomainConfigInstance < InstanceResource
          ##
          # Initialize the DomainConfigInstance
          # @param [Version] version Version that contains the resource
          # @param [Hash] payload payload that contains response from Twilio
          # @param [String] domain_sid Unique string used to identify the domain that this
          #   config should be associated with.
          # @return [DomainConfigInstance] DomainConfigInstance
          def initialize(version, payload, domain_sid: nil)
            super(version)

            # Marshaled Properties
            @properties = {
                'domain_sid' => payload['domain_sid'],
                'config_sid' => payload['config_sid'],
                'messaging_service_sids' => payload['messaging_service_sids'],
                'fallback_url' => payload['fallback_url'],
                'callback_url' => payload['callback_url'],
                'date_created' => Twilio.deserialize_iso8601_datetime(payload['date_created']),
                'date_updated' => Twilio.deserialize_iso8601_datetime(payload['date_updated']),
                'url' => payload['url'],
            }

            # Context
            @instance_context = nil
            @params = {'domain_sid' => domain_sid || @properties['domain_sid'], }
          end

          ##
          # Generate an instance context for the instance, the context is capable of
          # performing various actions.  All instance actions are proxied to the context
          # @return [DomainConfigContext] DomainConfigContext for this DomainConfigInstance
          def context
            unless @instance_context
              @instance_context = DomainConfigContext.new(@version, @params['domain_sid'], )
            end
            @instance_context
          end

          ##
          # @return [String] The unique string that we created to identify the Domain resource.
          def domain_sid
            @properties['domain_sid']
          end

          ##
          # @return [String] The unique string that we created to identify the Domain config (prefix ZK).
          def config_sid
            @properties['config_sid']
          end

          ##
          # @return [Array[String]] A list of messagingServiceSids (with prefix MG).
          def messaging_service_sids
            @properties['messaging_service_sids']
          end

          ##
          # @return [String] We will redirect requests to urls we are unable to identify to this url.
          def fallback_url
            @properties['fallback_url']
          end

          ##
          # @return [String] URL to receive click events to your webhook whenever the recipients click on the shortened links.
          def callback_url
            @properties['callback_url']
          end

          ##
          # @return [Time] Date this Domain Config was created.
          def date_created
            @properties['date_created']
          end

          ##
          # @return [Time] Date that this Domain Config was last updated.
          def date_updated
            @properties['date_updated']
          end

          ##
          # @return [String] The url
          def url
            @properties['url']
          end

          ##
          # Update the DomainConfigInstance
          # @param [Array[String]] messaging_service_sids A list of messagingServiceSids
          #   (with prefix MG)
          # @param [String] fallback_url Any requests we receive to this domain that do not
          #   match an existing shortened message will be redirected to the fallback url.
          #   These will likely be either expired messages, random misdirected traffic, or
          #   intentional scraping.
          # @param [String] callback_url URL to receive click events to your webhook
          #   whenever the recipients click on the shortened links
          # @param [String] messaging_service_sids_action An action type for
          #   messaging_service_sids operation (ADD, DELETE, REPLACE)
          # @return [DomainConfigInstance] Updated DomainConfigInstance
          def update(messaging_service_sids: nil, fallback_url: :unset, callback_url: :unset, messaging_service_sids_action: :unset)
            context.update(
                messaging_service_sids: messaging_service_sids,
                fallback_url: fallback_url,
                callback_url: callback_url,
                messaging_service_sids_action: messaging_service_sids_action,
            )
          end

          ##
          # Fetch the DomainConfigInstance
          # @return [DomainConfigInstance] Fetched DomainConfigInstance
          def fetch
            context.fetch
          end

          ##
          # Provide a user friendly representation
          def to_s
            values = @params.map{|k, v| "#{k}: #{v}"}.join(" ")
            "<Twilio.Messaging.V1.DomainConfigInstance #{values}>"
          end

          ##
          # Provide a detailed, user friendly representation
          def inspect
            values = @properties.map{|k, v| "#{k}: #{v}"}.join(" ")
            "<Twilio.Messaging.V1.DomainConfigInstance #{values}>"
          end
        end
      end
    end
  end
end