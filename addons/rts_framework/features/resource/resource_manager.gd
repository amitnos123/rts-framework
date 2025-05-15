extends BaseManager
class_name ResourceManager


var resources : Array[ResourceEntity] = []
var deposit_building : Array[ResourceDepositBuilding] = []

func _ready() -> void:
	sync_all_resource_entity()

func sync_all_resource_entity() -> void:
	if get_tree().has_group("resources"):
		var nodes_group = get_tree().get_nodes_in_group("resources")
		for re in nodes_group: # re - ResourceEntity
			if re is ResourceEntity:
				resources.append(re)
				re.tree_exiting.connect(resource_entity_deleted.bind(re))

func sync_all_resource_deposit_entity() -> void:
	if get_tree().has_group("resources_deposit"):
		var nodes_group = get_tree().get_nodes_in_group("resources_deposit")
		for rd in nodes_group: # rd - ResourceDepositEntity
			if rd is ResourceDepositBuilding:
				deposit_building.append(rd)
				rd.tree_exiting.connect(resource_entity_deleted.bind(rd))

func resource_entity_deleted(value : ResourceEntity) -> void:
	resources.erase(value)
