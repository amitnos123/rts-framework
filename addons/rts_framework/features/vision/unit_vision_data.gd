extends Resource
class_name UnitVisionData

var unit : BaseEntity = null
var fow_circle : Node2D = null
var shroud_circle : Node2D = null
var minimap_circle : Node2D = null
var shape_3d : CollisionShape3D = null


# fow_circle
var fow_circle_radius : float :
	get:
		if fow_circle == null:
			return 0
		return fow_circle.radius
	set(value):
		if fow_circle == null:
			return
		fow_circle.radius = value
		emit_changed()

var fow_circle_color : Color :
	get:
		return fow_circle.color
	set(value):
		fow_circle.color = value
		emit_changed()

# shroud_circle
var shroud_circle_radius : float :
	get:
		if shroud_circle == null:
			return 0
		return shroud_circle.radius
	set(value):
		if shroud_circle == null:
			return
		shroud_circle.radius = value
		emit_changed()

var shroud_circle_color : Color :
	get:
		return shroud_circle.color
	set(value):
		shroud_circle.color = value
		emit_changed()

# minimap_circle
var minimap_circle_radius : float :
	get:
		if minimap_circle == null:
			return 0
		return minimap_circle.radius
	set(value):
		if minimap_circle == null:
			return
		minimap_circle.radius = value
		emit_changed()

var minimap_circle_color : Color :
	get:
		return minimap_circle.color
	set(value):
		minimap_circle.color = value
		emit_changed()

# shape_3d
var sight_range : float :
	get:
		if shape_3d == null || shape_3d.shape == null:
			return 0
		return shape_3d.shape.radius
	set(value):
		if shape_3d == null || shape_3d.shape == null:
			return
		shape_3d.shape.radius = value
		emit_changed()

# All
var position : Vector3 :
	get:
		if shape_3d == null:
			return Vector3.INF
		return shape_3d.position
	set(value): # Prevent setting
		return

static func create(unit, fow_circle, shroud_circle, shape_3d) -> UnitVisionData:
	var instance = UnitVisionData.new()
	instance.unit = unit
	instance.fow_circle = fow_circle
	instance.shroud_circle = shroud_circle
	instance.shape_3d = shape_3d
	return instance

# TODO: Talk about having a RefCounted in the unit itself and
# in vision manager have weakref.
# That way, when unit is freed, it will automateclly free this resource 
func _notification(what):
	if what == NOTIFICATION_PREDELETE:
		if fow_circle:
			fow_circle.queue_free()
		if shroud_circle:
			shroud_circle.queue_free()
		if minimap_circle:
			minimap_circle.queue_free()
		if shape_3d:
			shape_3d.queue_free()

func sync_position(texture_units_per_world_unit : int) -> void:
	var unit_pos_3d = unit.global_transform.origin
	var unit_pos_2d = Vector2(unit_pos_3d.x, unit_pos_3d.z) * texture_units_per_world_unit
	var changed_flag = false
	if fow_circle:
		fow_circle.position = unit_pos_2d
		changed_flag = true
	if shroud_circle:
		shroud_circle.position = unit_pos_2d
		changed_flag = true
	if minimap_circle:
		minimap_circle.position = unit_pos_2d
		changed_flag = true
	if shape_3d:
		shape_3d.position = unit_pos_3d
		changed_flag = true
	if changed_flag:
		emit_changed()
