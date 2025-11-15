package main

import "core:fmt"
import "core:mem"
import "game"
import "game/core"
import rl "vendor:raylib"

main :: proc() {
	when ODIN_DEBUG {
		track: mem.Tracking_Allocator
		mem.tracking_allocator_init(&track, context.allocator)
		context.allocator = mem.tracking_allocator(&track)

		defer {
			if len(track.allocation_map) > 0 {
				fmt.eprintf("=== %v allocations not freed: ===\n", len(track.allocation_map))
				for _, entry in track.allocation_map {
					fmt.eprintf("- %v bytes @ %v\n", entry.size, entry.location)
				}
			}
			mem.tracking_allocator_destroy(&track)
		}
	}

	scene_manager := core.Scene_Manager {
		scenes         = make(map[string]^core.Scene),
		pending_change = false,
	}
	defer delete(scene_manager.scenes)

	main_menu_scene := game.main_menu_new()
	defer free(main_menu_scene)

	splash_screen_scene := game.splash_screen_new()
	defer free(splash_screen_scene)

	game_data := core.Game_Data {
		scene_manager = &scene_manager,
	}

	rl.InitWindow(800, 600, "Odin MiniRPG")
	rl.SetTargetFPS(60)

	// TODO: Make loading scenes more readable
	scene_manager.scenes[game.SCENE_NAME_MAIN_MENU] = main_menu_scene

	scene_manager.scenes[game.SCENE_NAME_SPLASH_SCREEN] = splash_screen_scene
	scene_manager.current_scene = splash_screen_scene
	scene_manager.current_scene.load()

	for !rl.WindowShouldClose() {
		scene_manager.current_scene.update(rl.GetFrameTime(), &game_data)

		rl.BeginDrawing()
		rl.ClearBackground(rl.RAYWHITE)
		scene_manager.current_scene.draw()
		rl.EndDrawing()

		if scene_manager.pending_change {
			core.process_scene_change(&scene_manager)
		}
	}

	rl.CloseWindow()
}
