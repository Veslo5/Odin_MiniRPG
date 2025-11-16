package core

Timer :: struct {
	end_time:     f32,
	elapsed_time: f32,
	running:      bool,
	repeatable:   bool,
	callback:     proc(),
}

timer_new :: proc(end_time: f32, callback: proc(), repeatable: bool = false) -> ^Timer {
	assert(callback != nil, "Timer callback cannot be nil!")

	timer := new(Timer)
	timer.end_time = end_time
	timer.elapsed_time = 0.0
	timer.running = false
	timer.repeatable = repeatable
	timer.callback = callback

	return timer
}

timer_start :: proc(timer: ^Timer) {
	timer.elapsed_time = 0.0
	timer.running = true
}

timer_pause :: proc(timer: ^Timer) {
	timer.running = false
}

timer_stop :: proc(timer: ^Timer) {
	timer.running = false
	timer.elapsed_time = 0.0
}

timer_update :: proc(timer: ^Timer, dt: f32) {
	if timer.running {
		timer.elapsed_time += dt

		if timer.elapsed_time >= timer.end_time {
			timer.callback()
			timer.elapsed_time -= timer.end_time

			if !timer.repeatable {
				timer.running = false
			}
		}
	}
}

timer_delete :: proc(timer: ^Timer) {
	free(timer)
}
