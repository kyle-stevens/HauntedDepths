extends StaticBody3D


# Called when the node enters the scene tree for the first time.
var interact_mesg : String = "An Old Stone Door." + \
"\nPress [Enter] to open the door."
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func interact(body):
	pass
	queue_free()
	print('open')
	#fade away
