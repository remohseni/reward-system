module RewardSystem
  class CommandFactory
    RECOMMENDS, ACCEPTS = ACTIONS = %w[recommends accepts]

    def self.create(input_line, root_node)
      date, time, invitee_or_inviter, action, invitee_name = input_line.split(' ').map(&:strip)
      date_time = parse_date_time(date, time)
      return unless date_time

      if action == RECOMMENDS
        return RewardSystem::Commands::CreateService.new(
          root_node: root_node,
          input_line: input_line,
          date_time: date_time,
          inviter_name: invitee_or_inviter,
          invitee_name: invitee_name
        )
      end

      RewardSystem::Commands::UpdateService.new(
        root_node: root_node,
        input_line: input_line,
        date_time: date_time,
        invitee_name: invitee_or_inviter
      )
    end

    def self.parse_date_time(date, time)
      DateTime.parse "#{date} #{time}"
    rescue Date::Error
    end

    def self.sort_by_date_time(commands)
      commands.compact.sort_by(&:date_time)
    end
  end
end
