class_name AiInputController
extends Node
enum Machine {MOVING, BRAKING, REVERSE_TURNING,}

var state: Machine = Machine.MOVING

var enter_scene_time: float = .0
var reverse_start_time: float = .0

@export var vehicle: VehicleController

func _init(v: VehicleController = null) -> void:
	vehicle = v;

func _ready() -> void:
	enter_scene_time = Time.get_ticks_msec();

func _physics_process(_delta: float) -> void:
	if (Time.get_ticks_msec() - enter_scene_time < 2000):
		return
	process_state_transition()
	process_current_state()
	pass

func process_state_transition():
	if state == Machine.MOVING:
		if vehicle.wallRay.is_colliding() or not vehicle.floorRay.is_colliding():
			state = Machine.BRAKING
			print("braking")
		return
	if state == Machine.BRAKING:
		if vehicle.linear_velocity.length_squared() < .1:
			state = Machine.REVERSE_TURNING;
			reverse_start_time = Time.get_ticks_msec()
			print("reversing")
		return
	if state == Machine.REVERSE_TURNING:
		if Time.get_ticks_msec() - reverse_start_time > 1.5 * 1000:
			state = Machine.MOVING;
			print("moving")
		return

func process_current_state():
	if (state == Machine.MOVING):
		vehicle.move(1)
		vehicle.set_steer(0)
	elif (state == Machine.BRAKING):
		vehicle.move(-1)
		vehicle.set_steer(0)
	elif (state == Machine.REVERSE_TURNING):
		vehicle.move(-1)
		vehicle.set_steer(1)
