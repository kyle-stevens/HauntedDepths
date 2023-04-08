extends StaticBody3D

var interact_mesg : String = "This Wall is missing some spots, I wonder if I could blow it apart?"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func attacked(attacker):
	queue_free()

func interact(body):
	pass
