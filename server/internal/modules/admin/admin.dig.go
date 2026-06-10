package admin

import (
	adminauth "ola-chat-server/internal/modules/admin/auth"

	"go.uber.org/dig"
)

func Provider(c *dig.Container) error {
	if err := adminauth.Provider(c); err != nil {
		return err
	}

	return c.Provide(NewRouter)
}
