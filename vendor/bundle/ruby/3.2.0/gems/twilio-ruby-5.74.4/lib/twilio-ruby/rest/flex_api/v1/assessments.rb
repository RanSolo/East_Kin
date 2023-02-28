##
# This code was generated by
# \ / _    _  _|   _  _
#  | (_)\/(_)(_|\/| |(/_  v1.0.0
#       /       /
#
# frozen_string_literal: true

module Twilio
  module REST
    class FlexApi < Domain
      class V1 < Version
        ##
        # PLEASE NOTE that this class contains preview products that are subject to change. Use them with caution. If you currently do not have developer preview access, please contact help@twilio.com.
        class AssessmentsList < ListResource
          ##
          # Initialize the AssessmentsList
          # @param [Version] version Version that contains the resource
          # @return [AssessmentsList] AssessmentsList
          def initialize(version)
            super(version)

            # Path Solution
            @solution = {}
            @uri = "/Insights/QM/Assessments"
          end

          ##
          # Create the AssessmentsInstance
          # @param [String] category_id The id of the category
          # @param [String] category_name The name of the category
          # @param [String] segment_id Segment Id of the conversation
          # @param [String] user_name Name of the user assessing conversation
          # @param [String] user_email Email of the user assessing conversation
          # @param [String] agent_id The id of the Agent
          # @param [String] offset The offset of the conversation.
          # @param [String] metric_id The question Id selected for assessment
          # @param [String] metric_name The question name of the assessment
          # @param [String] answer_text The answer text selected by user
          # @param [String] answer_id The id of the answer selected by user
          # @param [String] questionnaire_id Questionnaire Id of the associated question
          # @param [String] token The Token HTTP request header
          # @return [AssessmentsInstance] Created AssessmentsInstance
          def create(category_id: nil, category_name: nil, segment_id: nil, user_name: nil, user_email: nil, agent_id: nil, offset: nil, metric_id: nil, metric_name: nil, answer_text: nil, answer_id: nil, questionnaire_id: nil, token: :unset)
            data = Twilio::Values.of({
                'CategoryId' => category_id,
                'CategoryName' => category_name,
                'SegmentId' => segment_id,
                'UserName' => user_name,
                'UserEmail' => user_email,
                'AgentId' => agent_id,
                'Offset' => offset,
                'MetricId' => metric_id,
                'MetricName' => metric_name,
                'AnswerText' => answer_text,
                'AnswerId' => answer_id,
                'QuestionnaireId' => questionnaire_id,
            })
            headers = Twilio::Values.of({'Token' => token, })

            payload = @version.create('POST', @uri, data: data, headers: headers)

            AssessmentsInstance.new(@version, payload, )
          end

          ##
          # Provide a user friendly representation
          def to_s
            '#<Twilio.FlexApi.V1.AssessmentsList>'
          end
        end

        ##
        # PLEASE NOTE that this class contains preview products that are subject to change. Use them with caution. If you currently do not have developer preview access, please contact help@twilio.com.
        class AssessmentsPage < Page
          ##
          # Initialize the AssessmentsPage
          # @param [Version] version Version that contains the resource
          # @param [Response] response Response from the API
          # @param [Hash] solution Path solution for the resource
          # @return [AssessmentsPage] AssessmentsPage
          def initialize(version, response, solution)
            super(version, response)

            # Path Solution
            @solution = solution
          end

          ##
          # Build an instance of AssessmentsInstance
          # @param [Hash] payload Payload response from the API
          # @return [AssessmentsInstance] AssessmentsInstance
          def get_instance(payload)
            AssessmentsInstance.new(@version, payload, )
          end

          ##
          # Provide a user friendly representation
          def to_s
            '<Twilio.FlexApi.V1.AssessmentsPage>'
          end
        end

        ##
        # PLEASE NOTE that this class contains preview products that are subject to change. Use them with caution. If you currently do not have developer preview access, please contact help@twilio.com.
        class AssessmentsContext < InstanceContext
          ##
          # Initialize the AssessmentsContext
          # @param [Version] version Version that contains the resource
          # @param [String] assessment_id The id of the assessment to be modified
          # @return [AssessmentsContext] AssessmentsContext
          def initialize(version, assessment_id)
            super(version)

            # Path Solution
            @solution = {assessment_id: assessment_id, }
            @uri = "/Insights/QM/Assessments/#{@solution[:assessment_id]}"
          end

          ##
          # Update the AssessmentsInstance
          # @param [String] offset The offset of the conversation
          # @param [String] answer_text The answer text selected by user
          # @param [String] answer_id The id of the answer selected by user
          # @param [String] token The Token HTTP request header
          # @return [AssessmentsInstance] Updated AssessmentsInstance
          def update(offset: nil, answer_text: nil, answer_id: nil, token: :unset)
            data = Twilio::Values.of({'Offset' => offset, 'AnswerText' => answer_text, 'AnswerId' => answer_id, })
            headers = Twilio::Values.of({'Token' => token, })

            payload = @version.update('POST', @uri, data: data, headers: headers)

            AssessmentsInstance.new(@version, payload, assessment_id: @solution[:assessment_id], )
          end

          ##
          # Provide a user friendly representation
          def to_s
            context = @solution.map {|k, v| "#{k}: #{v}"}.join(',')
            "#<Twilio.FlexApi.V1.AssessmentsContext #{context}>"
          end

          ##
          # Provide a detailed, user friendly representation
          def inspect
            context = @solution.map {|k, v| "#{k}: #{v}"}.join(',')
            "#<Twilio.FlexApi.V1.AssessmentsContext #{context}>"
          end
        end

        ##
        # PLEASE NOTE that this class contains preview products that are subject to change. Use them with caution. If you currently do not have developer preview access, please contact help@twilio.com.
        class AssessmentsInstance < InstanceResource
          ##
          # Initialize the AssessmentsInstance
          # @param [Version] version Version that contains the resource
          # @param [Hash] payload payload that contains response from Twilio
          # @param [String] assessment_id The id of the assessment to be modified
          # @return [AssessmentsInstance] AssessmentsInstance
          def initialize(version, payload, assessment_id: nil)
            super(version)

            # Marshaled Properties
            @properties = {
                'account_sid' => payload['account_sid'],
                'assessment_id' => payload['assessment_id'],
                'offset' => payload['offset'] == nil ? payload['offset'] : payload['offset'].to_f,
                'report' => payload['report'],
                'weight' => payload['weight'] == nil ? payload['weight'] : payload['weight'].to_f,
                'agent_id' => payload['agent_id'],
                'segment_id' => payload['segment_id'],
                'user_name' => payload['user_name'],
                'user_email' => payload['user_email'],
                'answer_text' => payload['answer_text'],
                'answer_id' => payload['answer_id'],
                'assessment' => payload['assessment'],
                'timestamp' => payload['timestamp'] == nil ? payload['timestamp'] : payload['timestamp'].to_f,
                'url' => payload['url'],
            }

            # Context
            @instance_context = nil
            @params = {'assessment_id' => assessment_id || @properties['assessment_id'], }
          end

          ##
          # Generate an instance context for the instance, the context is capable of
          # performing various actions.  All instance actions are proxied to the context
          # @return [AssessmentsContext] AssessmentsContext for this AssessmentsInstance
          def context
            unless @instance_context
              @instance_context = AssessmentsContext.new(@version, @params['assessment_id'], )
            end
            @instance_context
          end

          ##
          # @return [String] Account Sid.
          def account_sid
            @properties['account_sid']
          end

          ##
          # @return [String] Assessment id
          def assessment_id
            @properties['assessment_id']
          end

          ##
          # @return [String] offset
          def offset
            @properties['offset']
          end

          ##
          # @return [Boolean] Part of assessment report
          def report
            @properties['report']
          end

          ##
          # @return [String] The weightage
          def weight
            @properties['weight']
          end

          ##
          # @return [String] AgentID
          def agent_id
            @properties['agent_id']
          end

          ##
          # @return [String] Segment Id
          def segment_id
            @properties['segment_id']
          end

          ##
          # @return [String] The user name.
          def user_name
            @properties['user_name']
          end

          ##
          # @return [String] The user email id.
          def user_email
            @properties['user_email']
          end

          ##
          # @return [String] Answer text
          def answer_text
            @properties['answer_text']
          end

          ##
          # @return [String] Answer Id
          def answer_id
            @properties['answer_id']
          end

          ##
          # @return [Hash] Assessment Details
          def assessment
            @properties['assessment']
          end

          ##
          # @return [String] The timestamp
          def timestamp
            @properties['timestamp']
          end

          ##
          # @return [String] The url
          def url
            @properties['url']
          end

          ##
          # Update the AssessmentsInstance
          # @param [String] offset The offset of the conversation
          # @param [String] answer_text The answer text selected by user
          # @param [String] answer_id The id of the answer selected by user
          # @param [String] token The Token HTTP request header
          # @return [AssessmentsInstance] Updated AssessmentsInstance
          def update(offset: nil, answer_text: nil, answer_id: nil, token: :unset)
            context.update(offset: offset, answer_text: answer_text, answer_id: answer_id, token: token, )
          end

          ##
          # Provide a user friendly representation
          def to_s
            values = @params.map{|k, v| "#{k}: #{v}"}.join(" ")
            "<Twilio.FlexApi.V1.AssessmentsInstance #{values}>"
          end

          ##
          # Provide a detailed, user friendly representation
          def inspect
            values = @properties.map{|k, v| "#{k}: #{v}"}.join(" ")
            "<Twilio.FlexApi.V1.AssessmentsInstance #{values}>"
          end
        end
      end
    end
  end
end