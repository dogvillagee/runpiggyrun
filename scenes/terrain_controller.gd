extends Node3D
class_name TerrainController

var TerrainBlocks: Array = []
var terrain_belt: Array[Node3D] = []

@export var terrain_velocity: float = 10.0
@export var num_terrain_blocks: int = 8
@export_dir var terrian_blocks_path: String = "res://scenes/terrain_blocks"

func _ready() -> void:
	_load_terrain_scenes(terrian_blocks_path)
	if TerrainBlocks.is_empty():
		push_error("No terrain blocks loaded! Check directory or file structure.")
		return
	_init_blocks(num_terrain_blocks)

func _physics_process(delta: float) -> void:
	_progress_terrain(delta)

func _init_blocks(number_of_blocks: int) -> void:
	for block_index in range(number_of_blocks):
		var block = TerrainBlocks.pick_random().instantiate()
		var mesh_size_z = _get_block_length(block)

		if block_index == 0:
			block.position.z = mesh_size_z / 2
		else:
			_append_to_far_edge(terrain_belt[block_index - 1], block)

		add_child(block)
		terrain_belt.append(block)

func _progress_terrain(delta: float) -> void:
	for block in terrain_belt:
		block.position.z -= terrain_velocity * delta  # Move backward

	if terrain_belt.size() == 0:
		return

	var first_block = terrain_belt[0]
	var mesh_size_z = _get_block_length(first_block)

	# Recycle the block if it's far behind
	if first_block.position.z <= -mesh_size_z:
		var last_terrain = terrain_belt[-1]
		var first_terrain = terrain_belt.pop_front()

		var new_block = TerrainBlocks.pick_random().instantiate()
		_append_to_far_edge(last_terrain, new_block)
		add_child(new_block)
		terrain_belt.append(new_block)
		first_terrain.queue_free()

func _append_to_far_edge(target_block: Node3D, appending_block: Node3D) -> void:
	var target_size = _get_block_length(target_block)
	var append_size = _get_block_length(appending_block)

	# Place the new block ahead in the +Z direction
	appending_block.position.z = target_block.position.z + target_size / 2 + append_size / 2

func _get_block_length(block: Node3D) -> float:
	var mesh_node = block.get_node_or_null("MeshInstance3D") as MeshInstance3D
	if mesh_node and mesh_node.mesh:
		return mesh_node.mesh.get_aabb().size.z
	push_warning("MeshInstance3D or its mesh missing in: " + str(block))
	return 4.0  # Fallback length

func _load_terrain_scenes(target_path: String) -> void:
	var dir = DirAccess.open(target_path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".tscn"):
				var scene = load(target_path + "/" + file_name)
				if scene:
					TerrainBlocks.append(scene)
			file_name = dir.get_next()
		dir.list_dir_end()
	else:
		push_error("Could not open terrain_blocks directory: " + target_path)
