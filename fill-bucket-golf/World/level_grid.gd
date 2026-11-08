extends TileMapLayer

const SCREEN_SIZE_PX = Vector2(544,544)
const CELL_WIDTH_PX = 16
const GRID_WIDTH_CELLS = 34
const  BOUNDARY_OFFSET = 1

const tilemap_size = Vector2i(32,32)

var loadedWorld : Array[ArtMap]
# auto incremented region counter.
# first region added = 1
var regionCounter = 0;
var border_coord = Vector2i(0,0)
var blank_coord = Vector2i(1,0)

func _ready() -> void:
	ResetWorld()
	#construct_scene("res://ART/cat.png")
	#debugRegions()

# public function:
# set the scene from the image filename (string, e.g. "res://ART/Beanz2.png")
# returns the size of the image set (i.e. unique tiles e.g. 16 * 16, 32 * 32, etc)
func construct_scene(fileName) -> Vector2i:
	var image = Image.load_from_file(fileName)
	var regionMap = {} #Dictionary["color":, Array[Vector2i]]
	for x in range(0, image.get_width()):
		for y in range(0, image.get_height()):
			set_cell(Vector2i(x,y),0, blank_coord)
			var colour :Color = image.get_pixel(x, y)
			var colourname = "{0}, {1}, {2}".format([colour.r, colour.g, colour.b])
			if(regionMap.keys().has(colourname)):
				regionMap[colourname].append(Vector2i(x,y))
			else :
				var regionList : Array[Vector2i] = []
				regionMap[colourname] = regionList
				regionList.append(Vector2i(x,y))
	
	for uniqueRegion in regionMap.keys():
		AddRegion(regionMap[uniqueRegion])

	return Vector2i(image.get_width(), image.get_height())

# public function:
# receive the puck landing event
func puck_landed(puck: Puck):
	#identify region
	var local = to_local(puck.position)
	var map = local_to_map(local)
	var artmap :ArtMap  = GetCell(map.x, map.y)
	#flip colour - bug
	var colour = Vector2i(puck.colour_id.y, puck.colour_id.x)
	SetRegion(artmap.Region, colour) 

func ResetWorld(clearWorld = true) -> void: 
	clear()
	if(clearWorld):
		for cell in loadedWorld:
			cell.AssetCoordinate = blank_coord
			cell.Region = 0
		regionCounter = 0

func _process(_delta: float) -> void:
	pass

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
			set_cell(cell.Gridspace, 0, cell.AssetCoordinate)
	
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

var debugCounter :int = 0
var debugPalette = [Vector2i(3,0), Vector2i(4,0), Vector2i(5,0), Vector2i(6,0), Vector2i(7,0)]

func debugRegions(useTimer = true) -> void:
	if(useTimer):
		debugCounter = 0
		$TestTimer.timeout.connect(on_test_timer_timeout)
		$TestTimer.wait_time = 0.5
		$TestTimer.one_shot = false
		$TestTimer.start()
	else: 
		for i in range(0, regionCounter + 1):
			var debugColour = debugPalette[i % 5]
			SetRegion(i, debugColour)


func on_test_timer_timeout():
	#var pastRegion = debugCounter - 1 % regionCounter
#
	#SetRegion(pastRegion, blank_coord)
	ResetWorld(false)
	var debugColour : Vector2i = debugPalette[debugCounter % 3]
	SetRegion(debugCounter, debugColour)
	debugCounter += 1 
	debugCounter = debugCounter % regionCounter + 1

	
