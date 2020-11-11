extends RigidBody2D

onready var area = $"Area"
onready var main = $".."

var pos = 0;
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pos = global_position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# print(area.get_overlapping_bodies())
	if pos.y < 500 && global_position.y > 500 && area.get_overlapping_bodies().size() > 1:
		queue_free()
		main.score()
	if area.get_overlapping_bodies().size() > 2:
		queue_free()
		main.score()
	pass
