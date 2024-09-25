class_name VehicleController
extends VehicleBody3D


var target_engine_force = 0
var weight = 5

var steer: float = 0;

var brake_target: float = 0;
var last_balance_time: float = 0
var last_angular_velocity: Vector3 = Vector3.ZERO;

@export var car_config: CarConfig

@onready var floorRay: RayCast3D = $detect_floor
@onready var wallRay: RayCast3D = $detect_wall

# Define an enum with the required values
enum DriveMode { THROTTLE, BRAKE, NEUTRAL, REVERSE }

func _init(_car_config: CarConfig = null) -> void:
	car_config = _car_config


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
	target_engine_force = 120 if car_config == null else 120 * car_config.mass_multiplier
	weight = 5
func neutral():
	brake_target = 0
	target_engine_force = 0
	weight = 1
func apply_break():
	brake_target = 4 if car_config == null else 4 * car_config.mass_multiplier
	target_engine_force = 0
	engine_force = 0
	weight = 10
func reverse():
	brake_target = 0
	target_engine_force = -120 if car_config == null else -120 * car_config.mass_multiplier
	weight = 5
func set_steer(value: float):
	steer = value

func _ready() -> void:
	add_to_group("cars")
	if car_config != null:
		mass = car_config.mass_multiplier * mass
	pass


func _physics_process(delta: float) -> void:
	last_angular_velocity = angular_velocity;
	if (angular_velocity.length_squared() > 2 and Time.get_ticks_msec() - last_balance_time > 1000):
		pass
		# print("Too much: ", angular_velocity.length_squared(), "Applying force")
	engine_force = lerpf(engine_force, target_engine_force, weight * delta)
	steering = lerpf(steering, steer * 0.3, 30 * delta)
	brake = lerpf(brake, brake_target, 30 * delta)
