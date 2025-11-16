package game

import "core"
import "core:fmt"
import rl "vendor:raylib"

SCENE_NAME_MAP_EDITOR :: "MAP_EDITOR"

Map_Editor_Data :: struct {

}

map_editor_new :: proc() -> ^core.Scene {
	scene := new(core.Scene)

	scene.name = SCENE_NAME_MAP_EDITOR
	scene.load = map_editor_load
	scene.update = map_editor_update
	scene.draw = map_editor_draw
	scene.unload = map_editor_unload
	scene.data = new(Map_Editor_Data)

	return scene
}

@(private = "file")
map_editor_load :: proc(scene: ^core.Scene) {
	fmt.printfln("%v loaded", SCENE_NAME_MAP_EDITOR)

}

@(private = "file")
map_editor_update :: proc(dt: f32, scene: ^core.Scene, game: ^core.Game_Data) {

}

@(private = "file")
map_editor_draw :: proc(scene: ^core.Scene) {
	rl.DrawText("Hello from Map Editor!", 100, 100, 20, rl.DARKGRAY)
}

@(private = "file")
map_editor_unload :: proc(scene: ^core.Scene) {
	fmt.printfln("%v unloaded", SCENE_NAME_MAP_EDITOR)
}
