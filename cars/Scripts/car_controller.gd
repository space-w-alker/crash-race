class_name VehicleController
extends VehicleBody3D

var target_engine_force = 0
var weight = 5

var steer: float = 0;

var brake_target: float = 0;

@onready var floorRay: RayCast3D = $detect_floor
@onready var wallRay: RayCast3D = $detect_wall

# Define an enum with the required values
enum DriveMode { THROTTLE, BRAKE, NEUTRAL, REVERSE }

@export var drive_mode: DriveMode = DriveMode.NEUTRAL:
	set(value):
		if value != drive_mode:
			drive_mode = value
			if drive_mode == DriveMode.NEUTRAL:
				neutral()
			elif drive_mode == DriveMode.THROTTLE:
				throttle()
			elif drive_mode == DriveMode.BRAKE:
				apply_break()
			elif drive_mode == DriveMode.REVERSE:
				reverse()
	get:
		return drive_mode
		
func throttle():
	brake_target = 0
	target_engine_force = 120
	weight = 5
func neutral():
	brake_target = 0
	target_engine_force = 0
	weight = 1
func apply_break():
	brake_target = 4
	target_engine_force = 0
	engine_force = 0
	weight = 10
func reverse():
	brake_target = 0
	target_engine_force = -80
	weight = 5
func set_steer(value: float):
	steer = value

func _physics_process(delta: float) -> void:
	engine_force = lerpf(engine_force, target_engine_force, weight * delta)
	steering = lerpf(steering, steer * 0.3, 30 * delta)
	brake = lerpf(brake, brake_target, 30 * delta)
