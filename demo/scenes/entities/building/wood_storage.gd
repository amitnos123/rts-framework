extends ResourceDepositBuilding
class_name WoodStorage

var global_deposit_point : Vector3 :
	get:
		return $deposit_point.global_position
	set(value):
		return # Prevent setting

var deposit_point : Vector3 :
	get:
		return $deposit_point.position
	set(value):
		return # Prevent setting


@export var resource_type : CollectableComponent.ResourceType :
	get:
		return CollectableComponent.ResourceType.WOOD
	set(value):
		return # Prevent setting
		
@export_range(0, 1000, 1, "or_greater") var resource_amount : int :
	get:
		return $Components/CollectableComponent.resource_amount
	set(value):
		$Components/CollectableComponent.resource_amount = value
@export var is_collectable: bool = true

var collectable_component : BaseComponent = self.get_component("CollectableComponent")

func _ready() -> void:
	super()
	collectable_component = self.get_component("CollectableComponent")

# Reduces resource amount and returns the actual collected amount.
func collect(amount: int) -> int:
	return collectable_component.collect(amount)

# Completely depletes the resource.
func deplete() -> void:
	collectable_component.deplete()
