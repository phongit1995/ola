package setting

import (
	"bytes"
	"encoding/json"
	"errors"
	"fmt"
	"strings"
	"time"
	"unicode/utf8"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
)

const KeyStoryCrawler = "story_crawler"

var crawlerIntervalHours = []int{1, 2, 3, 6, 12, 24}

type StoryCookie struct {
	Name   string     `json:"name"`
	Cookie string     `json:"cookie"`
	Status string     `json:"status"`
	DeadAt *time.Time `json:"deadAt"`
}

func (c StoryCookie) Active() bool {
	return c.Status == constants.StoryCookieStatusActive && strings.TrimSpace(c.Cookie) != ""
}

type StoryCrawlerConfig struct {
	Enabled          bool          `json:"enabled"`
	IntervalHours    int           `json:"intervalHours"`
	ImportNewStories bool          `json:"importNewStories"`
	RandomUserAgent  bool          `json:"randomUserAgent"`
	UseCookies       bool          `json:"useCookies"`
	Cookies          []StoryCookie `json:"cookies"`
}

func DefaultStoryCrawlerConfig() StoryCrawlerConfig {
	return StoryCrawlerConfig{IntervalHours: crawlerIntervalHours[0], Cookies: []StoryCookie{}}
}

func (c StoryCrawlerConfig) Interval() time.Duration {
	return time.Duration(c.IntervalHours) * time.Hour
}

func validCrawlerInterval(hours int) bool {
	for _, allowed := range crawlerIntervalHours {
		if hours == allowed {
			return true
		}
	}
	return false
}

func (s *Service) GetStoryCrawler() (StoryCrawlerConfig, error) {
	cfg, _, err := s.GetStoryCrawlerVersion()
	return cfg, err
}

func (s *Service) GetStoryCrawlerVersion() (StoryCrawlerConfig, *time.Time, error) {
	cfg := DefaultStoryCrawlerConfig()
	updatedAt, err := s.getVersioned(KeyStoryCrawler, &cfg)
	if !validCrawlerInterval(cfg.IntervalHours) {
		cfg.IntervalHours = DefaultStoryCrawlerConfig().IntervalHours
	}
	if cfg.Cookies == nil {
		cfg.Cookies = []StoryCookie{}
	}
	return cfg, updatedAt, err
}

func (s *Service) MarkStoryCookieDead(cookie string, at time.Time) (bool, error) {
	return s.repo.MarkCookieDead(KeyStoryCrawler, cookie, at)
}

type storyCookieInput struct {
	Name   *string    `json:"name"`
	Cookie *string    `json:"cookie"`
	Status *string    `json:"status"`
	DeadAt *time.Time `json:"deadAt"`
}

func ValidateStoryCrawlerValue(value models.JSONB) error {
	raw, err := json.Marshal(value)
	if err != nil {
		return errors.New("invalid story crawler config")
	}
	var cfg struct {
		Enabled          *bool               `json:"enabled"`
		IntervalHours    *int                `json:"intervalHours"`
		ImportNewStories *bool               `json:"importNewStories"`
		RandomUserAgent  *bool               `json:"randomUserAgent"`
		UseCookies       *bool               `json:"useCookies"`
		Cookies          *[]storyCookieInput `json:"cookies"`
	}
	decoder := json.NewDecoder(bytes.NewReader(raw))
	decoder.DisallowUnknownFields()
	if err := decoder.Decode(&cfg); err != nil {
		return errors.New("invalid story crawler config: " + err.Error())
	}
	if cfg.Enabled == nil || cfg.IntervalHours == nil || cfg.ImportNewStories == nil || cfg.RandomUserAgent == nil || cfg.UseCookies == nil || cfg.Cookies == nil {
		return errors.New("cấu hình cập nhật truyện cần đủ enabled, intervalHours, importNewStories, randomUserAgent, useCookies và cookies")
	}
	if !validCrawlerInterval(*cfg.IntervalHours) {
		return fmt.Errorf("chu kỳ cập nhật phải là một trong %v giờ", crawlerIntervalHours)
	}
	return validateStoryCookies(*cfg.Cookies)
}

func validateStoryCookies(cookies []storyCookieInput) error {
	if len(cookies) > constants.StoryCookieMaxCount {
		return fmt.Errorf("tối đa %d cookie", constants.StoryCookieMaxCount)
	}
	seen := make(map[string]bool, len(cookies))
	for i, item := range cookies {
		position := i + 1
		if item.Cookie == nil || strings.TrimSpace(*item.Cookie) == "" {
			return fmt.Errorf("cookie %d đang trống", position)
		}
		cookie := strings.TrimSpace(*item.Cookie)
		if len(cookie) > constants.StoryCookieMaxLength {
			return fmt.Errorf("cookie %d dài quá %d ký tự", position, constants.StoryCookieMaxLength)
		}
		if strings.IndexFunc(cookie, func(r rune) bool { return r < 0x20 || r == 0x7f }) >= 0 {
			return fmt.Errorf("cookie %d chứa ký tự xuống dòng hoặc ký tự điều khiển", position)
		}
		if seen[cookie] {
			return fmt.Errorf("cookie %d bị trùng với một cookie khác", position)
		}
		seen[cookie] = true
		if item.Status == nil || (*item.Status != constants.StoryCookieStatusActive && *item.Status != constants.StoryCookieStatusDead) {
			return fmt.Errorf("trạng thái cookie %d phải là %s hoặc %s", position, constants.StoryCookieStatusActive, constants.StoryCookieStatusDead)
		}
		if item.Name != nil && utf8.RuneCountInString(*item.Name) > constants.StoryCookieNameMaxRunes {
			return fmt.Errorf("tên cookie %d dài quá %d ký tự", position, constants.StoryCookieNameMaxRunes)
		}
	}
	return nil
}
