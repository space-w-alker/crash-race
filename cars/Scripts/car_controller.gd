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

func _init(_car_config: CarConfig = null) -> void:
	car_config = _car_config

func move(by: float) -> void:
	if by > 0:
		if linear_velocity.length_squared() > 1 and basis.z.dot(linear_velocity) < 0:
			_apply_brake()
		else:
			_throttle()
	elif by < 0:
		if linear_velocity.length_squared() > 1 and basis.z.dot(linear_velocity) > 0:
			_apply_brake()
		else:
			_reverse()
	else:
		_neutral()


func set_steer(value: float):
	steer = value

func _throttle():
	brake_target = 0
	target_engine_force = 120 if car_config == null else 120 * car_config.mass_multiplier
	weight = 5
func _neutral():
	brake_target = 0
	target_engine_force = 0
	weight = 1
func _apply_brake():
	brake_target = 4 if car_config == null else 4 * car_config.mass_multiplier
	target_engine_force = 0
	engine_force = 0
	weight = 10
func _reverse():
	brake_target = 0
	target_engine_force = -120 if car_config == null else -120 * car_config.mass_multiplier
	weight = 5

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
