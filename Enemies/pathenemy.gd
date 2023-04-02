extends RigidBody3D
#need to rework as a body3

@export var target : Vector3
@export var start : Vector3

@onready var sprite : AnimatedSprite3D = get_node("Sprite3D")
@export var player : Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	self.position = self.start
	sprite.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	sprite.look_at(player.position, Vector3.UP)
	
	#print(self.position)
	var direction = (self.target - self.position).normalized() # get unit vector
	if self.target != self.position:
		self.position += direction * 0.05
	
	if is_equal_approx(self.target.x, self.position.x) and is_equal_approx(self.target.z, self.position.z):
		self.target = self.start
		self.start = self.position

func attacked(direction):
	queue_free()

func _on_area_3d_body_entered(body):
	print("hello")
	
