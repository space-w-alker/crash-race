class_name UserInputController
extends Node

@export var vehicle: VehicleController

func _init(v: VehicleController = null) -> void:
	vehicle = v;

func _physics_process(_delta: float) -> void:
	var input_x = Input.get_action_strength("ui_left") - Input.get_action_strength("ui_right")
	var input_y = Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")
	if vehicle == null:
		return
	vehicle.move(input_y)
	vehicle.set_steer(input_x)
