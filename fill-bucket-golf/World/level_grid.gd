extends TileMapLayer

const SCREEN_SIZE_PX = Vector2(544,544)
const CELL_WIDTH_PX = 16
const GRID_WIDTH_CELLS = 34
const  BOUNDARY_OFFSET = 1

var regionCounter = 0
var loadedWorld : Array[ArtMap]

func _ready() -> void:
	drawBoundary()

func drawBoundary() -> void:
	for i in range(0, GRID_WIDTH_CELLS):
		loadedWorld.append(ArtMap.new(Vector2i(i, 0), Vector2i(0,0), 0, true, true))
		loadedWorld.append(ArtMap.new(Vector2i(i, GRID_WIDTH_CELLS -1), Vector2i(0,0), 0, true, true))
		loadedWorld.append(ArtMap.new(Vector2i(0, i), Vector2i(0,0), 0, true, true))
		loadedWorld.append(ArtMap.new(Vector2i(GRID_WIDTH_CELLS -1, i), Vector2i(0,0), 0, true, true))
	for i in range(1, GRID_WIDTH_CELLS -1):
		for j in range(1, GRID_WIDTH_CELLS -1):
			loadedWorld.append(ArtMap.new(Vector2i(i,j), Vector2i(1,0), 0))


		
func _process(delta: float) -> void:
	for art in loadedWorld:
		set_cell(art.Gridspace, 0, art.AssetCoordinate)

func AddRegion(regionCells: Array[Vector2i]) -> int:
	regionCounter += 1
	for cell in regionCells:
		var x = GetCell(cell.x, cell.y)
		x.Region = regionCounter
	return regionCounter
		
func SetRegion(regionId : int, colour: Vector2i):
	for cell in loadedWorld:
		if (cell.Region == regionId):
			cell.AssetCoordinate = colour
	
func GetCell(i: int, j: int) -> ArtMap:
	for cell in loadedWorld:
		if (cell.matches(i,j)):
			return cell
	return ArtMap.new(Vector2i(0,0), Vector2i(0,0), 0)
