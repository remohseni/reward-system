# Reward System
System for tracking and rewarding users who recommend the app to other users

[Demo in heroku](https://reward-system-app.herokuapp.com/)

## Contents
+ [Install](#install)
+ [Tests](#test)
+ [API Documentation](#api-documentation)
+ [Tree object](#tree-object)
  + [Methods](#tree-methods)
+ [License](#license)
To run the application:

## Install
```ruby
bundle install
rails server
```
After running application visit http://localhost:3000

In the root page an example form is provided to send request to the api

## Tests ##
```ruby
rspec spec/models
rspec spec/requests
rspec spec/services
```
## API Documentation ##
After running the app you can see the documentation for the api under the link:
http://localhost:3000/api-docs/index.html

## Tree object ##
Tree class can create a node of a tree. Each node is a tree and can be added to a node of another tree.

#### Create a node
```ruby
node = RewardSystem::Tree.new(name: 'test node')
```

### Methods
#### `#add_child` 
Add a node as a child of another node
```ruby
parent_node = RewardSystem::Tree.new(name: 'parent node')
child_node = RewardSystem::Tree.new(name: 'Child node')

parent_node.add_child(child_node)
```

<img src="https://github.com/remohseni/reward-system/blob/main/docs/images/parent-child.png" />

#### `#find_by_name`
Finds a node by name inside a parent node tree
```ruby
parent_node.find_by_name('Child node')
# returns a node if a node with name 'Child node' exists
# Otherwise returns nil
```

#### `#find_or_create_by_name`
Similar to find_by_name method but if there is no any method with that name it will create a new node and attaches to the parent node as a direct child  
```ruby
parent_node.find_or_create_by_name('Child node')
# finds or creates a node  with name `Child node`
```

#### `#tree_traversal`
By using this method all nodes under the parent node are visited. tree_traversal accepts a block. If the block is given, the block will run on each node 
```ruby
parent_node.tree_traversal do |node|
  puts node.name
end
# it will visit all nodes and prints names 
```


#### `#to_h`
By using this method all nodes under the parent node are visited. tree_traversal accepts a block. If the block is given, the block will run on each node
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
This method will add score of (amount/2)^k to all parents. Default value for `amount` is 1. K is the distance of parent from the current node. Note that K starts from 0.
First parent gets 1 point, grandparent gets 0.5 point and second grandparent '0.25' point and so on

```ruby
node = RewardSystem::Tree.new(name: 'node')
root.score_parents(5)
```

#### `#export_scores
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

