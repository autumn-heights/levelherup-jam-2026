class_name ArtMap extends Node

@export var Gridspace: Vector2i = Vector2i(0,0)
@export var AssetCoordinate: Vector2i = Vector2i(0, 0)
@export var IsFilled : bool = false
@export var IsBoundary : bool = false
@export var Region : int = 0

func _init(gridSpace: Vector2i, assetCoordinate :Vector2i, 
region: int, isFilled = false, isBoundary = false) -> void:
	Gridspace = gridSpace
	AssetCoordinate = assetCoordinate
	IsFilled = isFilled
	IsBoundary = isBoundary
	Region = region
	
func matches(x, y) -> bool:
	return (Gridspace.x == x && Gridspace.y == y )
