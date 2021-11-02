module RewardSystem
  module Commands
    class BaseService
      attr_accessor :date_time, :invitee_name, :root_node, :input_line

      def initialize(**args)
        @root_node = args[:root_node]
        @input_line = args[:input_line]
        @date_time = args[:date_time]
        @invitee_name = args[:invitee_name]
      end

      private

      def invitee
        root_node.find_by_name(invitee_name)
      end
    end
  end
end
