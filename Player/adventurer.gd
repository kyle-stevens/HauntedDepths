extends RigidBody3D

#North, West, South, East
var rotations = [deg_to_rad(0), deg_to_rad(90), deg_to_rad(180), deg_to_rad(270)]
var direction_facing : int
var directions = ["North", "West", "South", "East"]
var is_rotating : bool = false
var null_node = Node3D.new()
var objs_in_front : Node3D = self.null_node
var objs_behind : Node3D = self.null_node
var objs_left : Node3D = self.null_node
var objs_right : Node3D = self.null_node

var health : int = 100
var potions : int = 5
var mana : int = 100
var projectile_type : String = 'bolt'

# Called when the node enters the scene tree for the first time.
func _ready():
	self.rotation = Vector3(0,0,0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	print(self.objs_in_front, self.objs_behind, self.objs_left, self.objs_right)
	#Still possible to glitch player between walls
	if Input.is_action_just_pressed("turn_left"):
		direction_facing += 1 # left turn
	if Input.is_action_just_pressed("turn_right"):
		direction_facing -= 1 # right turn
	
	if Input.is_action_just_pressed("walk") and self.objs_in_front == self.null_node and not self.is_rotating:
		if directions[direction_facing % 4] == "North":
			self.position += Vector3(0,0,-1)
		elif directions[direction_facing % 4] == "West":
			self.position += Vector3(-1,0,0)
		elif directions[direction_facing % 4] == "South":
			self.position += Vector3(0,0,1)
		elif directions[direction_facing % 4] == "East":
			self.position += Vector3(1,0,0)
	
	if Input.is_action_just_pressed("walk_back") and self.objs_behind == self.null_node and not self.is_rotating:
		if directions[direction_facing % 4] == "North":
			self.position += Vector3(0,0,1)
		elif directions[direction_facing % 4] == "West":
			self.position += Vector3(1,0,0)
		elif directions[direction_facing % 4] == "South":
			self.position += Vector3(0,0,-1)
		elif directions[direction_facing % 4] == "East":
			self.position += Vector3(-1,0,0)

	if Input.is_action_just_pressed("strafe_left") and self.objs_left == self.null_node and not self.is_rotating:
		if directions[direction_facing % 4] == "North":
			self.position += Vector3(-1,0,0)
		elif directions[direction_facing % 4] == "West":
			self.position += Vector3(0,0,1)
		elif directions[direction_facing % 4] == "South":
			self.position += Vector3(1,0,0)
		elif directions[direction_facing % 4] == "East":
			self.position += Vector3(0,0,-1)

	if Input.is_action_just_pressed("strafe_right") and self.objs_right == self.null_node and not self.is_rotating:
		if directions[direction_facing % 4] == "North":
			self.position += Vector3(1,0,0)
		elif directions[direction_facing % 4] == "West":
			self.position += Vector3(0,0,-1)
		elif directions[direction_facing % 4] == "South":
			self.position += Vector3(-1,0,0)
		elif directions[direction_facing % 4] == "East":
			self.position += Vector3(0,0,1)
	
	self.rotation.y = lerp_angle(self.rotation.y, rotations[direction_facing % 4], delta * 10)
	$UI/CompassFace.rotation = rotations[direction_facing % 4] # not working quite right.
	#-zero not equal to zero bug
	var normalized_rotation_y = 2*PI + self.rotation.y if self.rotation.y < 0 else self.rotation.y
		
	if Input.is_action_just_pressed("interact"):
		if self.objs_in_front.has_method("interact"):
			self.objs_in_front.interact(self)
		
	if Input.is_action_just_pressed("ui_accept") and self.mana > 0: #still a little weird
		#fire projectile
		if self.projectile_type == 'lightning':
			$LightningSound.play()
			pass
		else:
			$FireblastSound.play()
			pass
		var shot = preload("res://Attacks/shot.tscn").instantiate()
		shot.position = self.position
		shot.rotation = self.rotation
		shot.shooter = self
		shot.shooter_position = self.position
		shot.shot_type = 'multishot'
		get_tree().root.add_child(shot)
		self.mana -= 1 #need to balance
	if Input.is_action_just_pressed("ui_cancel"):
		if self.objs_in_front.has_method('interact'):
			self.objs_in_front.interact()

func attacked(direction):
	self.health -= 1

func _on_player_front_interaction_body_entered(body):
	self.objs_in_front = body
#	if body.has_method("interact"):
#		$UserInterface/popup.text = body.interact_mesg

func _on_player_front_interaction_body_exited(body):
	if body == self.objs_in_front:
		self.objs_in_front = self.null_node
#		$UserInterface/popup.text = ""

func _on_player_back_interaction_body_entered(body):
	self.objs_behind = body

func _on_player_back_interaction_body_exited(body):
	if body == self.objs_behind:
		self.objs_behind = self.null_node

func _on_player_left_interaction_body_entered(body):
	self.objs_left = body

func _on_player_left_interaction_body_exited(body):
	if body == self.objs_left:
		self.objs_left = self.null_node

func _on_player_right_interaction_body_entered(body):
	self.objs_right = body

func _on_player_right_interaction_body_exited(body):
	if body == self.objs_right:
		self.objs_right = self.null_node



