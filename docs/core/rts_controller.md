# RTSController

The `RTSController` is the central orchestrator of the RTS game systems. It connects and manages subsystems like `SelectionManager` and `CommandManager`. The controller listens to events from these systems and may propagate high-level events for further game logic processing. It does not contain direct logic but acts as a mediator between components.

## **Class**

- **Base node/class**: `Node`
- **Class name**: `RTSController`

## **Methods**

- `connect_events() -> void`: Connects events from `SelectionManager`, `CommandManager`, and other subsystems to local handlers.
- `_on_units_selected(units: Array) -> void`: Handles the `units_selected` event from `SelectionManager`.
- `_on_command_issued(command: String, units: Array, target: Variant, context: Dictionary) -> void`: Handles the `command_issued` event from `CommandManager`.
- `focus_camera_on_units(units: Array) -> void`: Calculates the average position of selected units and emits a signal to focus the camera on this position.

## **Properties**

- `@onready var selection_manager: SelectionManager`: Reference to the `SelectionManager` subsystem for handling unit selection.
- `@onready var command_manager: CommandManager`: Reference to the `CommandManager` subsystem for issuing commands.

## Signals

- `units_selected(units: Array)`: Propagates the `units_selected` event received from `SelectionManager`.
- `command_issued(command: String, units: Array, target: Variant, context: Dictionary)`: Propagates the `command_issued` event received from `CommandManager`.
- `focus_on_position(position: Vector3)`: Emitted when the game requests the camera to focus on a specific position.

## **Dependencies**

- **SelectionManager**: Handles unit selection.
- **CommandManager**: Issues commands to selected units.

## Code

[Source code](../../addons/rts_framework/core/rts_controller.gd)

## Example

```gdscript
extends RTSController

func _ready() -> void:
	connect_events()

func connect_events() -> void:
	selection_manager.units_selected.connect("_on_units_selected")
	command_manager.command_issued.connect("_on_command_issued")

func _on_units_selected(units: Array) -> void:
	print("RTSController: Units selected:", units)
	focus_camera_on_units(units)

func _on_command_issued(command: String, units: Array, target: Variant, context: Dictionary) -> void:
	print("RTSController: Command issued:", command, context)
	emit_signal("command_issued", command, units, target, context)

func focus_camera_on_units(units: Array) -> void:
	if units.size() > 0:
		var avg_position = Vector3.ZERO
		for unit in units:
			avg_position += unit.global_transform.origin
		avg_position /= units.size()
		emit_signal("focus_on_position", avg_position)
```