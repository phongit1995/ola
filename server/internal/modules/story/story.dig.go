package story

import "go.uber.org/dig"

func Provider(c *dig.Container) error {
	providers := []interface{}{
		NewRepository,
		NewVnkingsService,
		NewRookiesService,
		NewViewCounter,
		NewService,
		NewCrawler,
		NewRookiesCrawler,
		NewController,
		NewRouter,
	}

	for _, p := range providers {
		if err := c.Provide(p); err != nil {
			return err
		}
	}

	return nil
}
