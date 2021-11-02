require 'rails_helper'

describe RewardSystem::Tree do
  describe 'attributes' do
    let(:tree) { described_class.new(name: 'name') }

    %i[name parent children score invitation_state].each do |attr|
      it "respond to #{attr}" do
        expect(tree).to respond_to(attr)
      end
    end
  end

  describe 'methods' do
    let(:root) { described_class.new(name: 'root') }
    let(:tree_1) { described_class.new(name: 'tree_1') }
    let(:tree_2) { described_class.new(name: 'tree_2') }
    let(:tree_3) { described_class.new(name: 'tree_3') }
    let(:tree_4) { described_class.new(name: 'tree_4') }
    let(:tree_5) { described_class.new(name: 'tree_5') }
    let(:tree_6) { described_class.new(name: 'tree_6') }

    before do
      root.add_child(tree_1)
      tree_1.add_child(tree_2)
      tree_1.add_child(tree_3)
      tree_3.add_child(tree_4)
      tree_3.add_child(tree_5)
      tree_5.add_child(tree_6)
    end

    describe '#find_by_name' do
      it 'returns tree when find' do
        expect(tree_1.find_by_name('tree_5')).to eq(tree_5)
      end

      it 'returns nil when find' do
        expect(tree_1.find_by_name('not exist')).to eq(nil)
      end
    end

    describe '#root' do
      subject(:root) { tree_5.root }

      it { is_expected.to eq(root) }
    end

    describe '#export_scores' do
      subject(:export_scores) { tree_1.export_scores }

      before do
        tree_3.score = 2
        tree_4.score = 3
      end

      it { is_expected.to match({ 'tree_3' => 2, 'tree_4' => 3 }) }
    end

    describe '#score_parents' do
      subject(:score_parents) { tree_6.score_parents }

      before do
        tree_5.score = 1
        tree_3.score = 1
        tree_1.score = 1

        score_parents
      end

      it 'adds 1 to first parent' do
        expect(tree_5.score).to eq(2)
      end

      it 'adds 0.5 to second parent' do
        expect(tree_3.score).to eq(1.5)
      end

      it 'adds 0.25 to second parent' do
        expect(tree_1.score).to eq(1.25)
      end
    end

    describe '#tree_traversal' do
      subject(:tree_traversal) { root.tree_traversal }

      it 'visits all nodes ' do
        visited = []

        root.tree_traversal do |node|
          visited << node.name
        end

        expect(visited).to match_array(%w[root tree_1 tree_2 tree_3 tree_4 tree_5 tree_6])
      end
    end

    describe '#accepted?' do
      subject(:accepted?) { tree_1.accepted? }

      context 'when the value is accepted' do
        before do
          tree_1.invitation_state = RewardSystem::Tree::ACCEPTED
        end

        it { is_expected.to eq(true) }
      end

      context 'when the value is not accepted' do
        before do
          tree_1.invitation_state = 'something else'
        end

        it { is_expected.to eq(false) }
      end
    end

    describe '#root' do
      subject(:root) { tree_5.root }

      it { is_expected.to eq(root) }
    end

    describe '#to_h' do
      subject(:to_h) { root.to_h }

      let(:expected) do
        {
          tree_1: {
            score: 0,
            invitation_state: 'pending',
            children: {
              tree_2: {
                score: 0,
                invitation_state: 'pending',
                children: nil
              },
              tree_3: {
                score: 0,
                invitation_state: 'pending',
                children: {
                  tree_4: {
                    score: 0,
                    invitation_state: 'pending',
                    children: nil
                  },
                  tree_5: {
                    score: 0,
                    invitation_state: 'pending',
                    children: {
                      tree_6: {
                        score: 0,
                        invitation_state: 'pending',
                        children: nil
                      }
                    }
                  }
                }
              }
            }
          }
        }
      end

      it 'displays tree hashified' do
        expect(subject).to match(expected)
      end
    end
  end
end
