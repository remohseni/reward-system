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

#### Add a node as a child of another node
```ruby
parent_node = RewardSystem::Tree.new(name: 'parent node')
child_node = RewardSystem::Tree.new(name: 'Child node')

parent_node.add_child(child_node)
```

<img src="https://github.com/remohseni/reward-system/blob/main/docs/images/parent-child.png" />
 
## License
This project is available under the [MIT](https://opensource.org/licenses/mit-license.php) license.

