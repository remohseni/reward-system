module RewardSystem
  module Commands
    class UpdateService < BaseService
      def perform
        return if invitee.blank? || invitee.accepted?

        invitee.invitation_state = Tree::ACCEPTED
        invitee.score_parents
      end
    end
  end
end
