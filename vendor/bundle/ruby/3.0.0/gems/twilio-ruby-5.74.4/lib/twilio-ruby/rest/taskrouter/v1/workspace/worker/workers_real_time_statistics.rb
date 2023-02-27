##
# This code was generated by
# \ / _    _  _|   _  _
#  | (_)\/(_)(_|\/| |(/_  v1.0.0
#       /       /
#
# frozen_string_literal: true

module Twilio
  module REST
    class Taskrouter < Domain
      class V1 < Version
        class WorkspaceContext < InstanceContext
          class WorkerContext < InstanceContext
            class WorkersRealTimeStatisticsList < ListResource
              ##
              # Initialize the WorkersRealTimeStatisticsList
              # @param [Version] version Version that contains the resource
              # @param [String] workspace_sid The SID of the Workspace that contains the
              #   Workers.
              # @return [WorkersRealTimeStatisticsList] WorkersRealTimeStatisticsList
              def initialize(version, workspace_sid: nil)
                super(version)

                # Path Solution
                @solution = {workspace_sid: workspace_sid}
              end

              ##
              # Provide a user friendly representation
              def to_s
                '#<Twilio.Taskrouter.V1.WorkersRealTimeStatisticsList>'
              end
            end

            class WorkersRealTimeStatisticsPage < Page
              ##
              # Initialize the WorkersRealTimeStatisticsPage
              # @param [Version] version Version that contains the resource
              # @param [Response] response Response from the API
              # @param [Hash] solution Path solution for the resource
              # @return [WorkersRealTimeStatisticsPage] WorkersRealTimeStatisticsPage
              def initialize(version, response, solution)
                super(version, response)

                # Path Solution
                @solution = solution
              end

              ##
              # Build an instance of WorkersRealTimeStatisticsInstance
              # @param [Hash] payload Payload response from the API
              # @return [WorkersRealTimeStatisticsInstance] WorkersRealTimeStatisticsInstance
              def get_instance(payload)
                WorkersRealTimeStatisticsInstance.new(@version, payload, workspace_sid: @solution[:workspace_sid], )
              end

              ##
              # Provide a user friendly representation
              def to_s
                '<Twilio.Taskrouter.V1.WorkersRealTimeStatisticsPage>'
              end
            end

            class WorkersRealTimeStatisticsContext < InstanceContext
              ##
              # Initialize the WorkersRealTimeStatisticsContext
              # @param [Version] version Version that contains the resource
              # @param [String] workspace_sid The SID of the Workspace with the resource to
              #   fetch.
              # @return [WorkersRealTimeStatisticsContext] WorkersRealTimeStatisticsContext
              def initialize(version, workspace_sid)
                super(version)

                # Path Solution
                @solution = {workspace_sid: workspace_sid, }
                @uri = "/Workspaces/#{@solution[:workspace_sid]}/Workers/RealTimeStatistics"
              end

              ##
              # Fetch the WorkersRealTimeStatisticsInstance
              # @param [String] task_channel Only calculate real-time statistics on this
              #   TaskChannel. Can be the TaskChannel's SID or its `unique_name`, such as `voice`,
              #   `sms`, or `default`.
              # @return [WorkersRealTimeStatisticsInstance] Fetched WorkersRealTimeStatisticsInstance
              def fetch(task_channel: :unset)
                params = Twilio::Values.of({'TaskChannel' => task_channel, })

                payload = @version.fetch('GET', @uri, params: params)

                WorkersRealTimeStatisticsInstance.new(@version, payload, workspace_sid: @solution[:workspace_sid], )
              end

              ##
              # Provide a user friendly representation
              def to_s
                context = @solution.map {|k, v| "#{k}: #{v}"}.join(',')
                "#<Twilio.Taskrouter.V1.WorkersRealTimeStatisticsContext #{context}>"
              end

              ##
              # Provide a detailed, user friendly representation
              def inspect
                context = @solution.map {|k, v| "#{k}: #{v}"}.join(',')
                "#<Twilio.Taskrouter.V1.WorkersRealTimeStatisticsContext #{context}>"
              end
            end

            class WorkersRealTimeStatisticsInstance < InstanceResource
              ##
              # Initialize the WorkersRealTimeStatisticsInstance
              # @param [Version] version Version that contains the resource
              # @param [Hash] payload payload that contains response from Twilio
              # @param [String] workspace_sid The SID of the Workspace that contains the
              #   Workers.
              # @return [WorkersRealTimeStatisticsInstance] WorkersRealTimeStatisticsInstance
              def initialize(version, payload, workspace_sid: nil)
                super(version)

                # Marshaled Properties
                @properties = {
                    'account_sid' => payload['account_sid'],
                    'activity_statistics' => payload['activity_statistics'],
                    'total_workers' => payload['total_workers'] == nil ? payload['total_workers'] : payload['total_workers'].to_i,
                    'workspace_sid' => payload['workspace_sid'],
                    'url' => payload['url'],
                }

                # Context
                @instance_context = nil
                @params = {'workspace_sid' => workspace_sid, }
              end

              ##
              # Generate an instance context for the instance, the context is capable of
              # performing various actions.  All instance actions are proxied to the context
              # @return [WorkersRealTimeStatisticsContext] WorkersRealTimeStatisticsContext for this WorkersRealTimeStatisticsInstance
              def context
                unless @instance_context
                  @instance_context = WorkersRealTimeStatisticsContext.new(@version, @params['workspace_sid'], )
                end
                @instance_context
              end

              ##
              # @return [String] The SID of the Account that created the resource
              def account_sid
                @properties['account_sid']
              end

              ##
              # @return [Array[Hash]] The number of current Workers by Activity
              def activity_statistics
                @properties['activity_statistics']
              end

              ##
              # @return [String] The total number of Workers
              def total_workers
                @properties['total_workers']
              end

              ##
              # @return [String] The SID of the Workspace that contains the Workers
              def workspace_sid
                @properties['workspace_sid']
              end

              ##
              # @return [String] The absolute URL of the Workers statistics resource
              def url
                @properties['url']
              end

              ##
              # Fetch the WorkersRealTimeStatisticsInstance
              # @param [String] task_channel Only calculate real-time statistics on this
              #   TaskChannel. Can be the TaskChannel's SID or its `unique_name`, such as `voice`,
              #   `sms`, or `default`.
              # @return [WorkersRealTimeStatisticsInstance] Fetched WorkersRealTimeStatisticsInstance
              def fetch(task_channel: :unset)
                context.fetch(task_channel: task_channel, )
              end

              ##
              # Provide a user friendly representation
              def to_s
                values = @params.map{|k, v| "#{k}: #{v}"}.join(" ")
                "<Twilio.Taskrouter.V1.WorkersRealTimeStatisticsInstance #{values}>"
              end

              ##
              # Provide a detailed, user friendly representation
              def inspect
                values = @properties.map{|k, v| "#{k}: #{v}"}.join(" ")
                "<Twilio.Taskrouter.V1.WorkersRealTimeStatisticsInstance #{values}>"
              end
            end
          end
        end
      end
    end
  end
end