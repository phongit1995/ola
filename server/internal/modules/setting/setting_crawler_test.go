package setting

import (
	"fmt"
	"strings"
	"testing"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
)

func crawlerValue(overrides models.JSONB) models.JSONB {
	value := models.JSONB{
		"enabled": true, "intervalHours": 1, "importNewStories": false, "randomUserAgent": false,
		"useCookies": false, "cookies": []interface{}{},
	}
	for key, item := range overrides {
		if item == nil {
			delete(value, key)
			continue
		}
		value[key] = item
	}
	return value
}

func cookieValue(name, cookie, status string) map[string]interface{} {
	return map[string]interface{}{"name": name, "cookie": cookie, "status": status}
}

func TestValidateStoryCrawlerValue(t *testing.T) {
	valid := []models.JSONB{
		crawlerValue(nil),
		crawlerValue(models.JSONB{"enabled": false, "intervalHours": 24, "importNewStories": true, "randomUserAgent": true}),
		crawlerValue(models.JSONB{"useCookies": true, "cookies": []interface{}{
			cookieValue("acc1", "wordpress_logged_in_a=1", "active"),
			map[string]interface{}{"cookie": "wordpress_logged_in_b=2", "status": "dead", "deadAt": "2026-10-06T08:00:00Z"},
		}}),
	}
	for i, value := range valid {
		if err := ValidateStoryCrawlerValue(value); err != nil {
			t.Fatalf("valid case %d: %v", i, err)
		}
	}
	tooMany := make([]interface{}, 0, constants.StoryCookieMaxCount+1)
	for i := 0; i <= constants.StoryCookieMaxCount; i++ {
		tooMany = append(tooMany, cookieValue("", fmt.Sprintf("c=%d", i), "active"))
	}
	invalid := []struct {
		name  string
		value models.JSONB
		want  string
	}{
		{"missing field", crawlerValue(models.JSONB{"randomUserAgent": nil}), "randomUserAgent"},
		{"missing cookies", crawlerValue(models.JSONB{"cookies": nil}), "cookies"},
		{"bad interval", crawlerValue(models.JSONB{"intervalHours": 5}), "chu kỳ"},
		{"zero interval", crawlerValue(models.JSONB{"intervalHours": 0}), "chu kỳ"},
		{"unknown field", crawlerValue(models.JSONB{"cron": "* * *"}), "unknown field"},
		{"wrong type", crawlerValue(models.JSONB{"enabled": "yes"}), "invalid"},
		{"empty cookie", crawlerValue(models.JSONB{"cookies": []interface{}{cookieValue("a", "  ", "active")}}), "cookie 1 đang trống"},
		{"bad status", crawlerValue(models.JSONB{"cookies": []interface{}{cookieValue("a", "x=1", "live")}}), "trạng thái cookie 1"},
		{"missing status", crawlerValue(models.JSONB{"cookies": []interface{}{map[string]interface{}{"cookie": "x=1"}}}), "trạng thái cookie 1"},
		{"duplicate", crawlerValue(models.JSONB{"cookies": []interface{}{cookieValue("a", "x=1", "active"), cookieValue("b", " x=1", "dead")}}), "cookie 2 bị trùng"},
		{"newline", crawlerValue(models.JSONB{"cookies": []interface{}{cookieValue("a", "x=1\r\nHost: evil", "active")}}), "xuống dòng"},
		{"too long", crawlerValue(models.JSONB{"cookies": []interface{}{cookieValue("a", strings.Repeat("x", constants.StoryCookieMaxLength+1), "active")}}), "dài quá"},
		{"long name", crawlerValue(models.JSONB{"cookies": []interface{}{cookieValue(strings.Repeat("a", constants.StoryCookieNameMaxRunes+1), "x=1", "active")}}), "tên cookie 1"},
		{"cookie unknown field", crawlerValue(models.JSONB{"cookies": []interface{}{map[string]interface{}{"cookie": "x=1", "status": "active", "password": "p"}}}), "unknown field"},
		{"too many", crawlerValue(models.JSONB{"cookies": tooMany}), "tối đa"},
	}
	for _, tc := range invalid {
		err := ValidateStoryCrawlerValue(tc.value)
		if err == nil || !strings.Contains(err.Error(), tc.want) {
			t.Fatalf("%s: got %v, want error containing %q", tc.name, err, tc.want)
		}
	}
}

func TestStoryCrawlerInterval(t *testing.T) {
	if got := (StoryCrawlerConfig{IntervalHours: 3}).Interval().Hours(); got != 3 {
		t.Fatalf("got %v hours", got)
	}
	if cfg := DefaultStoryCrawlerConfig(); cfg.Enabled || cfg.ImportNewStories || cfg.RandomUserAgent || cfg.UseCookies || cfg.Cookies == nil || cfg.IntervalHours != 1 {
		t.Fatalf("unexpected default %+v", cfg)
	}
}
