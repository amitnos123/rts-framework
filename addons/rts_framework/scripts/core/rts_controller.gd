@tool
extends Node
class_name RTSController

@export var team: int = 0:
	set(value):
		if value < 0:
			push_error("Team ID cannot be negative")
			return
		team = value

@export var selection_manager: SelectionManager:
	set(value):
		selection_manager = value
		update_configuration_warnings()

@export var command_manager: CommandManager:
	set(value):
		command_manager = value
		update_configuration_warnings()

func _get_configuration_warnings() -> PackedStringArray:
	var warnings = []
	if not selection_manager:
		warnings.append("The node 'SelectionManager' is missing. Add it to the scene and link it to the RTSController.")
	if not command_manager:
		warnings.append("The node 'CommandManager' is missing. Add it to the scene and link it to the RTSController.")
	return warnings

func _ready() -> void:
	if selection_manager:
		selection_manager.units_selected.connect(_on_units_selected)
	if command_manager:
		command_manager.command_issued.connect(_on_command_issued)

func _on_units_selected(units: Array) -> void:
	print_debug("Units selected: ", units)

func _on_command_issued(command: String, target: Variant, context: Dictionary) -> void:
	print_debug("Command issued: %s targeting: %s with context: %s" % [command, target, context])
