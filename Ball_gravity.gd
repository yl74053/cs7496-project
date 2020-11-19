extends RigidBody2D

class_name BallGravity
var pressed = -1
var boundary = 80
onready var center_pos = $"../Sling/Center".global_position
onready var attractor_pos = $"../Attractor".global_position
onready var main = $".."
var force = 10
onready var area = $"Area2D"

var timer = 500;
var destroy = 0;
# Declare member variables here. Examples:
# var a = 2
# var b = "text"



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var attraction_strength = 10000000

func _physics_process(delta):
	var v_attractor = attractor_pos - global_position
	var attract = (attraction_strength / v_attractor.length_squared()) * v_attractor.normalized() * delta
	apply_central_impulse(attract)
	# print(attract)
	if  area.get_overlapping_bodies().size() > 1:
		destroy = 1;
	
	if destroy == 1:
		timer = timer - 1;
	
	if timer <= 0:
		queue_free()

func _integrate_forces(state):
	var raw = state.get_space_state()
	
	pass

func _input(event):
	if event is InputEventMouse && pressed == 1:
		global_position = event.position 
		
		var dis_to_center = global_position - center_pos
		if dis_to_center.length() > boundary :
			global_position = dis_to_center.normalized() * (boundary) + center_pos
		
		on_drag()
	if event is InputEventMouseButton && !event.is_pressed() && pressed == 1:
		pressed = -1
		shoot()


func _on_Chrome_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton && event.is_pressed():
		pressed = 1
	if event is InputEventMouseButton && !event.is_pressed():
		pressed = -1
	pass # Replace with function body.

func on_drag():
	var dis = center_pos - global_position
	var pulse = dis.normalized() * dis.length() * force
	$"../Sling".update_trajectory(global_position, pulse / self.weight)
	main.set_line_points(global_position)

func shoot():
	main.reset_line_to_origin()
	var dis = center_pos - global_position
	var pulse = dis.normalized() * dis.length() * force
	mode = RigidBody2D.MODE_RIGID
	apply_impulse(dis, pulse)

