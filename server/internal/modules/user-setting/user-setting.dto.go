package usersetting

type UserSettingsResponse struct {
	MessagePrivacy string `json:"messagePrivacy" example:"all"`
	MeVisibility   string `json:"meVisibility" example:"all"`
	CommentPrivacy string `json:"commentPrivacy" example:"all"`
	ShowOnline     bool   `json:"showOnline" example:"true"`
	ShowBirthday   bool   `json:"showBirthday" example:"true"`
	NotifMessage   bool   `json:"notifMessage" example:"true"`
	NotifSound     bool   `json:"notifSound" example:"true"`
	NotifVibrate   bool   `json:"notifVibrate" example:"true"`
	FontSize       string `json:"fontSize" example:"medium"`
	WallpaperURL   string `json:"wallpaperUrl" example:""`
}

type UpdateSettingsRequest struct {
	MessagePrivacy *string `json:"messagePrivacy,omitempty" binding:"omitempty,oneof=all friends nobody" example:"all"`
	MeVisibility   *string `json:"meVisibility,omitempty" binding:"omitempty,oneof=all friends private" example:"all"`
	CommentPrivacy *string `json:"commentPrivacy,omitempty" binding:"omitempty,oneof=all friends" example:"all"`
	ShowOnline     *bool   `json:"showOnline,omitempty" example:"true"`
	ShowBirthday   *bool   `json:"showBirthday,omitempty" example:"true"`
	NotifMessage   *bool   `json:"notifMessage,omitempty" example:"true"`
	NotifSound     *bool   `json:"notifSound,omitempty" example:"true"`
	NotifVibrate   *bool   `json:"notifVibrate,omitempty" example:"true"`
	FontSize       *string `json:"fontSize,omitempty" binding:"omitempty,oneof=small medium large" example:"medium"`
	WallpaperURL   *string `json:"wallpaperUrl,omitempty" binding:"omitempty,max=500" example:""`
}
