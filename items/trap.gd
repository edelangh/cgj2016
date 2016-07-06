
extends Area2D

var taken = false

func _ready():
	connect("body_enter", self, "_on_Area2D_body_enter")

func _on_Area2D_body_enter(body):
	if not taken and body extends preload("res://player/player.gd"):
		print("DEATH!!")
		pass # TODO: game over
