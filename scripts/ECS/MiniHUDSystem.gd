extends System
class_name SystemMiniHUD

const TEXTURE: Texture = preload("res://icon.svg")
const GOOD_COLOR := Color.GREEN
const BAD_COLOR := Color.RED

var sprite_3d_dict: Dictionary
var tracked_entity_ids: Array[int]
var loop_count: int = 100

func _tick():
	if loop_count > 10 and tracked_entity_ids.is_empty():
		track_entity(get_player_entity_id())
			
		
	for id: int in tracked_entity_ids:
		
		var sprite: Sprite3D = sprite_3d_dict.get(id, null)
		if sprite == null:
			push_error("Why is it null!?")
		
		## Set the position of the sprite
		var size_component: ComponentSize = Component.get_by_id(ComponentSize, id)
		var player_component: ComponentPlayer = Component.get_by_id(ComponentPlayer, id)
		var target_position: Vector3 = player_component.global_position + size_component.get_top()
		
		sprite.global_position = target_position
		
		## Set its color
		var health_component: ComponentHealth = Component.get_by_id(ComponentHealth, id)
		var percentage: float = health_component.get_health() / health_component.get_max_health()
		sprite.modulate = lerp(BAD_COLOR, GOOD_COLOR, percentage)
	
	loop_count += 1
		


func track_entity(id: int):
	if tracked_entity_ids.has(id):
		push_warning("Cannot track the same entity twice.")
		return 
		
	tracked_entity_ids.append(id)
	var new_sprite := Sprite3D.new()
	new_sprite.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	new_sprite.centered = true
	new_sprite.texture = TEXTURE
	sprite_3d_dict[id] = new_sprite
	add_child(new_sprite)
	
	
func untrack_entity(id: int):
	var sprite: Sprite3D = sprite_3d_dict.get(id, null)
	if is_instance_valid(sprite):
		sprite.queue_free()
		sprite_3d_dict.erase(id)
	
	tracked_entity_ids.erase(id)
	


func get_player_entity_id() -> int:
	for player_component: ComponentPlayer in Component.get_all(ComponentPlayer):
		if player_component.is_this_device():
			return player_component.get_id()
	
	return -1
	
	
	
