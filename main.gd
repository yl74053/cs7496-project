extends Node2D

onready var b_line = $"Sling/SBack/point/line"
onready var f_line = $"Sling/SFront/Point/line"

onready var b_line_point = $"Sling/SBack/point".global_position
onready var f_line_point = $"Sling/SFront/Point".global_position

onready var center_pos = $"Sling/Center".global_position

onready var scoreText = $"Camera2D/Score"

var score = 0;

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	scoreText.set_text("Score:" + str(score))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_line_points(pos : Vector2):
	var b_point = (pos - b_line_point) * 1.2
	var f_point = (pos - f_line_point) * 1.2
	b_line.set_point_position(1, b_point)
	f_line.set_point_position(1, f_point)
	pass

func reset_line_to_origin():
	set_line_points(center_pos)
	pass

func score():
	score = score + 10000
	scoreText.set_text("Score:" + str(score))
