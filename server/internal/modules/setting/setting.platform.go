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
)

const disableVersionsMax = 50

var (
	versionPattern        = regexp.MustCompile(`^\d{1,6}(\.\d{1,6}){0,3}$`)
	leadingVersionPattern = regexp.MustCompile(`^\s*(\d{1,6}(?:\.\d{1,6}){0,3})(?:$|[\s(])`)
)

type PlatformRule struct {
	Enabled         bool     `json:"enabled"`
	DisableVersions []string `json:"disableVersions"`
}

type PlatformRules struct {
	Web     PlatformRule `json:"web"`
	Android PlatformRule `json:"android"`
	IOS     PlatformRule `json:"ios"`
}

type platformRuleInput struct {
	Enabled         *bool    `json:"enabled"`
	DisableVersions []string `json:"disableVersions"`
}

type platformRulesInput struct {
	Web     *platformRuleInput `json:"web"`
	Android *platformRuleInput `json:"android"`
	IOS     *platformRuleInput `json:"ios"`
}

func OpenPlatformRules() PlatformRules {
	return PlatformRules{
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

func (r PlatformRules) ruleFor(platform string) (PlatformRule, bool) {
	switch strings.ToLower(strings.TrimSpace(platform)) {
	case constants.PlatformAndroid:
		return r.Android, true
	case constants.PlatformIOS:
		return r.IOS, true
	default:
		return r.Web, false
	}
}

func (r PlatformRules) EnabledFor(platform, appVersion string) bool {
	rule, versioned := r.ruleFor(platform)
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

func (r PlatformRules) normalized() PlatformRules {
	r.Web.DisableVersions = []string{}
	r.Android.DisableVersions = validDisableVersions(r.Android.DisableVersions)
	r.IOS.DisableVersions = validDisableVersions(r.IOS.DisableVersions)
	return r
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

func decodePlatformRules(value interface{}) (platformRulesInput, error) {
	var in platformRulesInput
	raw, err := json.Marshal(value)
	if err != nil {
		return in, err
	}
	decoder := json.NewDecoder(bytes.NewReader(raw))
	decoder.DisallowUnknownFields()
	err = decoder.Decode(&in)
	return in, err
}

func (in platformRulesInput) validate() error {
	if in.Web == nil || in.Android == nil || in.IOS == nil {
		return errors.New("cấu hình nền tảng cần đủ web, android và ios")
	}
	if in.Web.Enabled == nil || in.Android.Enabled == nil || in.IOS.Enabled == nil {
		return errors.New("mỗi nền tảng cần có enabled")
	}
	if len(in.Web.DisableVersions) > 0 {
		return errors.New("web không dùng danh sách bản bị tắt")
	}
	if err := validateDisableVersions("Android", in.Android.DisableVersions); err != nil {
		return err
	}
	return validateDisableVersions("iOS", in.IOS.DisableVersions)
}
