package utils

import "testing"

func TestParsePlatform(t *testing.T) {
	cases := []struct {
		name      string
		userAgent string
		want      string
	}{
		{"android chrome", "Mozilla/5.0 (Linux; Android 14; Pixel 8) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0 Mobile Safari/537.36", "android"},
		{"android app okhttp", "okhttp/4.12.0", "android"},
		{"iphone safari", "Mozilla/5.0 (iPhone; CPU iPhone OS 17_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.5 Mobile/15E148 Safari/604.1", "ios"},
		{"chrome ios", "Mozilla/5.0 (iPhone; CPU iPhone OS 17_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/126.0 Mobile/15E148 Safari/604.1", "ios"},
		{"firefox ios", "Mozilla/5.0 (iPhone; CPU iPhone OS 17_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) FxiOS/127.0 Mobile/15E148 Safari/605.1.15", "ios"},
		{"ios app cfnetwork", "OlaMobile/1 CFNetwork/1494.0.7 Darwin/23.4.0", "ios"},
		{"ipad", "Mozilla/5.0 (iPad; CPU OS 16_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148", "ios"},
		{"windows chrome", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0 Safari/537.36", "web"},
		{"mac safari", "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.5 Safari/605.1.15", "web"},
		{"axios script", "axios/1.7.4", "web"},
		{"nagios probe", "check_http/v2.3 (nagios-plugins 2.3)", "web"},
		{"empty", "", "web"},
	}
	for _, tc := range cases {
		t.Run(tc.name, func(t *testing.T) {
			if got := ParsePlatform(tc.userAgent); got != tc.want {
				t.Fatalf("ParsePlatform(%q) = %q, want %q", tc.userAgent, got, tc.want)
			}
		})
	}
}

func TestParseDeviceName(t *testing.T) {
	cases := []struct {
		name      string
		userAgent string
		want      string
	}{
		{"chrome windows", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0 Safari/537.36", "Chrome on Windows"},
		{"chrome ios", "Mozilla/5.0 (iPhone; CPU iPhone OS 17_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/126.0 Mobile/15E148 Safari/604.1", "Chrome on iOS"},
		{"firefox ios", "Mozilla/5.0 (iPhone; CPU iPhone OS 17_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) FxiOS/127.0 Mobile/15E148 Safari/605.1.15", "Firefox on iOS"},
		{"safari mac", "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.5 Safari/605.1.15", "Safari on macOS"},
		{"android app okhttp", "okhttp/4.12.0", "Android app"},
		{"ios app cfnetwork", "OlaMobile/1 CFNetwork/1494.0.7 Darwin/23.4.0", "iOS app"},
		{"axios script", "axios/1.7.4", "Unknown device"},
		{"empty", "", "Unknown device"},
	}
	for _, tc := range cases {
		t.Run(tc.name, func(t *testing.T) {
			if got := ParseDeviceName(tc.userAgent); got != tc.want {
				t.Fatalf("ParseDeviceName(%q) = %q, want %q", tc.userAgent, got, tc.want)
			}
		})
	}
}
