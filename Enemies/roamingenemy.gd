extends RigidBody3D


#North, West, South, East
var rotations = [deg_to_rad(0), deg_to_rad(90), deg_to_rad(180), deg_to_rad(270)]
var direction_facing : int
var directions = ["North", "West", "South", "East"]
var is_rotating : bool = false
var null_node = Node3D.new()

var north = null_node
var east = null_node
var south = null_node
var west  = null_node


var target : Vector3
@export var target_body : PhysicsBody3D
@export var health : int = 5
@export var range : int = 10
@onready var sprite : AnimatedSprite3D = get_node("Sprite3D")
@export var damage : int = 10
@export var power_level : int = 1
var timer = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func enemyMovement():
	
	if (self.target_body.position).distance_to(self.position) < self.range:
		#print(self.north, self.east, self.south, self.west)
		#print(self.position)
		#Will need to check if one of the cardinals has the player as an object
		var distances = [Vector3.ZERO,Vector3.ZERO,Vector3.ZERO,Vector3.ZERO]
		#can move in direction
		
		#check attack first
		if self.north == self.target_body or self.south == self.target_body or self.east == self.target_body or self.west == self.target_body:
			if self.target_body.has_method("attacked"):
				self.target_body.attacked(damage * power_level)
				sprite.play("attack")
		else:
			if self.north == null_node:
				distances[0] = Vector3(self.position.x, self.position.y, self.position.z - 1)
			else:
				distances[0] = Vector3(5000,5000,5000)
			if self.east == null_node:
				distances[1] = Vector3(self.position.x + 1, self.position.y, self.position.z)
			else:
				distances[1] = Vector3(5000,5000,5000)
			if self.south == null_node:
				distances[2] = Vector3(self.position.x, self.position.y, self.position.z + 1)
			else:
				distances[2] = Vector3(5000,5000,5000)
			if self.west == null_node:
				distances[3] = Vector3(self.position.x - 1, self.position.y, self.position.z)
			else:
				distances[3] = Vector3(5000,5000,5000)
	#		print(directions)
	#		print(distances)
			var min_vector = distances[0]
			for i in range(1,4):
		#		distances[i] =  target_body.position.distance_to(distances[i])
				if target_body.position.distance_to(distances[i]) < target_body.position.distance_to(min_vector):
					min_vector = distances[i]
	#		print(distances)
	#		print(min_vector)
			self.position = min_vector
		
func _process(delta):
	sprite.look_at(target_body.position, Vector3.UP)
	pass
	if self.health <= 0:
		queue_free()
func attacked(direction):
	self.health -= direction
	queue_free()

func _on_north_interaction_body_entered(body):
	self.north = body

func _on_east_interaction_body_entered(body):
	self.east = body

func _on_south_interaction_body_entered(body):
	self.south = body

func _on_west_interaction_body_entered(body):
	self.west = body

func _on_north_interaction_body_exited(body):
	self.north = null_node

func _on_east_interaction_body_exited(body):
	self.east = null_node

func _on_south_interaction_body_exited(body):
	self.south = null_node

func _on_west_interaction_body_exited(body):
	self.west = null_node

func _on_timer_timeout():
	enemyMovement()
