extends CharacterBody3D

# Car parameters
var max_speed = 10.0
var acceleration = 5.0
var braking_force = 10.0
var steering_sensitivity = 0.1

# Steering and throttle inputs
var steering = 0.0
var throttle = 0.0

func _ready() -> void:
	velocity = Vector3.DOWN * 0.5

func _physics_process(delta):
	steering = Input.get_axis("ui_left", "ui_right")
	rotate(Vector3.UP, steering * delta)
	velocity = (basis.z) + Vector3.DOWN
	# Move the character body
	move_and_slide()
