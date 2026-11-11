package adminavatarframe

type GrantUserFrameRequest struct {
	FrameID string `json:"frameId" binding:"required" example:"001"`
}
