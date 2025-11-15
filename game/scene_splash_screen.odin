package game

import "core"
import "core:fmt"
import rl "vendor:raylib"

SCENE_NAME_SPLASH_SCREEN :: "SPLASH_SCREEN"

splash_screen_new :: proc() -> ^core.Scene {
	scene := new(core.Scene)

	scene.load = splash_screen_load
	scene.update = splash_screen_update
	scene.draw = splash_screen_draw
	scene.unload = splash_screen_unload

	return scene
}

@(private = "file")
splash_screen_load :: proc() {
	fmt.printfln("%v loaded", SCENE_NAME_SPLASH_SCREEN)
}

@(private = "file")
splash_screen_update :: proc(dt: f32, game: ^core.Game_Data) {
	if rl.IsKeyPressed(rl.KeyboardKey.SPACE) {
		core.change_scene(game.scene_manager, SCENE_NAME_MAIN_MENU)
	}
}

@(private = "file")
splash_screen_draw :: proc() {
	rl.DrawText("Hello, from Splash Screen!", 100, 100, 20, rl.DARKGRAY)
}

@(private = "file")
splash_screen_unload :: proc() {
	fmt.printfln("%v unloaded", SCENE_NAME_SPLASH_SCREEN)
}
