extends Area3D

var speed_multiplier : float = 1
var shooter : Node3D
var shooter_position : Vector3
var is_projectile : bool = true
var shot_type : String = "bolt"
var pass_through : int = 1
var damage : int = 1
var explodes : bool = false
var explosion_scale : int = 1
@export var power_level : int = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	if self.shot_type == "bolt":
		self.pass_through = 1
		self.damage = 1
		self.explodes = false
		self.explosion_scale = 1
		$Bolt.visible = true
		#no explosion
	elif self.shot_type == "exploding_bolt":
		self.pass_through = 1
		self.damage = 1
		self.explodes = true
		self.explosion_scale = 1
		$Multishot.visible = true
		#explosion
	elif self.shot_type == "fireball":
		self.pass_through = 1
		self.damage = 3
		self.explodes = true
		self.explosion_scale = 2
		$Fireball.visible = true
		#more damage larger explosion
	elif self.shot_type == "multishot":
		self.pass_through = 1
		self.damage = 3
		self.explodes = false
		self.explosion_scale = 1
		$Multishot.visible = true
		#fan shot
	elif self.shot_type == "lightning":
		self.pass_through = 3
		self.damage = 5
		self.explodes = true
		self.explosion_scale = 1
		$Lightning.visible = true
		#pass through
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	raycast.add_exception(body_to_ignore)
#	print(self.position)
	self.position += self.basis.z * (-0.1 * speed_multiplier)
#	print(self.position)
#	print(self.basis.z * (-0.1 * speed_multiplier))
	

#going to add multiple types of projectile here.
func _on_body_entered(body):
	if body != self.shooter:
		self.pass_through -= 1
		if self.pass_through <= 0:
			queue_free()
		if body.has_method('attacked'):
			body.attacked(damage * power_level)
		if self.explodes:
			var explosion = preload("res://Attacks/explosion.tscn").instantiate()
			explosion.scale = explosion.scale * self.explosion_scale
			explosion.emitting = true
			explosion.position = self.position
			explosion.rotation = self.basis.z
			explosion.shooter = self.shooter
			get_tree().root.add_child(explosion)
#		if body.type == Globals.EntityType.ENEMY:
#	#		print("Hit Enemy")
#			body.attacked("shot")
#			queue_free()
#		if body.type == Globals.EntityType.ARCHITECTURE:
#			if body.has_method("attacked"):
#				body.attacked("shot")
#			queue_free()
#		if body.type == Globals.EntityType.PLAYER:
#			body.attacked("shot")
#			queue_free()


#func _on_tree_exiting(): # stopped working in release candidate for some reason
#	print("exiting tree")
#	var explosion = preload("res://explosion.tscn").instantiate()
#	explosion.emitting = true
#	explosion.position = self.position
#	explosion.rotation = self.basis.z
#	get_tree().root.add_child(explosion)



