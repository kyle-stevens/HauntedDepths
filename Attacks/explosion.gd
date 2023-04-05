extends CPUParticles3D

var shooter : Node3D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	print("explosion")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.emitting == false:
		queue_free()


func _on_damage_body_entered(body):
	if body.has_method("attacked") and body != self.shooter:
		body.attacked("boom")
