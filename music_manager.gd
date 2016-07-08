extends StreamPlayer

func _init():
	pass

func _ready():
	set_volume(0.3)
	set_stream(load("res://sound/music.ogg"))
	self.set_loop(true)
	self.play()
	pass
