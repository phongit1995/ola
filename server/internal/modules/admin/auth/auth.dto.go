package adminauth

type LoginRequest struct {
	Username string `json:"username" binding:"required" example:"admin"`
	Password string `json:"password" binding:"required" example:"admin@123"`
}

type RefreshTokenRequest struct {
	RefreshToken string `json:"refreshToken" binding:"required" example:"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."`
}

type AdminDTO struct {
	ID       string `json:"id" example:"550e8400-e29b-41d4-a716-446655440000"`
	Username string `json:"username" example:"admin"`
	FullName string `json:"fullName,omitempty" example:"Super Admin"`
	Email    string `json:"email,omitempty" example:"admin@example.com"`
	Avatar   string `json:"avatar,omitempty"`
	Role     string `json:"role" example:"SUPER_ADMIN"`
}

type LoginResponse struct {
	Token        string   `json:"token"`
	RefreshToken string   `json:"refreshToken"`
	Admin        AdminDTO `json:"admin"`
}

type RefreshTokenResponse struct {
	Token        string `json:"token"`
	RefreshToken string `json:"refreshToken"`
}
