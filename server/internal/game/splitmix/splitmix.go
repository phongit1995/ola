package splitmix

const golden = 0x9E3779B97F4A7C15

func Next(state *uint64) uint64 {
	*state += golden
	v := *state
	v ^= v >> 30
	v *= 0xBF58476D1CE4E5B9
	v ^= v >> 27
	v *= 0x94D049BB133111EB
	v ^= v >> 31
	return v
}
