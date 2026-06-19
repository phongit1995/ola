package admin

import (
	adminauth "ola-chat-server/internal/modules/admin/auth"
	adminme "ola-chat-server/internal/modules/admin/me"
	adminroom "ola-chat-server/internal/modules/admin/room"
	adminupload "ola-chat-server/internal/modules/admin/upload"
	adminuser "ola-chat-server/internal/modules/admin/user"
	adminvip "ola-chat-server/internal/modules/admin/vip"

	"go.uber.org/dig"
)

func Provider(c *dig.Container) error {
	if err := adminauth.Provider(c); err != nil {
		return err
	}
	if err := adminuser.Provider(c); err != nil {
		return err
	}
	if err := adminme.Provider(c); err != nil {
		return err
	}
	if err := adminroom.Provider(c); err != nil {
		return err
	}
	if err := adminupload.Provider(c); err != nil {
		return err
	}
	if err := adminvip.Provider(c); err != nil {
		return err
	}

	return c.Provide(NewRouter)
}
