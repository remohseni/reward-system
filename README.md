# Reward System
System for tracking and rewarding users who recommend the app to other users

[Demo in heroku](https://reward-system-app.herokuapp.com/)

## Contents
+ [Install](#install)
+ [Tests](#test)
+ [API Documentation](#api-documentation)
+ [Tree object](#tree-object)
  + [#add_child](#add_child)
  + [#find_by_name](#find_by_name)
  + [#find_or_create_by_name](#find_or_create_by_name)
  + [#tree_traversal](#tree_traversal)
  + [#score_parents](#score_parents)
  + [#export_scores](#export_scores)
+ [License](#license)
To run the application:

## Install
```ruby
bundle install
rails server
```
After running the application visit http://localhost:3000

A sample form is provided on the root page to send requests to the API

## Tests ##
```ruby
rspec spec/models
rspec spec/requests
rspec spec/services
```
## API Documentation ##
http://localhost:3000/api-docs/index.html

## Tree object ##
A node is an instance of the Tree class. Each node is a tree because it can be the root of its own tree. A node can be added as a child to a node of another tree node.

#### Create a node
```ruby
node = RewardSystem::Tree.new(name: 'test node')
```

### Methods
#### `#add_child`
This method adds a node as a child of another node.
```ruby
parent_node = RewardSystem::Tree.new(name: 'parent node')
child_node = RewardSystem::Tree.new(name: 'Child node')

parent_node.add_child(child_node)
```

<img src="https://github.com/remohseni/reward-system/blob/main/docs/images/parent-child.png" />

#### `#find_by_name`
Finds a node by name in the entire tree.
```ruby
parent_node.find_by_name('Child node')
# returns a node if a node with name 'Child node' exists
# Otherwise returns nil
```

#### `#find_or_create_by_name`
Similar to the find_by_name method but the only difference is if there is no node with this name, a new node is created and appended to the caller node as a direct child node
```ruby
parent_node.find_or_create_by_name('Child node')
# finds or creates a node  with name `Child node`
```

#### `#tree_traversal`
With this method, all nodes under the parent node are visited. Tree traversal accepts a block. When the block is given, the block is executed on each node
```ruby
parent_node.tree_traversal do |node|
  puts node.name
end
# it will visit all nodes and prints names
```


#### `#to_h`
Present the tree as a nested hash
```ruby
root = RewardSystem::Tree.new(name: 'root')
node_a = RewardSystem::Tree.new(name: 'A')
node_b = RewardSystem::Tree.new(name: 'B')
node_c = RewardSystem::Tree.new(name: 'C')
node_d = RewardSystem::Tree.new(name: 'D')

root.add_child(node_a)
root.add_child(node_b)
node_a.add_child(node_c)
node_a.add_child(node_d)
root.to_h
# it will display the tree in a nested Hash
```
<img src="https://github.com/remohseni/reward-system/blob/main/docs/images/to_h_method.png" />

```ruby
{
  :A => {
    :score            => 0,
    :invitation_state => "pending",
    :children         => {
      :C => {
        :score            => 0,
        :invitation_state => "pending",
        :children         => nil
      },
      :D => {
        :score            => 0,
        :invitation_state => "pending",
        :children         => nil
      }
    }
  },
  :B => {
    :score            => 0,
    :invitation_state => "pending",
    :children         => nil
  }
}
```

#### `#score_parents`
This method adds a score of (Amount / 2) ^ k to all parents. The default value for `amount` is 1. K is the distance from the parent node to the current node. Notice that K starts at 0.
The first parent receives 1 point, the grandparent receives 0.5 points and the second grandparent receives 0.25 points, and so on.

```ruby
node = RewardSystem::Tree.new(name: 'node')
root.score_parents(5)
```

#### #export_scores
This will calculate points of each node and result is a hash. Excludes node with zero point and also the root node
```ruby
root = RewardSystem::Tree.new(name: 'root')
node_a = RewardSystem::Tree.new(name: 'A')
node_b = RewardSystem::Tree.new(name: 'B')
node_c = RewardSystem::Tree.new(name: 'C')
node_d = RewardSystem::Tree.new(name: 'D')
node_e = RewardSystem::Tree.new(name: 'E')

root.add_child(node_a)
root.add_child(node_b)
node_a.add_child(node_c)
node_a.add_child(node_d)
node_d.add_child(node_e)

node_e.score_parents
node_d.score_parents(1)

root.export_scores
# returns { "A" => 1.5, "D" => 1 }
```
if we run to_h on root:
```ruby
{
  :A => {
    :score            => 1.5,
    :invitation_state => "pending",
    :children         => {
      :C => {
        :score            => 0,
        :invitation_state => "pending",
        :children         => nil
      },
      :D => {
        :score            => 1,
        :invitation_state => "pending",
        :children         => {
          :E => {
            :score            => 0,
            :invitation_state => "pending",
            :children         => nil
          }
        }
      }
    }
  },
  :B => {
    :score            => 0,
    :invitation_state => "pending",
    :children         => nil
  }
}
```

## License
This project is available under the [MIT](https://opensource.org/licenses/mit-license.php) license.
