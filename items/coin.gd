extends Area2D

# Member variables
var taken = false
var audioPlayer = null
export(String) var sound = "coin-collect"
export(int)    var score = 1

func _ready():
	audioPlayer = get_node("audioPlayer")
	connect("body_enter", self, "_on_Area2D_body_enter")

func _on_Area2D_body_enter(body):
	if not taken and body extends preload("res://player/player.gd"):
		audioPlayer.play(sound)
		get_node("anim").play("taken")
		taken = true
		global.score_multiplier += score
		global.score_multiplier_timer = global.SCORE_MULTIPLIER_DURATION
