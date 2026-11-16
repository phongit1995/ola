package friendcontent

import "go.uber.org/dig"

func Provider(c *dig.Container) error {
	providers := []interface{}{
		NewRepository,
		NewEventHandler,
	}

	for _, provider := range providers {
		if err := c.Provide(provider); err != nil {
			return err
		}
	}

	return nil
}
