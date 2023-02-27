##
# This code was generated by
# \ / _    _  _|   _  _
#  | (_)\/(_)(_|\/| |(/_  v1.0.0
#       /       /
#
# frozen_string_literal: true

module Twilio
  module REST
    class Autopilot < Domain
      class V1 < Version
        class AssistantContext < InstanceContext
          ##
          # PLEASE NOTE that this class contains preview products that are subject to change. Use them with caution. If you currently do not have developer preview access, please contact help@twilio.com.
          class QueryList < ListResource
            ##
            # Initialize the QueryList
            # @param [Version] version Version that contains the resource
            # @param [String] assistant_sid The SID of the
            #   {Assistant}[https://www.twilio.com/docs/autopilot/api/assistant] that is the
            #   parent of the resource.
            # @return [QueryList] QueryList
            def initialize(version, assistant_sid: nil)
              super(version)

              # Path Solution
              @solution = {assistant_sid: assistant_sid}
              @uri = "/Assistants/#{@solution[:assistant_sid]}/Queries"
            end

            ##
            # Lists QueryInstance records from the API as a list.
            # Unlike stream(), this operation is eager and will load `limit` records into
            # memory before returning.
            # @param [String] language The {ISO
            #   language-country}[https://docs.oracle.com/cd/E13214_01/wli/docs92/xref/xqisocodes.html]
            #   string that specifies the language used by the Query resources to read. For
            #   example: `en-US`.
            # @param [String] model_build The SID or unique name of the {Model
            #   Build}[https://www.twilio.com/docs/autopilot/api/model-build] to be queried.
            # @param [String] status The status of the resources to read. Can be:
            #   `pending-review`, `reviewed`, or `discarded`
            # @param [String] dialogue_sid The SID of the
            #   {Dialogue}[https://www.twilio.com/docs/autopilot/api/dialogue].
            # @param [Integer] limit Upper limit for the number of records to return. stream()
            #    guarantees to never return more than limit.  Default is no limit
            # @param [Integer] page_size Number of records to fetch per request, when
            #    not set will use the default value of 50 records.  If no page_size is defined
            #    but a limit is defined, stream() will attempt to read the limit with the most
            #    efficient page size, i.e. min(limit, 1000)
            # @return [Array] Array of up to limit results
            def list(language: :unset, model_build: :unset, status: :unset, dialogue_sid: :unset, limit: nil, page_size: nil)
              self.stream(
                  language: language,
                  model_build: model_build,
                  status: status,
                  dialogue_sid: dialogue_sid,
                  limit: limit,
                  page_size: page_size
              ).entries
            end

            ##
            # Streams QueryInstance records from the API as an Enumerable.
            # This operation lazily loads records as efficiently as possible until the limit
            # is reached.
            # @param [String] language The {ISO
            #   language-country}[https://docs.oracle.com/cd/E13214_01/wli/docs92/xref/xqisocodes.html]
            #   string that specifies the language used by the Query resources to read. For
            #   example: `en-US`.
            # @param [String] model_build The SID or unique name of the {Model
            #   Build}[https://www.twilio.com/docs/autopilot/api/model-build] to be queried.
            # @param [String] status The status of the resources to read. Can be:
            #   `pending-review`, `reviewed`, or `discarded`
            # @param [String] dialogue_sid The SID of the
            #   {Dialogue}[https://www.twilio.com/docs/autopilot/api/dialogue].
            # @param [Integer] limit Upper limit for the number of records to return. stream()
            #    guarantees to never return more than limit. Default is no limit.
            # @param [Integer] page_size Number of records to fetch per request, when
            #    not set will use the default value of 50 records. If no page_size is defined
            #    but a limit is defined, stream() will attempt to read the limit with the most
            #    efficient page size, i.e. min(limit, 1000)
            # @return [Enumerable] Enumerable that will yield up to limit results
            def stream(language: :unset, model_build: :unset, status: :unset, dialogue_sid: :unset, limit: nil, page_size: nil)
              limits = @version.read_limits(limit, page_size)

              page = self.page(
                  language: language,
                  model_build: model_build,
                  status: status,
                  dialogue_sid: dialogue_sid,
                  page_size: limits[:page_size],
              )

              @version.stream(page, limit: limits[:limit], page_limit: limits[:page_limit])
            end

            ##
            # When passed a block, yields QueryInstance records from the API.
            # This operation lazily loads records as efficiently as possible until the limit
            # is reached.
            def each
              limits = @version.read_limits

              page = self.page(page_size: limits[:page_size], )

              @version.stream(page,
                              limit: limits[:limit],
                              page_limit: limits[:page_limit]).each {|x| yield x}
            end

            ##
            # Retrieve a single page of QueryInstance records from the API.
            # Request is executed immediately.
            # @param [String] language The {ISO
            #   language-country}[https://docs.oracle.com/cd/E13214_01/wli/docs92/xref/xqisocodes.html]
            #   string that specifies the language used by the Query resources to read. For
            #   example: `en-US`.
            # @param [String] model_build The SID or unique name of the {Model
            #   Build}[https://www.twilio.com/docs/autopilot/api/model-build] to be queried.
            # @param [String] status The status of the resources to read. Can be:
            #   `pending-review`, `reviewed`, or `discarded`
            # @param [String] dialogue_sid The SID of the
            #   {Dialogue}[https://www.twilio.com/docs/autopilot/api/dialogue].
            # @param [String] page_token PageToken provided by the API
            # @param [Integer] page_number Page Number, this value is simply for client state
            # @param [Integer] page_size Number of records to return, defaults to 50
            # @return [Page] Page of QueryInstance
            def page(language: :unset, model_build: :unset, status: :unset, dialogue_sid: :unset, page_token: :unset, page_number: :unset, page_size: :unset)
              params = Twilio::Values.of({
                  'Language' => language,
                  'ModelBuild' => model_build,
                  'Status' => status,
                  'DialogueSid' => dialogue_sid,
                  'PageToken' => page_token,
                  'Page' => page_number,
                  'PageSize' => page_size,
              })

              response = @version.page('GET', @uri, params: params)

              QueryPage.new(@version, response, @solution)
            end

            ##
            # Retrieve a single page of QueryInstance records from the API.
            # Request is executed immediately.
            # @param [String] target_url API-generated URL for the requested results page
            # @return [Page] Page of QueryInstance
            def get_page(target_url)
              response = @version.domain.request(
                  'GET',
                  target_url
              )
              QueryPage.new(@version, response, @solution)
            end

            ##
            # Create the QueryInstance
            # @param [String] language The {ISO
            #   language-country}[https://docs.oracle.com/cd/E13214_01/wli/docs92/xref/xqisocodes.html]
            #   string that specifies the language used for the new query. For example: `en-US`.
            # @param [String] query The end-user's natural language input. It can be up to
            #   2048 characters long.
            # @param [String] tasks The list of tasks to limit the new query to. Tasks are
            #   expressed as a comma-separated list of task `unique_name` values. For example,
            #   `task-unique_name-1, task-unique_name-2`. Listing specific tasks is useful to
            #   constrain the paths that a user can take.
            # @param [String] model_build The SID or unique name of the {Model
            #   Build}[https://www.twilio.com/docs/autopilot/api/model-build] to be queried.
            # @return [QueryInstance] Created QueryInstance
            def create(language: nil, query: nil, tasks: :unset, model_build: :unset)
              data = Twilio::Values.of({
                  'Language' => language,
                  'Query' => query,
                  'Tasks' => tasks,
                  'ModelBuild' => model_build,
              })

              payload = @version.create('POST', @uri, data: data)

              QueryInstance.new(@version, payload, assistant_sid: @solution[:assistant_sid], )
            end

            ##
            # Provide a user friendly representation
            def to_s
              '#<Twilio.Autopilot.V1.QueryList>'
            end
          end

          ##
          # PLEASE NOTE that this class contains preview products that are subject to change. Use them with caution. If you currently do not have developer preview access, please contact help@twilio.com.
          class QueryPage < Page
            ##
            # Initialize the QueryPage
            # @param [Version] version Version that contains the resource
            # @param [Response] response Response from the API
            # @param [Hash] solution Path solution for the resource
            # @return [QueryPage] QueryPage
            def initialize(version, response, solution)
              super(version, response)

              # Path Solution
              @solution = solution
            end

            ##
            # Build an instance of QueryInstance
            # @param [Hash] payload Payload response from the API
            # @return [QueryInstance] QueryInstance
            def get_instance(payload)
              QueryInstance.new(@version, payload, assistant_sid: @solution[:assistant_sid], )
            end

            ##
            # Provide a user friendly representation
            def to_s
              '<Twilio.Autopilot.V1.QueryPage>'
            end
          end

          ##
          # PLEASE NOTE that this class contains preview products that are subject to change. Use them with caution. If you currently do not have developer preview access, please contact help@twilio.com.
          class QueryContext < InstanceContext
            ##
            # Initialize the QueryContext
            # @param [Version] version Version that contains the resource
            # @param [String] assistant_sid The SID of the
            #   {Assistant}[https://www.twilio.com/docs/autopilot/api/assistant] that is the
            #   parent of the resource to fetch.
            # @param [String] sid The Twilio-provided string that uniquely identifies the
            #   Query resource to fetch.
            # @return [QueryContext] QueryContext
            def initialize(version, assistant_sid, sid)
              super(version)

              # Path Solution
              @solution = {assistant_sid: assistant_sid, sid: sid, }
              @uri = "/Assistants/#{@solution[:assistant_sid]}/Queries/#{@solution[:sid]}"
            end

            ##
            # Fetch the QueryInstance
            # @return [QueryInstance] Fetched QueryInstance
            def fetch
              payload = @version.fetch('GET', @uri)

              QueryInstance.new(@version, payload, assistant_sid: @solution[:assistant_sid], sid: @solution[:sid], )
            end

            ##
            # Update the QueryInstance
            # @param [String] sample_sid The SID of an optional reference to the
            #   {Sample}[https://www.twilio.com/docs/autopilot/api/task-sample] created from the
            #   query.
            # @param [String] status The new status of the resource. Can be: `pending-review`,
            #   `reviewed`, or `discarded`
            # @return [QueryInstance] Updated QueryInstance
            def update(sample_sid: :unset, status: :unset)
              data = Twilio::Values.of({'SampleSid' => sample_sid, 'Status' => status, })

              payload = @version.update('POST', @uri, data: data)

              QueryInstance.new(@version, payload, assistant_sid: @solution[:assistant_sid], sid: @solution[:sid], )
            end

            ##
            # Delete the QueryInstance
            # @return [Boolean] true if delete succeeds, false otherwise
            def delete
               @version.delete('DELETE', @uri)
            end

            ##
            # Provide a user friendly representation
            def to_s
              context = @solution.map {|k, v| "#{k}: #{v}"}.join(',')
              "#<Twilio.Autopilot.V1.QueryContext #{context}>"
            end

            ##
            # Provide a detailed, user friendly representation
            def inspect
              context = @solution.map {|k, v| "#{k}: #{v}"}.join(',')
              "#<Twilio.Autopilot.V1.QueryContext #{context}>"
            end
          end

          ##
          # PLEASE NOTE that this class contains preview products that are subject to change. Use them with caution. If you currently do not have developer preview access, please contact help@twilio.com.
          class QueryInstance < InstanceResource
            ##
            # Initialize the QueryInstance
            # @param [Version] version Version that contains the resource
            # @param [Hash] payload payload that contains response from Twilio
            # @param [String] assistant_sid The SID of the
            #   {Assistant}[https://www.twilio.com/docs/autopilot/api/assistant] that is the
            #   parent of the resource.
            # @param [String] sid The Twilio-provided string that uniquely identifies the
            #   Query resource to fetch.
            # @return [QueryInstance] QueryInstance
            def initialize(version, payload, assistant_sid: nil, sid: nil)
              super(version)

              # Marshaled Properties
              @properties = {
                  'account_sid' => payload['account_sid'],
                  'date_created' => Twilio.deserialize_iso8601_datetime(payload['date_created']),
                  'date_updated' => Twilio.deserialize_iso8601_datetime(payload['date_updated']),
                  'results' => payload['results'],
                  'language' => payload['language'],
                  'model_build_sid' => payload['model_build_sid'],
                  'query' => payload['query'],
                  'sample_sid' => payload['sample_sid'],
                  'assistant_sid' => payload['assistant_sid'],
                  'sid' => payload['sid'],
                  'status' => payload['status'],
                  'url' => payload['url'],
                  'source_channel' => payload['source_channel'],
                  'dialogue_sid' => payload['dialogue_sid'],
              }

              # Context
              @instance_context = nil
              @params = {'assistant_sid' => assistant_sid, 'sid' => sid || @properties['sid'], }
            end

            ##
            # Generate an instance context for the instance, the context is capable of
            # performing various actions.  All instance actions are proxied to the context
            # @return [QueryContext] QueryContext for this QueryInstance
            def context
              unless @instance_context
                @instance_context = QueryContext.new(@version, @params['assistant_sid'], @params['sid'], )
              end
              @instance_context
            end

            ##
            # @return [String] The SID of the Account that created the resource
            def account_sid
              @properties['account_sid']
            end

            ##
            # @return [Time] The RFC 2822 date and time in GMT when the resource was created
            def date_created
              @properties['date_created']
            end

            ##
            # @return [Time] The RFC 2822 date and time in GMT when the resource was last updated
            def date_updated
              @properties['date_updated']
            end

            ##
            # @return [Hash] The natural language analysis results that include the Task recognized and a list of identified Fields
            def results
              @properties['results']
            end

            ##
            # @return [String] The ISO language-country string that specifies the language used by the Query
            def language
              @properties['language']
            end

            ##
            # @return [String] The SID of the {Model Build}[https://www.twilio.com/docs/autopilot/api/model-build] queried
            def model_build_sid
              @properties['model_build_sid']
            end

            ##
            # @return [String] The end-user's natural language input
            def query
              @properties['query']
            end

            ##
            # @return [String] The SID of an optional reference to the Sample created from the query
            def sample_sid
              @properties['sample_sid']
            end

            ##
            # @return [String] The SID of the Assistant that is the parent of the resource
            def assistant_sid
              @properties['assistant_sid']
            end

            ##
            # @return [String] The unique string that identifies the resource
            def sid
              @properties['sid']
            end

            ##
            # @return [String] The status of the Query
            def status
              @properties['status']
            end

            ##
            # @return [String] The absolute URL of the Query resource
            def url
              @properties['url']
            end

            ##
            # @return [String] The communication channel from where the end-user input came
            def source_channel
              @properties['source_channel']
            end

            ##
            # @return [String] The SID of the {Dialogue}[https://www.twilio.com/docs/autopilot/api/dialogue].
            def dialogue_sid
              @properties['dialogue_sid']
            end

            ##
            # Fetch the QueryInstance
            # @return [QueryInstance] Fetched QueryInstance
            def fetch
              context.fetch
            end

            ##
            # Update the QueryInstance
            # @param [String] sample_sid The SID of an optional reference to the
            #   {Sample}[https://www.twilio.com/docs/autopilot/api/task-sample] created from the
            #   query.
            # @param [String] status The new status of the resource. Can be: `pending-review`,
            #   `reviewed`, or `discarded`
            # @return [QueryInstance] Updated QueryInstance
            def update(sample_sid: :unset, status: :unset)
              context.update(sample_sid: sample_sid, status: status, )
            end

            ##
            # Delete the QueryInstance
            # @return [Boolean] true if delete succeeds, false otherwise
            def delete
              context.delete
            end

            ##
            # Provide a user friendly representation
            def to_s
              values = @params.map{|k, v| "#{k}: #{v}"}.join(" ")
              "<Twilio.Autopilot.V1.QueryInstance #{values}>"
            end

            ##
            # Provide a detailed, user friendly representation
            def inspect
              values = @properties.map{|k, v| "#{k}: #{v}"}.join(" ")
              "<Twilio.Autopilot.V1.QueryInstance #{values}>"
            end
          end
        end
      end
    end
  end
end