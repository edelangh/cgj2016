extends Area2D


var taken = false
var audioPlayer = null
export(String) var sound = "coin-collect"
export(int)    var score_multiplier = 1


func _ready():
	audioPlayer = get_node("audioPlayer")
	connect("body_enter", self, "_on_Area2D_body_enter")


func _on_Area2D_body_enter(body):
	if not taken and body extends preload("res://player/player.gd"):
		audioPlayer.play(sound)
		get_node("anim").play("taken")
		taken = true
		global.score_multiplier += score_multiplier
		global.score_multiplier_timer = global.SCORE_MULTIPLIER_DURATION
