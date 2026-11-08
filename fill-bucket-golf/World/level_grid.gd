extends TileMapLayer

const SCREEN_SIZE_PX = Vector2(544,544)
const CELL_WIDTH_PX = 16
const GRID_WIDTH_CELLS = 34
const  BOUNDARY_OFFSET = 1

const tilemap_size = Vector2i(32,32)

var loadedWorld : Array[ArtMap]
var regionCounter = 0;
var border_coord = Vector2i(0,0)
var blank_coord = Vector2i(1,0)

func _ready() -> void:
	ResetWorld()
	construct_scene("res://ART/Beanz2.png")

# public function:
# set the scene from the image filename (string, e.g. "res://ART/Beanz2.png")
# returns the size of the image set (i.e. unique tiles e.g. 16 * 16, 32 * 32, etc)
func construct_scene(fileName) -> Vector2i:
	var image = Image.load_from_file(fileName)
	imageToMap(image)
	return Vector2i(image.get_width(), image.get_height())

# public function:
# receive the puck landing event
func puck_landed(puck: Puck):
	pass

func ResetWorld() -> void: #to do: clear regions
	for x in tilemap_size.x:
		for y in tilemap_size.y:
			set_cell(Vector2i(x,y), 0, blank_coord)
	
#To do: merge with construct		
func imageToMap(im : Image) -> void:
	var maxX = 16
	var maxY = 16
	var regionMap = {} #Dictionary["color":, Array[Vector2i]]
	for x in range(0, maxX):
		for y in range(0, maxY):
			var colour :Color = im.get_pixel(x, y)
			var colourname = "{0}, {1}, {2}".format([colour.r, colour.g, colour.b])
			if(regionMap.keys().has(colourname)):
				regionMap[colourname].append(Vector2i(x,y))
			else :
				var regionList : Array[Vector2i] = []
				regionMap[colourname] = regionList
				regionList.append(Vector2i(x,y))
				
	var debugCounter = 0; #delete later
	for yy in regionMap.keys():
		var p = AddRegion(regionMap[yy])
		SetRegion(p, Vector2i(debugCounter, 0))
		debugCounter += 1

func _process(_delta: float) -> void: #to do: should do nothing
	for art in loadedWorld:
		set_cell(art.Gridspace, 0, art.AssetCoordinate)

#internal use only
#take the list of pixels corresponding to the array and set it to a new region
func AddRegion(regionCells: Array[Vector2i]) -> int:
	regionCounter += 1
	for cell in regionCells:
		GetCell(cell.x, cell.y).Region = regionCounter
	return regionCounter
	
#internal use only	
#Set the region with the id to the colour from the tile map that corresponds to the vector
func SetRegion(regionId : int, colour: Vector2i):
	for cell in loadedWorld:
		if (cell.Region == regionId):
			cell.AssetCoordinate = colour
	
#internal use only
#dogshit lookup for pixel at x and y
func GetCell(x: int, y: int) -> ArtMap:
	for cell in loadedWorld:
		if (cell.matches(x,y)):
			return cell
#	Add the cell otherwise
	var newCell = ArtMap.new(Vector2i(x,y), Vector2i(0,0), 0)
	loadedWorld.append(newCell)
	return newCell
