extends VehicleBody3D


@export var STEER_SPEED = 1.5
@export var STEER_LIMIT = 0.6
var steer_target = 0
@export var engine_force_value = 100


func _physics_process(delta):

	var fwd_mps = transform.basis.x.x
	steer_target = Input.get_action_strength("ui_left") - Input.get_action_strength("ui_right")
	steer_target *= STEER_LIMIT
	if Input.is_action_pressed("ui_down"):
		engine_force = -engine_force_value
	else:
		engine_force = 0
	if Input.is_action_pressed("ui_up"):
		# Increase engine force at low speeds to make the initial acceleration faster.
		if fwd_mps >= -1:
			engine_force = engine_force_value
		else:
			brake = 1
	else:
		brake = 0.0

	if Input.is_action_pressed("ui_select"):
		brake=5
		pass
	else:
		pass
	brake = 10
	steering = move_toward(steering, steer_target, STEER_SPEED * delta)
