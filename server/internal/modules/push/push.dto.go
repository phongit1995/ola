package push

type RegisterTokenRequest struct {
	Token string `json:"token" binding:"required"`
}
