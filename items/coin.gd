
extends Area2D


# Member variables
var taken = false

func _ready():
	connect("body_enter", self, "_on_Area2D_body_enter")

func _on_Area2D_body_enter(body):
	if not taken and body extends preload("res://player/player.gd"):
		take_it()

func take_it():
	get_node("SamplePlayer2D").play("coin-collect")
	get_node("anim").play("taken")
	taken = true
