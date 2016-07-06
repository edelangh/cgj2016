
extends StaticBody2D


# Member variables
var taken = false


func take_it():
	if not taken:
		get_node("anim").play("taken")
		taken = true
