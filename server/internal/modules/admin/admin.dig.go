package admin

import (
	adminauth "ola-chat-server/internal/modules/admin/auth"
	adminegg "ola-chat-server/internal/modules/admin/egg"
	adminken "ola-chat-server/internal/modules/admin/ken"
	adminme "ola-chat-server/internal/modules/admin/me"
	adminpen "ola-chat-server/internal/modules/admin/pen"
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
	if err := adminegg.Provider(c); err != nil {
		return err
	}
	if err := adminken.Provider(c); err != nil {
		return err
	}
	if err := adminpen.Provider(c); err != nil {
		return err
	}

	return c.Provide(NewRouter)
}
