package core

import "core:fmt"

Scene_Manager :: struct {
	current_scene:      ^Scene,
	scenes:             map[string]^Scene,
	pending_change:     bool,
	pending_scene_name: string,
}

change_scene :: proc(scene_manager: ^Scene_Manager, scene_name: string) {
	assert(scene_manager != nil, "scene_manager cannot be nil")

	scene_manager.pending_scene_name = scene_name
	scene_manager.pending_change = true
}

process_scene_change :: proc(scene_manager: ^Scene_Manager) {
	assert(scene_manager != nil, "scene_manager cannot be nil")

	scene_manager.current_scene.unload(scene_manager.current_scene)
	scene_manager.current_scene = get_scene_by_name(
		scene_manager,
		scene_manager.pending_scene_name,
	)
	scene_manager.current_scene.load(scene_manager.current_scene)
	scene_manager.pending_change = false
}

get_scene_by_name :: proc(scene_manager: ^Scene_Manager, scene_name: string) -> ^Scene {
	assert(scene_manager != nil, "scene_manager cannot be nil")

	scene, exists := scene_manager.scenes[scene_name]
	if !exists {
		fmt.panicf("Scene not found: %v", scene_name)
	}

	return scene
}

set_and_load_init_scene :: proc(scene_manager: ^Scene_Manager, scene_name: string) {
	assert(scene_manager != nil, "scene_manager cannot be nil")

	scene_manager.current_scene = scene_manager.scenes[scene_name]
	scene_manager.current_scene.load(scene_manager.current_scene)
}
