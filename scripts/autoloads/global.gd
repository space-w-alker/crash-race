extends Node

enum ControlType { PLAYER, COM }

signal player_created(player: VehicleController)
signal ai_created(ai: VehicleController)

func _ready() -> void:
  player_created.connect(_player_created_handler)
  ai_created.connect(_ai_created_handler)

func _player_created_handler(player: VehicleController):
  var cam = CarCameraFollow.new()
  cam.player_node = player
  cam.make_current()
  get_tree().current_scene.add_child(cam)

func _ai_created_handler():
  pass