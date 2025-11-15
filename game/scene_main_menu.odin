package game

import "core"
import "core:fmt"
import rl "vendor:raylib"

SCENE_NAME_MAIN_MENU :: "MAIN_MENU"

main_menu_new :: proc() -> ^core.Scene {
	scene := new(core.Scene)

	scene.load = main_menu_load
	scene.update = main_menu_update
	scene.draw = main_menu_draw
	scene.unload = main_menu_unload

	return scene
}

@(private = "file")
main_menu_load :: proc() {
	fmt.printfln("%v loaded", SCENE_NAME_MAIN_MENU)
}

@(private = "file")
main_menu_update :: proc(dt: f32, game: ^core.Game_Data) {

}

@(private = "file")
main_menu_draw :: proc() {
	rl.DrawText("Hello from Main Menu!", 100, 100, 20, rl.DARKGRAY)
}

@(private = "file")
main_menu_unload :: proc() {
	fmt.printfln("%v unloaded", SCENE_NAME_MAIN_MENU)
}
