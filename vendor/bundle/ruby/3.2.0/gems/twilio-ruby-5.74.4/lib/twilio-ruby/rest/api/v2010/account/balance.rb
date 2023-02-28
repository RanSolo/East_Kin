##
# This code was generated by
# \ / _    _  _|   _  _
#  | (_)\/(_)(_|\/| |(/_  v1.0.0
#       /       /
#
# frozen_string_literal: true

module Twilio
  module REST
    class Api < Domain
      class V2010 < Version
        class AccountContext < InstanceContext
          class BalanceList < ListResource
            ##
            # Initialize the BalanceList
            # @param [Version] version Version that contains the resource
            # @param [String] account_sid The unique SID identifier of the Account.
            # @return [BalanceList] BalanceList
            def initialize(version, account_sid: nil)
              super(version)

              # Path Solution
              @solution = {account_sid: account_sid}
              @uri = "/Accounts/#{@solution[:account_sid]}/Balance.json"
            end

            ##
            # Fetch the BalanceInstance
            # @return [BalanceInstance] Fetched BalanceInstance
            def fetch
              payload = @version.fetch('GET', @uri)

              BalanceInstance.new(@version, payload, account_sid: @solution[:account_sid], )
            end

            ##
            # Provide a user friendly representation
            def to_s
              '#<Twilio.Api.V2010.BalanceList>'
            end
          end

          class BalancePage < Page
            ##
            # Initialize the BalancePage
            # @param [Version] version Version that contains the resource
            # @param [Response] response Response from the API
            # @param [Hash] solution Path solution for the resource
            # @return [BalancePage] BalancePage
            def initialize(version, response, solution)
              super(version, response)

              # Path Solution
              @solution = solution
            end

            ##
            # Build an instance of BalanceInstance
            # @param [Hash] payload Payload response from the API
            # @return [BalanceInstance] BalanceInstance
            def get_instance(payload)
              BalanceInstance.new(@version, payload, account_sid: @solution[:account_sid], )
            end

            ##
            # Provide a user friendly representation
            def to_s
              '<Twilio.Api.V2010.BalancePage>'
            end
          end

          class BalanceInstance < InstanceResource
            ##
            # Initialize the BalanceInstance
            # @param [Version] version Version that contains the resource
            # @param [Hash] payload payload that contains response from Twilio
            # @param [String] account_sid The unique SID identifier of the Account.
            # @return [BalanceInstance] BalanceInstance
            def initialize(version, payload, account_sid: nil)
              super(version)

              # Marshaled Properties
              @properties = {
                  'account_sid' => payload['account_sid'],
                  'balance' => payload['balance'],
                  'currency' => payload['currency'],
              }
            end

            ##
            # @return [String] Account Sid.
            def account_sid
              @properties['account_sid']
            end

            ##
            # @return [String] Account balance
            def balance
              @properties['balance']
            end

            ##
            # @return [String] Currency units
            def currency
              @properties['currency']
            end

            ##
            # Provide a user friendly representation
            def to_s
              "<Twilio.Api.V2010.BalanceInstance>"
            end

            ##
            # Provide a detailed, user friendly representation
            def inspect
              "<Twilio.Api.V2010.BalanceInstance>"
            end
          end
        end
      end
    end
  end
end