extends Resource
class_name CarConfig

@export var mass_multiplier: int
@export var control_type: Global.ControlType

func _init(mass_mul = 1, _control_type = Global.ControlType.COM):
	mass_multiplier = mass_mul;
	control_type = _control_type;
