extends State

class_name EnemyIdle

@export var enemy: CharacterBody2D
@export var move_speed = 10
@export var aggro_range = 200

var player : CharacterBody2D

var move_direction : Vector2
var wander_time : float

func randomize_wander():
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wander_time = randf_range(1, 3)
	
func enter():
	player = get_tree().get_first_node_in_group("Player")
	randomize_wander()
	
func update(delta):
	if wander_time > 0:
		wander_time -= delta
	else:
		randomize_wander()
		
func physics_update(delta):
	if enemy:
		enemy.velocity = move_direction * move_speed
	
	var direction = player.global_position - enemy.global_position
	if enemy.is_player_spotted:
		transitioned.emit(self, "follow")