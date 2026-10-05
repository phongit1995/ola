package story

import "go.uber.org/dig"

func Provider(c *dig.Container) error {
	providers := []interface{}{
		NewRepository,
		NewVnkingsSource,
		NewService,
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
