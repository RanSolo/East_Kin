##
# This code was generated by
# \ / _    _  _|   _  _
#  | (_)\/(_)(_|\/| |(/_  v1.0.0
#       /       /
#
# frozen_string_literal: true

module Twilio
  module REST
    class Insights < Domain
      class V1 < Version
        class ConferenceContext < InstanceContext
          class ConferenceParticipantList < ListResource
            ##
            # Initialize the ConferenceParticipantList
            # @param [Version] version Version that contains the resource
            # @param [String] conference_sid The unique SID identifier of the Conference.
            # @return [ConferenceParticipantList] ConferenceParticipantList
            def initialize(version, conference_sid: nil)
              super(version)

              # Path Solution
              @solution = {conference_sid: conference_sid}
              @uri = "/Conferences/#{@solution[:conference_sid]}/Participants"
            end

            ##
            # Lists ConferenceParticipantInstance records from the API as a list.
            # Unlike stream(), this operation is eager and will load `limit` records into
            # memory before returning.
            # @param [String] participant_sid The unique SID identifier of the Participant.
            # @param [String] label User-specified label for a participant.
            # @param [String] events Conference events generated by application or participant
            #   activity; e.g. `hold`, `mute`, etc.
            # @param [Integer] limit Upper limit for the number of records to return. stream()
            #    guarantees to never return more than limit.  Default is no limit
            # @param [Integer] page_size Number of records to fetch per request, when
            #    not set will use the default value of 50 records.  If no page_size is defined
            #    but a limit is defined, stream() will attempt to read the limit with the most
            #    efficient page size, i.e. min(limit, 1000)
            # @return [Array] Array of up to limit results
            def list(participant_sid: :unset, label: :unset, events: :unset, limit: nil, page_size: nil)
              self.stream(
                  participant_sid: participant_sid,
                  label: label,
                  events: events,
                  limit: limit,
                  page_size: page_size
              ).entries
            end

            ##
            # Streams ConferenceParticipantInstance records from the API as an Enumerable.
            # This operation lazily loads records as efficiently as possible until the limit
            # is reached.
            # @param [String] participant_sid The unique SID identifier of the Participant.
            # @param [String] label User-specified label for a participant.
            # @param [String] events Conference events generated by application or participant
            #   activity; e.g. `hold`, `mute`, etc.
            # @param [Integer] limit Upper limit for the number of records to return. stream()
            #    guarantees to never return more than limit. Default is no limit.
            # @param [Integer] page_size Number of records to fetch per request, when
            #    not set will use the default value of 50 records. If no page_size is defined
            #    but a limit is defined, stream() will attempt to read the limit with the most
            #    efficient page size, i.e. min(limit, 1000)
            # @return [Enumerable] Enumerable that will yield up to limit results
            def stream(participant_sid: :unset, label: :unset, events: :unset, limit: nil, page_size: nil)
              limits = @version.read_limits(limit, page_size)

              page = self.page(
                  participant_sid: participant_sid,
                  label: label,
                  events: events,
                  page_size: limits[:page_size],
              )

              @version.stream(page, limit: limits[:limit], page_limit: limits[:page_limit])
            end

            ##
            # When passed a block, yields ConferenceParticipantInstance records from the API.
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
            # Retrieve a single page of ConferenceParticipantInstance records from the API.
            # Request is executed immediately.
            # @param [String] participant_sid The unique SID identifier of the Participant.
            # @param [String] label User-specified label for a participant.
            # @param [String] events Conference events generated by application or participant
            #   activity; e.g. `hold`, `mute`, etc.
            # @param [String] page_token PageToken provided by the API
            # @param [Integer] page_number Page Number, this value is simply for client state
            # @param [Integer] page_size Number of records to return, defaults to 50
            # @return [Page] Page of ConferenceParticipantInstance
            def page(participant_sid: :unset, label: :unset, events: :unset, page_token: :unset, page_number: :unset, page_size: :unset)
              params = Twilio::Values.of({
                  'ParticipantSid' => participant_sid,
                  'Label' => label,
                  'Events' => events,
                  'PageToken' => page_token,
                  'Page' => page_number,
                  'PageSize' => page_size,
              })

              response = @version.page('GET', @uri, params: params)

              ConferenceParticipantPage.new(@version, response, @solution)
            end

            ##
            # Retrieve a single page of ConferenceParticipantInstance records from the API.
            # Request is executed immediately.
            # @param [String] target_url API-generated URL for the requested results page
            # @return [Page] Page of ConferenceParticipantInstance
            def get_page(target_url)
              response = @version.domain.request(
                  'GET',
                  target_url
              )
              ConferenceParticipantPage.new(@version, response, @solution)
            end

            ##
            # Provide a user friendly representation
            def to_s
              '#<Twilio.Insights.V1.ConferenceParticipantList>'
            end
          end

          class ConferenceParticipantPage < Page
            ##
            # Initialize the ConferenceParticipantPage
            # @param [Version] version Version that contains the resource
            # @param [Response] response Response from the API
            # @param [Hash] solution Path solution for the resource
            # @return [ConferenceParticipantPage] ConferenceParticipantPage
            def initialize(version, response, solution)
              super(version, response)

              # Path Solution
              @solution = solution
            end

            ##
            # Build an instance of ConferenceParticipantInstance
            # @param [Hash] payload Payload response from the API
            # @return [ConferenceParticipantInstance] ConferenceParticipantInstance
            def get_instance(payload)
              ConferenceParticipantInstance.new(@version, payload, conference_sid: @solution[:conference_sid], )
            end

            ##
            # Provide a user friendly representation
            def to_s
              '<Twilio.Insights.V1.ConferenceParticipantPage>'
            end
          end

          class ConferenceParticipantContext < InstanceContext
            ##
            # Initialize the ConferenceParticipantContext
            # @param [Version] version Version that contains the resource
            # @param [String] conference_sid The unique SID identifier of the Conference.
            # @param [String] participant_sid The unique SID identifier of the Participant.
            # @return [ConferenceParticipantContext] ConferenceParticipantContext
            def initialize(version, conference_sid, participant_sid)
              super(version)

              # Path Solution
              @solution = {conference_sid: conference_sid, participant_sid: participant_sid, }
              @uri = "/Conferences/#{@solution[:conference_sid]}/Participants/#{@solution[:participant_sid]}"
            end

            ##
            # Fetch the ConferenceParticipantInstance
            # @param [String] events Conference events generated by application or participant
            #   activity; e.g. `hold`, `mute`, etc.
            # @param [String] metrics Object. Contains participant call quality metrics.
            # @return [ConferenceParticipantInstance] Fetched ConferenceParticipantInstance
            def fetch(events: :unset, metrics: :unset)
              params = Twilio::Values.of({'Events' => events, 'Metrics' => metrics, })

              payload = @version.fetch('GET', @uri, params: params)

              ConferenceParticipantInstance.new(
                  @version,
                  payload,
                  conference_sid: @solution[:conference_sid],
                  participant_sid: @solution[:participant_sid],
              )
            end

            ##
            # Provide a user friendly representation
            def to_s
              context = @solution.map {|k, v| "#{k}: #{v}"}.join(',')
              "#<Twilio.Insights.V1.ConferenceParticipantContext #{context}>"
            end

            ##
            # Provide a detailed, user friendly representation
            def inspect
              context = @solution.map {|k, v| "#{k}: #{v}"}.join(',')
              "#<Twilio.Insights.V1.ConferenceParticipantContext #{context}>"
            end
          end

          class ConferenceParticipantInstance < InstanceResource
            ##
            # Initialize the ConferenceParticipantInstance
            # @param [Version] version Version that contains the resource
            # @param [Hash] payload payload that contains response from Twilio
            # @param [String] conference_sid The unique SID identifier of the Conference.
            # @param [String] participant_sid The unique SID identifier of the Participant.
            # @return [ConferenceParticipantInstance] ConferenceParticipantInstance
            def initialize(version, payload, conference_sid: nil, participant_sid: nil)
              super(version)

              # Marshaled Properties
              @properties = {
                  'participant_sid' => payload['participant_sid'],
                  'label' => payload['label'],
                  'conference_sid' => payload['conference_sid'],
                  'call_sid' => payload['call_sid'],
                  'account_sid' => payload['account_sid'],
                  'call_direction' => payload['call_direction'],
                  'from' => payload['from'],
                  'to' => payload['to'],
                  'call_status' => payload['call_status'],
                  'country_code' => payload['country_code'],
                  'is_moderator' => payload['is_moderator'],
                  'join_time' => Twilio.deserialize_iso8601_datetime(payload['join_time']),
                  'leave_time' => Twilio.deserialize_iso8601_datetime(payload['leave_time']),
                  'duration_seconds' => payload['duration_seconds'] == nil ? payload['duration_seconds'] : payload['duration_seconds'].to_i,
                  'outbound_queue_length' => payload['outbound_queue_length'] == nil ? payload['outbound_queue_length'] : payload['outbound_queue_length'].to_i,
                  'outbound_time_in_queue' => payload['outbound_time_in_queue'] == nil ? payload['outbound_time_in_queue'] : payload['outbound_time_in_queue'].to_i,
                  'jitter_buffer_size' => payload['jitter_buffer_size'],
                  'is_coach' => payload['is_coach'],
                  'coached_participants' => payload['coached_participants'],
                  'participant_region' => payload['participant_region'],
                  'conference_region' => payload['conference_region'],
                  'call_type' => payload['call_type'],
                  'processing_state' => payload['processing_state'],
                  'properties' => payload['properties'],
                  'events' => payload['events'],
                  'metrics' => payload['metrics'],
                  'url' => payload['url'],
              }

              # Context
              @instance_context = nil
              @params = {
                  'conference_sid' => conference_sid,
                  'participant_sid' => participant_sid || @properties['participant_sid'],
              }
            end

            ##
            # Generate an instance context for the instance, the context is capable of
            # performing various actions.  All instance actions are proxied to the context
            # @return [ConferenceParticipantContext] ConferenceParticipantContext for this ConferenceParticipantInstance
            def context
              unless @instance_context
                @instance_context = ConferenceParticipantContext.new(
                    @version,
                    @params['conference_sid'],
                    @params['participant_sid'],
                )
              end
              @instance_context
            end

            ##
            # @return [String] SID for this participant.
            def participant_sid
              @properties['participant_sid']
            end

            ##
            # @return [String] The user-specified label of this participant.
            def label
              @properties['label']
            end

            ##
            # @return [String] Conference SID.
            def conference_sid
              @properties['conference_sid']
            end

            ##
            # @return [String] Unique SID identifier of the call.
            def call_sid
              @properties['call_sid']
            end

            ##
            # @return [String] Account SID.
            def account_sid
              @properties['account_sid']
            end

            ##
            # @return [conference_participant.CallDirection] Call direction of the participant.
            def call_direction
              @properties['call_direction']
            end

            ##
            # @return [String] Caller ID of the calling party.
            def from
              @properties['from']
            end

            ##
            # @return [String] Called party.
            def to
              @properties['to']
            end

            ##
            # @return [conference_participant.CallStatus] Call status of the call that generated the participant.
            def call_status
              @properties['call_status']
            end

            ##
            # @return [String] ISO alpha-2 country code of the participant.
            def country_code
              @properties['country_code']
            end

            ##
            # @return [Boolean] Boolean. Indicates whether participant had startConferenceOnEnter=true or endConferenceOnExit=true.
            def is_moderator
              @properties['is_moderator']
            end

            ##
            # @return [Time] ISO 8601 timestamp of participant join event.
            def join_time
              @properties['join_time']
            end

            ##
            # @return [Time] ISO 8601 timestamp of participant leave event.
            def leave_time
              @properties['leave_time']
            end

            ##
            # @return [String] Participant durations in seconds.
            def duration_seconds
              @properties['duration_seconds']
            end

            ##
            # @return [String] Estimated time in queue at call creation.
            def outbound_queue_length
              @properties['outbound_queue_length']
            end

            ##
            # @return [String] Actual time in queue (seconds).
            def outbound_time_in_queue
              @properties['outbound_time_in_queue']
            end

            ##
            # @return [conference_participant.JitterBufferSize] The Jitter Buffer Size of this Conference Participant.
            def jitter_buffer_size
              @properties['jitter_buffer_size']
            end

            ##
            # @return [Boolean] Boolean. Indicated whether participant was a coach.
            def is_coach
              @properties['is_coach']
            end

            ##
            # @return [Array[String]] Call SIDs coached by this participant.
            def coached_participants
              @properties['coached_participants']
            end

            ##
            # @return [conference_participant.Region] Twilio region where the participant media originates.
            def participant_region
              @properties['participant_region']
            end

            ##
            # @return [conference_participant.Region] The Conference Region of this Conference Participant.
            def conference_region
              @properties['conference_region']
            end

            ##
            # @return [conference_participant.CallType] The Call Type of this Conference Participant.
            def call_type
              @properties['call_type']
            end

            ##
            # @return [conference_participant.ProcessingState] Processing state of the Participant Summary.
            def processing_state
              @properties['processing_state']
            end

            ##
            # @return [Hash] Participant properties and metadata.
            def properties
              @properties['properties']
            end

            ##
            # @return [Hash] Object containing information of actions taken by participants. Nested resource URLs.
            def events
              @properties['events']
            end

            ##
            # @return [Hash] Object. Contains participant quality metrics.
            def metrics
              @properties['metrics']
            end

            ##
            # @return [String] The URL of this resource.
            def url
              @properties['url']
            end

            ##
            # Fetch the ConferenceParticipantInstance
            # @param [String] events Conference events generated by application or participant
            #   activity; e.g. `hold`, `mute`, etc.
            # @param [String] metrics Object. Contains participant call quality metrics.
            # @return [ConferenceParticipantInstance] Fetched ConferenceParticipantInstance
            def fetch(events: :unset, metrics: :unset)
              context.fetch(events: events, metrics: metrics, )
            end

            ##
            # Provide a user friendly representation
            def to_s
              values = @params.map{|k, v| "#{k}: #{v}"}.join(" ")
              "<Twilio.Insights.V1.ConferenceParticipantInstance #{values}>"
            end

            ##
            # Provide a detailed, user friendly representation
            def inspect
              values = @properties.map{|k, v| "#{k}: #{v}"}.join(" ")
              "<Twilio.Insights.V1.ConferenceParticipantInstance #{values}>"
            end
          end
        end
      end
    end
  end
end