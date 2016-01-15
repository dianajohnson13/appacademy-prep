def measure(times = 1, &proc)
	start_time = Time.now
	times.times {proc.call}
	(Time.now - start_time) / times
end