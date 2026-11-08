extends Node2D
var border = 40

func generate_borders(level_grid: TileMapLayer):
	var tsize = level_grid.tile_set.tile_size
	var used_rect = level_grid.get_used_rect().size * tsize
	#print("setting wall shapes")
	var cards = [Vector2.UP, Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT]
	var j = 0
	for i in $StaticBody2D.get_child_count():
		print("wallshape ", i)
		var child = $StaticBody2D.get_child(i)
		if child is not CollisionShape2D:
			continue
		var d = cards[j]
		var shape = RectangleShape2D.new()
		print("setting wall shape for direction: ", d)
		var hshape = Vector2(used_rect.x + border*2, border)
		var vshape = Vector2(border, used_rect.y + border *2)
		#child.position.x = remap(abs(d.x), 0,1, border *0.5)
		child.rotation = 0
		match d:
			Vector2.UP: 
				child.position = Vector2(used_rect.x *0.5, -border *0.5)
				shape.size = hshape
			Vector2.DOWN: 
				child.position = Vector2(used_rect.x *0.5, used_rect.y + (border*0.5))
				shape.size = hshape
			Vector2.LEFT: 
				child.position = Vector2(-border *0.5, used_rect.y * 0.5)
				shape.size = vshape
			Vector2.RIGHT: 
				child.position = Vector2(used_rect.x + border *0.5, used_rect.y * 0.5)
				shape.size = vshape
		child.shape = shape
		child.position += level_grid.position
		j += 1
	
	
	
	
