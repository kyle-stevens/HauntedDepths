extends StaticBody3D

@export var health : int = 6

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func attacked(attacker):
	self.health -= 1
	if self.health <= 0:
		queue_free()
		# spawn explsion
