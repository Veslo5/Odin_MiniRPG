package game

import "core"
import "core:fmt"
import rl "vendor:raylib"

SCENE_NAME_SPLASH_SCREEN :: "SPLASH_SCREEN"

Splash_Screen_Data :: struct {
	timer: ^core.Timer,
}

splash_screen_new :: proc() -> ^core.Scene {
	scene := new(core.Scene)

	scene.name = SCENE_NAME_SPLASH_SCREEN
	scene.load = splash_screen_load
	scene.update = splash_screen_update
	scene.draw = splash_screen_draw
	scene.unload = splash_screen_unload
	scene.data = new(Splash_Screen_Data)

	return scene
}

@(private = "file")
splash_screen_load :: proc(scene: ^core.Scene) {
	fmt.printfln("%v loaded", SCENE_NAME_SPLASH_SCREEN)
	timer := core.timer_new(3.0, proc() {
		fmt.println("Timer ended!")
	})
	core.timer_start(timer)

	data := cast(^Splash_Screen_Data)scene.data
	data.timer = timer
}

@(private = "file")
splash_screen_update :: proc(dt: f32, scene: ^core.Scene, game: ^core.Game_Data) {
	// if rl.IsKeyPressed(rl.KeyboardKey.SPACE) {
	// 	core.change_scene(game.scene_manager, SCENE_NAME_MAIN_MENU)
	// }
	data := cast(^Splash_Screen_Data)scene.data
	core.timer_update(data.timer, dt)
}

@(private = "file")
splash_screen_draw :: proc(scene: ^core.Scene) {
	rl.DrawText("Hello, from Splash Screen!", 100, 100, 20, rl.DARKGRAY)
}

@(private = "file")
splash_screen_unload :: proc(scene: ^core.Scene) {
	fmt.printfln("%v unloaded", SCENE_NAME_SPLASH_SCREEN)
	data := cast(^Splash_Screen_Data)scene.data

	core.timer_delete(data.timer)
	free(scene.data)
}
