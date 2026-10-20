package adminpushcampaign

type CreateCampaignRequest struct {
	Audience string `json:"audience" binding:"required,oneof=all vip user" example:"all"`
	Username string `json:"username" binding:"omitempty,max=50" example:"okela"`
	Title    string `json:"title" binding:"required,max=100" example:"Sự kiện cuối tuần"`
	Body     string `json:"body" binding:"required,max=500" example:"Nhân đôi KEN khi nạp từ tối nay đến hết Chủ nhật!"`
}

type AudienceResponse struct {
	Users   int64 `json:"users"`
	Devices int64 `json:"devices"`
}

type UserBrief struct {
	ID       string `json:"id"`
	Username string `json:"username"`
	FullName string `json:"fullName,omitempty"`
	Avatar   string `json:"avatar,omitempty"`
}

type AdminBrief struct {
	ID       string `json:"id"`
	Username string `json:"username"`
	FullName string `json:"fullName,omitempty"`
}

type CampaignItem struct {
	ID           string      `json:"id"`
	Audience     string      `json:"audience"`
	TargetUser   *UserBrief  `json:"targetUser,omitempty"`
	Title        string      `json:"title"`
	Body         string      `json:"body"`
	Status       string      `json:"status"`
	TotalDevices int         `json:"totalDevices"`
	SuccessCount int         `json:"successCount"`
	FailureCount int         `json:"failureCount"`
	Error        string      `json:"error,omitempty"`
	CreatedBy    *AdminBrief `json:"createdBy,omitempty"`
	StartedAt    string      `json:"startedAt,omitempty"`
	FinishedAt   string      `json:"finishedAt,omitempty"`
	CreatedAt    string      `json:"createdAt"`
}

type CampaignListResponse struct {
	Items  []CampaignItem `json:"items"`
	Total  int64          `json:"total"`
	Limit  int            `json:"limit"`
	Offset int            `json:"offset"`
}
