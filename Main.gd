extends Node

export (PackedScene) var Mob
var score

func _ready():
    randomize()

func game_over():
	get_node("ScoreTimer").stop()
	get_node("MobTimer").stop()
	get_node("HUD").show_game_over()

func new_game():
	score = 0
	get_node("Player").start(get_node("StartPosition").get_pos())
	get_node("StartTimer").start()
	get_node("HUD").update_score(score)
	get_node("HUD").show_message("Get Ready")

func _on_StartTimer_timeout():
	get_node("MobTimer").start()
	get_node("ScoreTimer").start()

func _on_ScoreTimer_timeout():
	score += 1
	get_node("HUD").update_score(score)

func _on_MobTimer_timeout():
	# choose a random location on the Path2D
	get_node_and_resource("MobPath/MobSpawnLocation")
    # create a Mob instance and add it to the scene
	var mob = Mob.instance()
	add_child(mob)   
# set the mob's direction perpendicular to the path direction
	#var direction = get_node_and_resource("MobPath/MobSpawnLocation").set_rotation (PI/2)
    # set the mob's position to the random location
	#mob.position = get_node_and_resource("MobPath/MobSpawnLocation")
    # add some randomness to the direction
	#direction += rand_range(-PI/4, PI/4)
	#mob.rotation = direction
    # choose the velocity
	mob.set_linear_velocity(Vector2(rand_range(mob.MIN_SPEED, mob.MAX_SPEED), 0))