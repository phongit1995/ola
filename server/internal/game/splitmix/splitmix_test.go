package splitmix

import "testing"

func TestNextMatchesReferenceSequence(t *testing.T) {
	var state uint64
	want := []uint64{0xE220A8397B1DCDAF, 0x6E789E6AA1B965F4, 0x06C45D188009454F}
	for i, w := range want {
		if got := Next(&state); got != w {
			t.Fatalf("output %d = %#x, want %#x", i, got, w)
		}
	}
}
