package core

import rl "vendor:raylib"

Atlas :: struct {
	tile_width:  i32,
	tile_height: i32,
	texture:     rl.Texture2D,
	quads:       []rl.Rectangle,
}

atlas_new :: proc(texture: rl.Texture2D, tile_width: i32, tile_height: i32) -> ^Atlas {
	atlas := new(Atlas)

	atlas.tile_width = tile_width
	atlas.tile_height = tile_height
	atlas.texture = texture

	atlas_generate_quads(atlas)

	return atlas
}

atlas_draw_quad :: proc(atlas: ^Atlas, index: int, position: rl.Vector2) {
	if index < 0 || index >= len(atlas.quads) {
		return
	}

	rl.DrawTextureRec(atlas.texture, atlas.quads[index], position, rl.WHITE)
}

@(private = "file")
atlas_generate_quads :: proc(atlas: ^Atlas) {
	cols := atlas.texture.width / atlas.tile_width
	rows := atlas.texture.height / atlas.tile_height

	atlas.quads = make([]rl.Rectangle, cols * rows)

	for y in 0 ..< rows {
		for x in 0 ..< cols {
			index := y * cols + x
			atlas.quads[index] = rl.Rectangle {
				x      = f32(x * atlas.tile_width),
				y      = f32(y * atlas.tile_height),
				width  = f32(atlas.tile_width),
				height = f32(atlas.tile_height),
			}
		}
	}
}
