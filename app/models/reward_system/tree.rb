module RewardSystem
  class Tree
    PENDING, ACCEPTED = INVITATION_STATE = %w[pending accepted]

    attr_accessor :name, :parent, :children, :score, :invitation_state

    def initialize(name:, parent: nil, score: 0, invitation_state: PENDING)
      @name = name
      @score = score
      @parent = parent
      @invitation_state = invitation_state
      @children = []
    end

    def find_by_name(name)
      tree_traversal do |node|
        return node if node.name == name
      end
      nil
    end

    def find_or_create_by_name(name)
      node = find_by_name(name)
      return node if node

      node = Tree.new(name: name)
      add_child(node)
      node
    end

    def export_scores
      result = {}
      tree_traversal do |node|
        !node.root? && node.score.positive? && result.merge!(node.name => node.score)
      end
      result
    end

    def score_parents(amount = 1)
      return if root?

      parent.score += amount
      parent.score_parents(amount / 2.0)
    end

    def tree_traversal(&block)
      block.call(self) if block_given?
      return if children.blank?

      children.each do |child|
        child.tree_traversal(&block)
      end
    end

    def accepted?
      invitation_state == ACCEPTED
    end

    def root
      node = self
      node = node.parent while node.parent
      node
    end

    def add_child(node)
      children << node
      node.parent = self
    end

    def root?
      self == root
    end

    def to_h
      return if children.blank?

      parent = {}
      children.each do |child|
        parent[:"#{child.name}"] = {
          score: child.score,
          invitation_state: child.invitation_state,
          children: child.to_h
        }
      end
      parent
    end

    private

    def to_s
      {
        name: name,
        parent: parent,
        score: score,
        invitation_state: invitation_state,
        children: children.map(&:name)
      }
    end
  end
end
