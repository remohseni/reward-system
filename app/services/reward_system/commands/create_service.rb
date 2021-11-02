module RewardSystem
  module Commands
    class CreateService < BaseService
      def initialize(**args)
        super(args)
        @inviter_name = args[:inviter_name]
      end

      def perform
        return if invitee

        inviter = root_node.find_or_create_by_name(inviter_name)
        invitee = Tree.new(name: invitee_name)
        inviter.add_child(invitee)
      end

      private

      attr_accessor :inviter_name
    end
  end
end
