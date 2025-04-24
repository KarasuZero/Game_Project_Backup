extends CharacterBody2D

@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D

var movement_speed = 25.0

func _input(event):
	if event.is_action_pressed("Click_To_Move"):
		var mouse_position = get_global_mouse_position()
		
		# get navi map from agent
		var nav_map = navigation_agent_2d.get_navigation_map()
		
		#get closest point valid for naigation
		var closest_point = NavigationServer2D.map_get_closest_point(nav_map,mouse_position)
		
		if closest_point != null:
			navigation_agent_2d.target_position = closest_point
			print("input is working")


func _physics_process(delta: float) -> void:

	
	var current_agent_position = global_position
	var next_path_position = navigation_agent_2d.get_next_path_position()
	var new_velocity = current_agent_position.direction_to(next_path_position) * movement_speed
	
	# navigation has ended
	if navigation_agent_2d.is_navigation_finished():
		return
	
	if navigation_agent_2d.avoidance_enabled:
		navigation_agent_2d.set_velocity(new_velocity)
	else:
		_on_navigation_agent_2d_velocity_computed(new_velocity)
	
	move_and_slide()

func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity
