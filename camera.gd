extends Camera2D

var velocity = 10;
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_key_pressed(KEY_LEFT) && global_position.x > 500:
		global_position.x = global_position.x - velocity
	if Input.is_key_pressed(KEY_RIGHT) && global_position.x < 900:
		global_position.x = global_position.x + velocity
	pass
