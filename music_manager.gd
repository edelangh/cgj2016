extends StreamPlayer

func _init():
	pass

func _ready():
	set_stream(load("res://sound/music.ogg"))
	self.set_loop(true)
	self.play()
	pass
