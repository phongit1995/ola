package admin

import (
	adminauth "ola-chat-server/internal/modules/admin/auth"
	adminegg "ola-chat-server/internal/modules/admin/egg"
	adminken "ola-chat-server/internal/modules/admin/ken"
	adminkenchest "ola-chat-server/internal/modules/admin/kenchest"
	adminme "ola-chat-server/internal/modules/admin/me"
	adminpen "ola-chat-server/internal/modules/admin/pen"
	adminroom "ola-chat-server/internal/modules/admin/room"
	adminupload "ola-chat-server/internal/modules/admin/upload"
	adminuser "ola-chat-server/internal/modules/admin/user"
	adminvip "ola-chat-server/internal/modules/admin/vip"
	adminwheel "ola-chat-server/internal/modules/admin/wheel"

	"go.uber.org/dig"
)

func Provider(c *dig.Container) error {
	modules := []func(*dig.Container) error{
		adminauth.Provider,
		adminuser.Provider,
		adminme.Provider,
		adminroom.Provider,
		adminupload.Provider,
		adminvip.Provider,
		adminegg.Provider,
		adminwheel.Provider,
		adminken.Provider,
		adminkenchest.Provider,
		adminpen.Provider,
	}

	for _, module := range modules {
		if err := module(c); err != nil {
			return err
		}
	}

	return c.Provide(NewRouter)
}
