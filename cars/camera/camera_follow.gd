extends Camera3D

class_name CarCameraFollow

## The target node that the camera will look towards and rotate around.
@export var player_node: Node3D

@export var camera_follow: Node3D

## The speed in which the camera will adjust (lerp), when orbiting around the target.
var adjustment_speed = 8

func _ready() -> void:
	camera_follow = player_node.get_node("camera_follow")

func _physics_process(delta):
	if player_node and camera_follow:
		camera_follow.look_at(player_node.global_transform.origin + (Vector3.UP * 5), Vector3.UP)
		global_transform.basis = global_transform.basis.slerp(camera_follow.global_transform.basis, delta * adjustment_speed)
		global_transform.origin = global_transform.origin.lerp(camera_follow.global_transform.origin, clampf(delta * adjustment_speed, 0.0, 1.0))
