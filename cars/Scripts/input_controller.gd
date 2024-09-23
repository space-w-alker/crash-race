class_name UserInputController
extends Node

@export var vehicle: VehicleController

func _physics_process(_delta: float) -> void:
	var input_x = Input.get_action_strength("ui_left") - Input.get_action_strength("ui_right")
	var input_y = Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")
	var br = Input.is_action_pressed("ui_accept")
	if vehicle == null:
		return
	if (br):
		vehicle.drive_mode = VehicleController.DriveMode.BRAKE
	elif (input_y > 0):
		vehicle.drive_mode = VehicleController.DriveMode.THROTTLE
	elif (input_y == 0):
		vehicle.drive_mode = VehicleController.DriveMode.NEUTRAL
	elif (input_y < 0):
		vehicle.drive_mode = VehicleController.DriveMode.REVERSE
	vehicle.set_steer(input_x)
