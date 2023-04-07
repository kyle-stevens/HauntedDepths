extends RigidBody3D
#need to rework as a body3

@export var target : Vector3
@export var start : Vector3

@onready var sprite : AnimatedSprite3D = get_node("Sprite3D")
@export var player : Node3D
@export var damage : int = 5
@export var power_level : int = 1
@export var health : int = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	self.position = self.start
	sprite.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.health <= 0:
		queue_free()
	sprite.look_at(player.position, Vector3.UP)
	
	#print(self.position)
	var direction = (self.target - self.position).normalized() # get unit vector
	if self.target != self.position:
		self.position += direction * 0.05
	
	if is_equal_approx(self.target.x, self.position.x) and is_equal_approx(self.target.z, self.position.z):
		self.target = self.start
		self.start = self.position

func attacked(direction):
	self.health -= direction

func _on_area_3d_body_entered(body):
	if body.has_method('attacked'):
		body.attacked(damage * power_level)
	
