package setting

import (
	"encoding/json"
	"errors"

	"ola-chat-server/internal/models"
	"ola-chat-server/internal/utils"
)

func DefaultOddsRules() PlatformRules {
	rules := OpenPlatformRules()
	rules.Web.Enabled = false
	return rules
}

func OddsRulesFrom(value models.JSONB) PlatformRules {
	rules := DefaultOddsRules()
	if len(value) == 0 {
		return rules
	}
	raw, err := json.Marshal(value)
	if err != nil {
		return rules
	}
	if err := json.Unmarshal(raw, &rules); err != nil {
		return DefaultOddsRules()
	}
	return rules.normalized()
}

func ValidateOddsRules(value models.JSONB) error {
	in, err := decodePlatformRules(value)
	if err != nil {
		return errors.New("cấu hình hiện tỷ lệ không hợp lệ")
	}
	return in.validate()
}

func OddsRulesValue(value models.JSONB) (models.JSONB, error) {
	if value == nil {
		return DefaultOddsRules().JSONB(), nil
	}
	if err := ValidateOddsRules(value); err != nil {
		return nil, utils.NewHTTPError(400, err.Error())
	}
	return OddsRulesFrom(value).JSONB(), nil
}

func (r PlatformRules) JSONB() models.JSONB {
	r = r.normalized()
	return models.JSONB{
		"web":     map[string]interface{}{"enabled": r.Web.Enabled, "disableVersions": r.Web.DisableVersions},
		"android": map[string]interface{}{"enabled": r.Android.Enabled, "disableVersions": r.Android.DisableVersions},
		"ios":     map[string]interface{}{"enabled": r.IOS.Enabled, "disableVersions": r.IOS.DisableVersions},
	}
}
