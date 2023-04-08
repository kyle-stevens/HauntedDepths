extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_3d_body_entered(body):
	if "escaped" in body:
		$Layer1.queue_free()
		$Layer2.queue_free()
		$Layer3/Enemies.queue_free()
		$Layer3/Items.queue_free()
