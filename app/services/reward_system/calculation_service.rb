module RewardSystem
  class CalculationService
    def initialize
      @root_node = Tree.new(name: 'root')
    end

    def self.call(input_file)
      new.call(input_file)
    end

    def call(input_file)
      return {} unless input_file

      raw_commands_list = read_file(input_file)
      commands = create_commands(raw_commands_list)
      commands = sort_by_date_time(commands)
      perform_commands(commands)
      root_node.export_scores
    end

    private

    attr_accessor :root_node

    def read_file(input_file)
      data_list = []
      File.open(input_file, 'r').each_line do |line|
        break if line.strip == 'skip' || line.strip.blank?

        data_list << line.strip
      end
      data_list
    end

    def create_commands(raw_commands)
      raw_commands.map do |raw_command|
        RewardSystem::CommandFactory.create(raw_command, root_node)
      end
    end

    def sort_by_date_time(commands)
      RewardSystem::CommandFactory.sort_by_date_time(commands)
    end

    def perform_commands(commands)
      RewardSystem::CommandFactory.sort_by_date_time(commands).each(&:perform)
    end
  end
end
