package core

Tile_Data :: struct {
	walkable: bool,
}

Tilemap :: struct {
	width:  i32,
	height: i32,
	tiles:  []Tile_Data,
}

tilemap_new :: proc(width: i32, height: i32, tile_size: i32) -> ^Tilemap {
	tilemap := new(Tilemap)
	tilemap.width = width
	tilemap.height = height

	tilemap.tiles = make([]Tile_Data, width * height)

	return tilemap
}

tilemap_get_tile :: proc(tilemap: ^Tilemap, x: i32, y: i32) -> ^Tile_Data {
	if !tilemap_check_bounds(tilemap, x, y) {
        return nil
	}

	index := y * tilemap.width + x
	return &tilemap.tiles[index]
}

@(private = "file")
tilemap_check_bounds :: proc(tilemap: ^Tilemap, x: i32, y: i32) -> bool {
	return x >= 0 && x < tilemap.width && y >= 0 && y < tilemap.height
}
