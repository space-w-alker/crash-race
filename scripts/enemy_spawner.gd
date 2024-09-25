extends Node3D
class_name EnemySpawner

@export var scenes: Array[PackedScene] = []
var last_spawned = 0.0

func _process(_delta: float) -> void:
  if Time.get_ticks_msec() - last_spawned > 2 * 1000:
    _spawn_ememy()
    last_spawned = Time.get_ticks_msec()

func _spawn_ememy():
  var enemy = scenes[0].instantiate() as VehicleController
  enemy.car_config = CarConfig.new(1)
  var controller = AiInputController.new()
  controller.vehicle = enemy
  enemy.add_child(controller)
  add_child(enemy)
