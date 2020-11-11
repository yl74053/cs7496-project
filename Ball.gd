extends RigidBody2D

class_name Ball
var pressed = -1
var boundary = 80
onready var center_pos = $"../Sling/Center".global_position
onready var main = $".."
var force = 10
onready var area = $"Area2D"

var timer = 50;
var destory = 0;
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if  area.get_overlapping_bodies().size() > 1:
		destory = 1;
	
	if destory == 1:
		timer = timer - 1;
	
	if timer <= 0:
		queue_free()


func _input(event):
	if pressed == 1:
		global_position = event.position 
		
		var dis_to_center = global_position - center_pos
		if dis_to_center.length() > boundary :
			global_position = dis_to_center.normalized() * (boundary) + center_pos
		
		on_drag()
	if event is InputEventMouseButton && !event.is_pressed():
		pressed = -1
		shoot()


func _on_Chrome_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton && event.is_pressed():
		pressed = 1
	if event is InputEventMouseButton && !event.is_pressed():
		pressed = -1
	pass # Replace with function body.
	
		

func on_drag():
	main.set_line_points(global_position)

func shoot():
	main.reset_line_to_origin()
	var dis = center_pos - global_position
	var pulse = dis.normalized() * dis.length() * force
	mode = RigidBody2D.MODE_RIGID
	apply_impulse(dis, pulse)

