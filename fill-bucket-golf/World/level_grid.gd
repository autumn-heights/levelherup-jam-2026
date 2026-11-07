extends TileMapLayer

const SCREEN_SIZE_PX = Vector2(544,544)
const CELL_WIDTH_PX = 16
const GRID_WIDTH_CELLS = 34
const  BOUNDARY_OFFSET = 1

const tilemap_size = Vector2i(32,32)

var loadedWorld : Array[ArtMap]
var border_coord = Vector2i(0,0)
var blank_coord = Vector2i(1,0)

func _ready() -> void:
	drawBoundary()
	ImageTexture

func drawBoundary() -> void:
	for x in tilemap_size.x:
		for y in tilemap_size.y:
			set_cell(Vector2i(x,y), 0, blank_coord)
	#for i in range(0, GRID_WIDTH_CELLS):
		#loadedWorld.append(ArtMap.new(Vector2i(i, 0), Vector2i(0,0), true, true))
		#loadedWorld.append(ArtMap.new(Vector2i(i, GRID_WIDTH_CELLS -1), Vector2i(0,0), true, true))
		#loadedWorld.append(ArtMap.new(Vector2i(0, i), Vector2i(0,0), true, true))
		#loadedWorld.append(ArtMap.new(Vector2i(GRID_WIDTH_CELLS -1, i), Vector2i(0,0), true, true))
	#for i in range(1, GRID_WIDTH_CELLS -1):
		#for j in range(1, GRID_WIDTH_CELLS -1):
			#loadedWorld.append(ArtMap.new(Vector2i(i,j), Vector2i(2,0)))
		
func _process(_delta: float) -> void:
	for art in loadedWorld:
		set_cell(art.Gridspace, 0, art.AssetCoordinate)
	
