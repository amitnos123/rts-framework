extends StateData
class_name MoveData
## Resource object for storing movement data
## Used when transitioning to the move state

var target_position : Variant

func _init() -> void:
	super()  # Call parent initializer
	# Will decide on target_position initialization later
