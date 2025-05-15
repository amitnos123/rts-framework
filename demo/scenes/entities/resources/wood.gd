extends ResourceEntity
class_name Wood

func _ready() -> void:
	$Components/CollectableComponent.resource_type = resource_type
	add_to_group("resources")
