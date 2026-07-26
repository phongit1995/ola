package utils

import "strings"

func ParseDeviceName(userAgent string) string {
	if strings.TrimSpace(userAgent) == "" {
		return "Unknown device"
	}
	lower := strings.ToLower(userAgent)
	browser := detectBrowser(lower)
	os := detectOS(lower)
	switch {
	case browser != "" && os != "":
		return browser + " on " + os
	case browser != "":
		return browser
	case os != "":
		return os
	default:
		return "Unknown device"
	}
}

func ParsePlatform(userAgent string) string {
	lower := strings.ToLower(userAgent)
	switch {
	case containsAny(lower, "android", "okhttp"):
		return "android"
	case containsAny(lower, "iphone", "ipad", "ipod", "crios", "fxios", "edgios", "cfnetwork", "darwin"):
		return "ios"
	default:
		return "web"
	}
}

func containsAny(value string, tokens ...string) bool {
	for _, token := range tokens {
		if strings.Contains(value, token) {
			return true
		}
	}
	return false
}

func detectBrowser(lower string) string {
	switch {
	case strings.Contains(lower, "edg"):
		return "Edge"
	case containsAny(lower, "crios", "chrome"):
		return "Chrome"
	case containsAny(lower, "fxios", "firefox"):
		return "Firefox"
	case strings.Contains(lower, "safari"):
		return "Safari"
	case strings.Contains(lower, "okhttp"):
		return "Android app"
	case containsAny(lower, "cfnetwork", "darwin"):
		return "iOS app"
	case strings.Contains(lower, "dart"):
		return "Mobile app"
	default:
		return ""
	}
}

func detectOS(lower string) string {
	switch {
	case strings.Contains(lower, "android"):
		return "Android"
	case containsAny(lower, "iphone", "ipad", "ipod", "crios", "fxios", "edgios"):
		return "iOS"
	case strings.Contains(lower, "windows"):
		return "Windows"
	case containsAny(lower, "mac os", "macintosh"):
		return "macOS"
	case strings.Contains(lower, "linux"):
		return "Linux"
	default:
		return ""
	}
}
