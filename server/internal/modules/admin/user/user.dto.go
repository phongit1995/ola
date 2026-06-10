package adminuser

type UserListItem struct {
	ID          string `json:"id"`
	Username    string `json:"username"`
	FullName    string `json:"fullName,omitempty"`
	Email       string `json:"email,omitempty"`
	Avatar      string `json:"avatar,omitempty"`
	IsActive    bool   `json:"isActive"`
	CreatedAt   string `json:"createdAt"`
	LastLoginAt string `json:"lastLoginAt,omitempty"`
}

type ListUsersResponse struct {
	Items  []UserListItem `json:"items"`
	Total  int64          `json:"total"`
	Limit  int            `json:"limit"`
	Offset int            `json:"offset"`
}

type UserDetail struct {
	ID          string `json:"id"`
	Username    string `json:"username"`
	FullName    string `json:"fullName,omitempty"`
	Email       string `json:"email,omitempty"`
	Avatar      string `json:"avatar,omitempty"`
	Phone       string `json:"phone,omitempty"`
	Bio         string `json:"bio,omitempty"`
	IsActive    bool   `json:"isActive"`
	LastLoginIP string `json:"lastLoginIp,omitempty"`
	LastLoginAt string `json:"lastLoginAt,omitempty"`
	CreatedAt   string `json:"createdAt"`
	UpdatedAt   string `json:"updatedAt"`
}

type UpdateStatusRequest struct {
	IsActive *bool `json:"isActive" binding:"required" example:"false"`
}
