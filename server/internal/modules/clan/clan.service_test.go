package clan

import "testing"

func TestNormalizeSearchQuery(t *testing.T) {
	cases := []struct {
		in   string
		want string
		ok   bool
	}{
		{"", "", true},
		{"  #TeamViet ", "teamviet", true},
		{"abc123", "abc123", true},
		{"team viet", "team viet", false},
		{"a%b", "a%b", false},
		{"a_b", "a_b", false},
		{"việt", "việt", false},
	}
	for _, tc := range cases {
		got, ok := normalizeSearchQuery(tc.in)
		if got != tc.want || ok != tc.ok {
			t.Errorf("normalizeSearchQuery(%q) = (%q, %v), want (%q, %v)", tc.in, got, ok, tc.want, tc.ok)
		}
	}
}
