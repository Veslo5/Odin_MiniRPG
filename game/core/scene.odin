package core

Scene :: struct {
	name:   string,
	load:   proc(scene: ^Scene),
	update: proc(dt: f32, scene: ^Scene, core_game: ^Game_Data),
	draw:   proc(scene: ^Scene),
	unload: proc(scene: ^Scene),
	data:   rawptr,
}
