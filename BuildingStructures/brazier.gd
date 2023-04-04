extends StaticBody3D

@export var target : Node3D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Node3D.look_at(target.position)
	pass
	
func attacked(attacker):
	queue_free()
