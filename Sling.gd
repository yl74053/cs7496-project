extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var center_pos = $"Center".global_position


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


onready var traj_plot = $"Trajectory"
var gravity_vector : Vector2 = ProjectSettings.get_setting("physics/2d/default_gravity_vector")
var max_points = 250

enum IntegrationMethod { SIMPLE, MIDPOINT }

var method = IntegrationMethod.SIMPLE
var dt = 1
var damp = 1 - 0.01
# Numerical Integration :-)
func update_trajectory(pos, impulse):
	pos = pos - global_position
	traj_plot.clear_points()
	var vel = impulse
	for i in max_points:
		traj_plot.add_point(pos)
		if method == IntegrationMethod.SIMPLE:
			vel += gravity_vector * dt
			vel = vel * damp
			pos += vel * dt
		elif method == IntegrationMethod.MIDPOINT:
			var pos_0 = pos
			var vel_0 = vel
			var vel_mid = (vel_0 + gravity_vector * dt * 0.5) * damp
			vel += gravity_vector * dt
			vel = vel * damp
			pos += vel_mid * dt
		if pos.y > $"../Bg/Ground".position.y - 25:
			break
