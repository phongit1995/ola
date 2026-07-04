package adminuser

type UserListItem struct {
	ID          string `json:"id"`
	Username    string `json:"username"`
	FullName    string `json:"fullName,omitempty"`
	Email       string `json:"email,omitempty"`
	Avatar      string `json:"avatar,omitempty"`
	Gender      string `json:"gender,omitempty"`
	Ken         int    `json:"ken"`
	IsVip       bool   `json:"isVip"`
	IsActive    bool   `json:"isActive"`
	CreatedAt   string `json:"createdAt"`
	LastLoginAt string `json:"lastLoginAt,omitempty"`
	DeletedAt   string `json:"deletedAt,omitempty"`
}

type ListUsersResponse struct {
	Items  []UserListItem `json:"items"`
	Total  int64          `json:"total"`
	Limit  int            `json:"limit"`
	Offset int            `json:"offset"`
}

type UserDetail struct {
	ID             string `json:"id"`
	Username       string `json:"username"`
	FullName       string `json:"fullName,omitempty"`
	Email          string `json:"email,omitempty"`
	Avatar         string `json:"avatar,omitempty"`
	Phone          string `json:"phone,omitempty"`
	Bio            string `json:"bio,omitempty"`
	Gender         string `json:"gender,omitempty"`
	DateOfBirth    string `json:"dateOfBirth,omitempty"`
	Ken            int    `json:"ken"`
	IsVip          bool   `json:"isVip"`
	VipUsed        string `json:"vipUsed,omitempty"`
	VipEndTime     string `json:"vipEndTime,omitempty"`
	FollowerCount  int    `json:"followerCount"`
	FollowingCount int    `json:"followingCount"`
	IsActive       bool   `json:"isActive"`
	LastLoginIP    string `json:"lastLoginIp,omitempty"`
	LastLoginAt    string `json:"lastLoginAt,omitempty"`
	CreatedAt      string `json:"createdAt"`
	UpdatedAt      string `json:"updatedAt"`
	DeletedAt      string `json:"deletedAt,omitempty"`
}

type VipIconItem struct {
	InstanceID string `json:"instanceId"`
	TypeID     int16  `json:"typeId"`
	IsLocked   bool   `json:"isLocked"`
	IsUsing    bool   `json:"isUsing"`
	Source     string `json:"source,omitempty"`
	AcquiredAt string `json:"acquiredAt,omitempty"`
}

type VipIconListResponse struct {
	Items  []VipIconItem `json:"items"`
	Total  int64         `json:"total"`
	Limit  int           `json:"limit"`
	Offset int           `json:"offset"`
}

type ListFilter struct {
	Query          string
	IsActive       *bool
	Gender         string
	Vip            *bool
	IncludeDeleted bool
	SortBy         string
	SortDir        string
	Limit          int
	Offset         int
}

type UpdateStatusRequest struct {
	IsActive *bool `json:"isActive" binding:"required" example:"false"`
}

type UpdateUsernameRequest struct {
	Username string `json:"username" binding:"required" example:"john_doe"`
}
