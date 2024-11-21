extends CharacterBody3D

@onready var head = $Head
const speed = 10
const jump_velocity = 4.5
var mouse_sens = 0.1
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(-deg_to_rad(event.relative.x) * mouse_sens) # dont really need deg to rad, can just make smaller
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sens))

func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	velocity = Vector3(direction.x * speed, velocity.y, direction.z * speed)
	move_and_slide()
