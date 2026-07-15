package admin

import (
	adminaudit "ola-chat-server/internal/modules/admin/audit"
	adminauth "ola-chat-server/internal/modules/admin/auth"
	admindashboard "ola-chat-server/internal/modules/admin/dashboard"
	adminegg "ola-chat-server/internal/modules/admin/egg"
	adminken "ola-chat-server/internal/modules/admin/ken"
	adminkenchest "ola-chat-server/internal/modules/admin/kenchest"
	adminme "ola-chat-server/internal/modules/admin/me"
	adminminigame "ola-chat-server/internal/modules/admin/mini-game"
	adminpen "ola-chat-server/internal/modules/admin/pen"
	adminroom "ola-chat-server/internal/modules/admin/room"
	adminsetting "ola-chat-server/internal/modules/admin/setting"
	adminupload "ola-chat-server/internal/modules/admin/upload"
	adminuser "ola-chat-server/internal/modules/admin/user"
	adminvip "ola-chat-server/internal/modules/admin/vip"
	adminwheel "ola-chat-server/internal/modules/admin/wheel"

	"go.uber.org/dig"
)

func Provider(c *dig.Container) error {
	modules := []func(*dig.Container) error{
		adminaudit.Provider,
		admindashboard.Provider,
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
		adminsetting.Provider,
		adminminigame.Provider,
	}

	for _, module := range modules {
		if err := module(c); err != nil {
			return err
		}
	}

	return c.Provide(NewRouter)
}
