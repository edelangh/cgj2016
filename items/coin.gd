
extends Area2D


# Member variables
var taken = false

func _ready():
	connect("body_enter", self, "_on_Area2D_body_enter")

func _on_Area2D_body_enter(body):
	if not taken and body extends preload("res://player/player.gd"):
		get_node("SamplePlayer2D").play("coin-collect")
		get_node("anim").play("taken")
		taken = true
		global.score_multiplier += 1
		global.score_multiplier_timer = global.SCORE_MULTIPLIER_DURATION
