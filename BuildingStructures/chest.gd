extends StaticBody3D

@export var target : Node3D
var interact_mesg : String = "A Chest, Hopefully it has some potions" + \
"\nPress [Enter] to use the restore some health."
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Node3D.look_at(target.position)
	pass
	
func attacked(attacker):
	queue_free()

func interact(body):
	pass
	body.health += 25
	queue_free()
