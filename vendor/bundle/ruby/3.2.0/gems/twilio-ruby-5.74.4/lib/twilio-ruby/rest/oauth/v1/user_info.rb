##
# This code was generated by
# \ / _    _  _|   _  _
#  | (_)\/(_)(_|\/| |(/_  v1.0.0
#       /       /
#
# frozen_string_literal: true

module Twilio
  module REST
    class Oauth < Domain
      class V1 < Version
        class UserInfoList < ListResource
          ##
          # Initialize the UserInfoList
          # @param [Version] version Version that contains the resource
          # @return [UserInfoList] UserInfoList
          def initialize(version)
            super(version)

            # Path Solution
            @solution = {}
          end

          ##
          # Provide a user friendly representation
          def to_s
            '#<Twilio.Oauth.V1.UserInfoList>'
          end
        end

        class UserInfoPage < Page
          ##
          # Initialize the UserInfoPage
          # @param [Version] version Version that contains the resource
          # @param [Response] response Response from the API
          # @param [Hash] solution Path solution for the resource
          # @return [UserInfoPage] UserInfoPage
          def initialize(version, response, solution)
            super(version, response)

            # Path Solution
            @solution = solution
          end

          ##
          # Build an instance of UserInfoInstance
          # @param [Hash] payload Payload response from the API
          # @return [UserInfoInstance] UserInfoInstance
          def get_instance(payload)
            UserInfoInstance.new(@version, payload, )
          end

          ##
          # Provide a user friendly representation
          def to_s
            '<Twilio.Oauth.V1.UserInfoPage>'
          end
        end

        class UserInfoContext < InstanceContext
          ##
          # Initialize the UserInfoContext
          # @param [Version] version Version that contains the resource
          # @return [UserInfoContext] UserInfoContext
          def initialize(version)
            super(version)

            # Path Solution
            @solution = {}
            @uri = "/userinfo"
          end

          ##
          # Fetch the UserInfoInstance
          # @return [UserInfoInstance] Fetched UserInfoInstance
          def fetch
            payload = @version.fetch('GET', @uri)

            UserInfoInstance.new(@version, payload, )
          end

          ##
          # Provide a user friendly representation
          def to_s
            context = @solution.map {|k, v| "#{k}: #{v}"}.join(',')
            "#<Twilio.Oauth.V1.UserInfoContext #{context}>"
          end

          ##
          # Provide a detailed, user friendly representation
          def inspect
            context = @solution.map {|k, v| "#{k}: #{v}"}.join(',')
            "#<Twilio.Oauth.V1.UserInfoContext #{context}>"
          end
        end

        class UserInfoInstance < InstanceResource
          ##
          # Initialize the UserInfoInstance
          # @param [Version] version Version that contains the resource
          # @param [Hash] payload payload that contains response from Twilio
          # @return [UserInfoInstance] UserInfoInstance
          def initialize(version, payload)
            super(version)

            # Marshaled Properties
            @properties = {
                'user_sid' => payload['user_sid'],
                'first_name' => payload['first_name'],
                'last_name' => payload['last_name'],
                'friendly_name' => payload['friendly_name'],
                'email' => payload['email'],
                'url' => payload['url'],
            }

            # Context
            @instance_context = nil
            @params = {}
          end

          ##
          # Generate an instance context for the instance, the context is capable of
          # performing various actions.  All instance actions are proxied to the context
          # @return [UserInfoContext] UserInfoContext for this UserInfoInstance
          def context
            unless @instance_context
              @instance_context = UserInfoContext.new(@version, )
            end
            @instance_context
          end

          ##
          # @return [String] The user sid
          def user_sid
            @properties['user_sid']
          end

          ##
          # @return [String] The first name of the end-user
          def first_name
            @properties['first_name']
          end

          ##
          # @return [String] The last name of the end-user
          def last_name
            @properties['last_name']
          end

          ##
          # @return [String] The friendly name of the end-user
          def friendly_name
            @properties['friendly_name']
          end

          ##
          # @return [String] The end-user's preferred email address
          def email
            @properties['email']
          end

          ##
          # @return [String] The url
          def url
            @properties['url']
          end

          ##
          # Fetch the UserInfoInstance
          # @return [UserInfoInstance] Fetched UserInfoInstance
          def fetch
            context.fetch
          end

          ##
          # Provide a user friendly representation
          def to_s
            values = @params.map{|k, v| "#{k}: #{v}"}.join(" ")
            "<Twilio.Oauth.V1.UserInfoInstance #{values}>"
          end

          ##
          # Provide a detailed, user friendly representation
          def inspect
            values = @properties.map{|k, v| "#{k}: #{v}"}.join(" ")
            "<Twilio.Oauth.V1.UserInfoInstance #{values}>"
          end
        end
      end
    end
  end
end