package core

Scene :: struct {
	load:   proc(),
	update: proc(dt: f32, core_game: ^Game_Data),
	draw:   proc(),
	unload: proc(),
}
