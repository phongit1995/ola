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
	case strings.Contains(lower, "android"):
		return "android"
	case strings.Contains(lower, "iphone"),
		strings.Contains(lower, "ipad"),
		strings.Contains(lower, "ios"),
		strings.Contains(lower, "cfnetwork"),
		strings.Contains(lower, "darwin"):
		return "ios"
	default:
		return "web"
	}
}

func detectBrowser(lower string) string {
	switch {
	case strings.Contains(lower, "edg"):
		return "Edge"
	case strings.Contains(lower, "chrome"):
		return "Chrome"
	case strings.Contains(lower, "firefox"):
		return "Firefox"
	case strings.Contains(lower, "safari"):
		return "Safari"
	case strings.Contains(lower, "okhttp"):
		return "Android app"
	case strings.Contains(lower, "cfnetwork"), strings.Contains(lower, "darwin"):
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
	case strings.Contains(lower, "iphone"), strings.Contains(lower, "ipad"), strings.Contains(lower, "ios"):
		return "iOS"
	case strings.Contains(lower, "windows"):
		return "Windows"
	case strings.Contains(lower, "mac os"), strings.Contains(lower, "macintosh"):
		return "macOS"
	case strings.Contains(lower, "linux"):
		return "Linux"
	default:
		return ""
	}
}
