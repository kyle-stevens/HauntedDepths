extends RigidBody3D
#need to rework as a body3d


@export var target_body : PhysicsBody3D
@onready var sprite : Sprite3D = get_node("Sprite3D")
@export var range : int = 3
@export var projectile_type : String = ""
@export var power_level : int = 1
@export var health : int = 5
# Called when the node enters the scene tree for the first time.
func _ready():
	$Range.scale = Vector3(self.range, self.range, self.range) #will be a circular sprite


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.health <= 0:
		queue_free()
	sprite.look_at(self.target_body.position, Vector3.UP)
	
#	$PassiveSound.play()
	self.rotation.y = $Sprite3D.global_rotation.y

func attacked(direction):
	self.health -= direction
	pass

func _on_timer_timeout():
	#fire projectile
	if (self.target_body.position).distance_to(self.position) < self.range:
		var shot = preload("res://Attacks/shot.tscn").instantiate()
		var spawnPoint : Node3D = get_node("EnemyTurret")
		shot.position = self.position
		shot.speed_multiplier = .25
		shot.shooter = self
		shot.shooter_position = self.position
		shot.shot_type = self.projectile_type
		shot.rotation = self.rotation
		shot.power_level = self.power_level
		get_tree().root.add_child(shot)
		$FireblastSound.play()
