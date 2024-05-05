extends Component
class_name ComponentPlayer
## Used to define an entity as a player character

@export var client_owner_id: int

func is_this_device()->bool:
	return client_owner_id == 0


