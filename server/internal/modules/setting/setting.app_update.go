package setting

import (
	"bytes"
	"encoding/json"
	"errors"
	"strings"

	"ola-chat-server/internal/models"
)

type AppUpdateConfig struct {
	Android []string `json:"android"`
	IOS     []string `json:"ios"`
}

func (s *Service) GetAppUpdate() (AppUpdateConfig, error) {
	var cfg AppUpdateConfig
	err := s.getInto(KeyAppUpdate, &cfg)
	return cfg, err
}

func (c AppUpdateConfig) versionsFor(platform string) []string {
	switch strings.ToLower(strings.TrimSpace(platform)) {
	case PlatformAndroid:
		return c.Android
	case PlatformIOS:
		return c.IOS
	default:
		return nil
	}
}

// A build that sends no readable version cannot be matched, so it is never blocked.
func (c AppUpdateConfig) RequiredFor(client Client) bool {
	versions := c.versionsFor(client.Platform)
	if len(versions) == 0 {
		return false
	}
	current, ok := parseVersion(appVersionName(client.AppVersion))
	if !ok {
		return false
	}
	for _, raw := range versions {
		if version, ok := parseVersion(raw); ok && sameVersion(current, version) {
			return true
		}
	}
	return false
}

func ValidateAppUpdateValue(value models.JSONB) error {
	raw, err := json.Marshal(value)
	if err != nil {
		return err
	}
	decoder := json.NewDecoder(bytes.NewReader(raw))
	decoder.DisallowUnknownFields()
	var in AppUpdateConfig
	if err := decoder.Decode(&in); err != nil {
		return errors.New("cấu hình cập nhật app không hợp lệ: " + err.Error())
	}
	if err := validateVersionList("Android", in.Android, appUpdateVersionsNoun); err != nil {
		return err
	}
	return validateVersionList("iOS", in.IOS, appUpdateVersionsNoun)
}
