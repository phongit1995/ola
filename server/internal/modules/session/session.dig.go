package session

import "go.uber.org/dig"

func Provider(c *dig.Container) error {
	providers := []interface{}{
		NewRepository,
		NewService,
	}

	for _, p := range providers {
		if err := c.Provide(p); err != nil {
			return err
		}
	}

	return nil
}
