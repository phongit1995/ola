package setting

import (
	"bytes"
	"encoding/json"
	"errors"
	"fmt"
	"regexp"
	"strconv"
	"strings"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
)

const (
	KeyStory = "story"

	disableVersionsMax = 50
)

var (
	versionPattern        = regexp.MustCompile(`^\d{1,6}(\.\d{1,6}){0,3}$`)
	leadingVersionPattern = regexp.MustCompile(`^\s*(\d{1,6}(?:\.\d{1,6}){0,3})(?:$|[\s(])`)
)

type PlatformRule struct {
	Enabled         bool     `json:"enabled"`
	DisableVersions []string `json:"disableVersions"`
}

type platformRuleInput struct {
	Enabled         *bool    `json:"enabled"`
	DisableVersions []string `json:"disableVersions"`
}

type StoryConfig struct {
	Web     PlatformRule `json:"web"`
	Android PlatformRule `json:"android"`
	IOS     PlatformRule `json:"ios"`
}

func DefaultStoryConfig() StoryConfig {
	return StoryConfig{
		Web:     PlatformRule{Enabled: true, DisableVersions: []string{}},
		Android: PlatformRule{Enabled: true, DisableVersions: []string{}},
		IOS:     PlatformRule{Enabled: true, DisableVersions: []string{}},
	}
}

func parseVersion(raw string) ([]int, bool) {
	if !versionPattern.MatchString(raw) {
		return nil, false
	}
	parts := strings.Split(raw, ".")
	numbers := make([]int, len(parts))
	for i, part := range parts {
		number, err := strconv.Atoi(part)
		if err != nil {
			return nil, false
		}
		numbers[i] = number
	}
	return numbers, true
}

func sameVersion(a, b []int) bool {
	for i := 0; i < len(a) || i < len(b); i++ {
		var left, right int
		if i < len(a) {
			left = a[i]
		}
		if i < len(b) {
			right = b[i]
		}
		if left != right {
			return false
		}
	}
	return true
}

func appVersionName(appVersion string) string {
	match := leadingVersionPattern.FindStringSubmatch(appVersion)
	if match == nil {
		return ""
	}
	return match[1]
}

func (c StoryConfig) ruleFor(platform string) (PlatformRule, bool) {
	switch strings.ToLower(strings.TrimSpace(platform)) {
	case constants.PlatformAndroid:
		return c.Android, true
	case constants.PlatformIOS:
		return c.IOS, true
	default:
		return c.Web, false
	}
}

func (c StoryConfig) EnabledFor(platform, appVersion string) bool {
	rule, versioned := c.ruleFor(platform)
	if !rule.Enabled {
		return false
	}
	if !versioned || len(rule.DisableVersions) == 0 {
		return true
	}
	current, ok := parseVersion(appVersionName(appVersion))
	if !ok {
		return false
	}
	for _, raw := range rule.DisableVersions {
		if disabled, ok := parseVersion(raw); ok && sameVersion(current, disabled) {
			return false
		}
	}
	return true
}

func validDisableVersions(versions []string) []string {
	out := make([]string, 0, len(versions))
	for _, raw := range versions {
		if _, ok := parseVersion(raw); ok {
			out = append(out, raw)
		}
	}
	return out
}

func validateDisableVersions(label string, versions []string) error {
	if len(versions) > disableVersionsMax {
		return fmt.Errorf("%s: tối đa %d bản bị tắt", label, disableVersionsMax)
	}
	seen := make([][]int, 0, len(versions))
	for _, raw := range versions {
		version, ok := parseVersion(raw)
		if !ok {
			return fmt.Errorf("%s: phiên bản %q phải có dạng 1.0.0", label, raw)
		}
		for _, other := range seen {
			if sameVersion(version, other) {
				return fmt.Errorf("%s: phiên bản %q bị nhập hai lần", label, raw)
			}
		}
		seen = append(seen, version)
	}
	return nil
}

func (s *Service) GetStory() (StoryConfig, error) {
	cfg := DefaultStoryConfig()
	err := s.getInto(KeyStory, &cfg)
	cfg.Web.DisableVersions = []string{}
	cfg.Android.DisableVersions = validDisableVersions(cfg.Android.DisableVersions)
	cfg.IOS.DisableVersions = validDisableVersions(cfg.IOS.DisableVersions)
	return cfg, err
}

func ValidateStoryValue(value models.JSONB) error {
	raw, err := json.Marshal(value)
	if err != nil {
		return errors.New("invalid story config")
	}
	var cfg struct {
		Web     *platformRuleInput `json:"web"`
		Android *platformRuleInput `json:"android"`
		IOS     *platformRuleInput `json:"ios"`
	}
	decoder := json.NewDecoder(bytes.NewReader(raw))
	decoder.DisallowUnknownFields()
	if err := decoder.Decode(&cfg); err != nil {
		return errors.New("invalid story config: " + err.Error())
	}
	if cfg.Web == nil || cfg.Android == nil || cfg.IOS == nil {
		return errors.New("cấu hình truyện cần đủ web, android và ios")
	}
	if cfg.Web.Enabled == nil || cfg.Android.Enabled == nil || cfg.IOS.Enabled == nil {
		return errors.New("mỗi nền tảng cần có enabled")
	}
	if len(cfg.Web.DisableVersions) > 0 {
		return errors.New("web không dùng danh sách bản bị tắt")
	}
	if err := validateDisableVersions("Android", cfg.Android.DisableVersions); err != nil {
		return err
	}
	return validateDisableVersions("iOS", cfg.IOS.DisableVersions)
}
