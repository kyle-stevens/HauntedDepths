extends StaticBody3D

@export var target : Node3D
var interact_mesg : String = "A Power Orb, Wizards used these to transfer" + \
" powers and skills to their apprentices, but power comes at a cost. I wonder what will happen if I use it?" + \
"\nPress [Enter] to use the power orb."
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
	print(body.projectile_type)
	if body.power_level < 5:
		body.power_level += 1
	queue_free()
