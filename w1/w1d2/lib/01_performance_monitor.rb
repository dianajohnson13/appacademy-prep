def measure(n = 1, &proc)
	start_time = Time.now
	n.times {proc.call}
	(Time.now - start_time) / n
end