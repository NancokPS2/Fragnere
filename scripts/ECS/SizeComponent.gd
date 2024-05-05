extends Component
class_name ComponentSize

@export var dimensions: Vector3

func get_top() -> Vector3:
	return Vector3(dimensions.x/2, dimensions.y, dimensions.z/2)
