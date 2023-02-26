extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
enum TILES {
	EMPTY = -1,
	DIRT = 0,
	GRASS = 1,
	GRASSY_DIRT = 2,
	DIRT_SURFACE = 3,
}

signal level_complete

export var remaining_unconverted = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var used_cells = get_used_cells()
	for cell in used_cells:
		if is_unconverted(map_to_world(cell)):
			remaining_unconverted += 1
			
		
	pass # Replace with function body.

func grow_tile(pos):
	var tile = world_to_map(pos)
	var tile_above = world_to_map(pos - Vector2(0, cell_size.y))
	
	if is_unconverted(pos):
		set_cellv(tile, TILES.GRASSY_DIRT)
		set_cellv(tile_above, TILES.GRASS)
		remaining_unconverted -= 1
		
		if remaining_unconverted == 0:
			emit_signal("level_complete")
		
func ungrow_tile(pos):
	var tile = world_to_map(pos)
	var tile_above = world_to_map(pos - Vector2(0, cell_size.y))
	
	if not is_unconverted(pos):
		set_cellv(tile, TILES.DIRT_SURFACE)
		set_cellv(tile_above, TILES.EMPTY)
		remaining_unconverted += 1
		
func is_unconverted(pos):
	var tile_pos = world_to_map(pos)
	return get_cellv(tile_pos) == TILES.DIRT_SURFACE and get_cellv(tile_pos - Vector2(0,1)) == TILES.EMPTY

func is_converted(pos):
	return get_cellv(world_to_map(pos)) == TILES.GRASSY_DIRT || get_cellv(world_to_map(pos)) == TILES.GRASS
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
