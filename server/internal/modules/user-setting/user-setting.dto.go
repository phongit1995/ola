package usersetting

type UserSettingsResponse struct {
	MessagePrivacy  string `json:"messagePrivacy" example:"all"`
	MeVisibility    string `json:"meVisibility" example:"all"`
	CommentPrivacy  string `json:"commentPrivacy" example:"all"`
	ShowBirthday    bool   `json:"showBirthday" example:"true"`
	ShowInterested  bool   `json:"showInterested" example:"true"`
	NotifMessage    bool   `json:"notifMessage" example:"true"`
	NotifSound      bool   `json:"notifSound" example:"true"`
	SoundGame       bool   `json:"soundGame" example:"true"`
	SoundKen        bool   `json:"soundKen" example:"true"`
	FontSize        string `json:"fontSize" example:"medium"`
	WallpaperURL    string `json:"wallpaperUrl" example:""`
	VipStorePrivacy int16  `json:"vipStorePrivacy" example:"0"`
}

type UpdateSettingsRequest struct {
	MessagePrivacy *string `json:"messagePrivacy,omitempty" binding:"omitempty,oneof=all friends" example:"all"`
	MeVisibility   *string `json:"meVisibility,omitempty" binding:"omitempty,oneof=all friends" example:"all"`
	CommentPrivacy *string `json:"commentPrivacy,omitempty" binding:"omitempty,oneof=all friends" example:"all"`
	ShowBirthday   *bool   `json:"showBirthday,omitempty" example:"true"`
	ShowInterested *bool   `json:"showInterested,omitempty" example:"true"`
	NotifMessage   *bool   `json:"notifMessage,omitempty" example:"true"`
	NotifSound     *bool   `json:"notifSound,omitempty" example:"true"`
	SoundGame      *bool   `json:"soundGame,omitempty" example:"true"`
	SoundKen       *bool   `json:"soundKen,omitempty" example:"true"`
	FontSize       *string `json:"fontSize,omitempty" binding:"omitempty,oneof=small medium large" example:"medium"`
	WallpaperURL   *string `json:"wallpaperUrl,omitempty" binding:"omitempty,max=500" example:""`
}
