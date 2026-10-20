package report

type CreateReportRequest struct {
	TargetType string `json:"targetType" binding:"required" example:"room_message"`
	TargetID   string `json:"targetId" binding:"required,max=64" example:"7c9e6679-7425-40de-944b-e07fc1f90ae7"`
	ContextID  string `json:"contextId" binding:"omitempty,max=64" example:"0b6f4c1e-3c55-4f0a-9a43-2f8b8c1d2e10"`
	Reason     string `json:"reason" binding:"required" example:"spam"`
	Note       string `json:"note" binding:"omitempty,max=2000" example:"Spam link lừa đảo"`
}

type ReportResponse struct {
	ID        string `json:"id"`
	Status    string `json:"status"`
	CreatedAt string `json:"createdAt"`
}
