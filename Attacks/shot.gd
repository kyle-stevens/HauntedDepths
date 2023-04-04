extends Area3D

var speed_multiplier : float = 1
var shooter : Node3D
var shooter_position : Vector3
var is_projectile : bool = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	raycast.add_exception(body_to_ignore)
	print(self.position)
	self.position += self.basis.z * (-0.1 * speed_multiplier)
	print(self.position)
	print(self.basis.z * (-0.1 * speed_multiplier))
	$CollisionShape3D/AnimatedSprite3D.look_at(shooter_position) # bullets will hit each other and crash, fix this.
	$CollisionShape3D/AnimatedSprite3D.play("default")
	

func _on_body_entered(body):
	if body != self.shooter:
		queue_free()
		if body.has_method('attacked'):
			body.attacked('shot')
		var explosion = preload("res://Attacks/explosion.tscn").instantiate()
		explosion.emitting = true
		explosion.position = self.position
		explosion.rotation = self.basis.z
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



