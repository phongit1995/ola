package setting

import "time"

const KeyStoryCrawlerRookies = "story_crawler_rookies"

func (s *Service) GetRookiesCrawler() (StoryCrawlerConfig, error) {
	cfg, _, err := s.GetRookiesCrawlerVersion()
	return cfg, err
}

func (s *Service) GetRookiesCrawlerVersion() (StoryCrawlerConfig, *time.Time, error) {
	return s.crawlerConfigVersion(KeyStoryCrawlerRookies)
}

func (s *Service) MarkRookiesCookieDead(cookie string, at time.Time) (bool, error) {
	return s.markCookieDead(KeyStoryCrawlerRookies, cookie, at)
}
