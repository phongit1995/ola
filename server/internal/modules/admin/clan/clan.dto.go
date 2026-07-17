package adminclan

type ClanUserResponse struct {
	ID       string `json:"id"`
	Username string `json:"username"`
	FullName string `json:"fullName,omitempty"`
	Avatar   string `json:"avatar,omitempty"`
}

type ClanResponse struct {
	ID               string            `json:"id"`
	Handle           string            `json:"handle"`
	Description      string            `json:"description,omitempty"`
	Avatar           string            `json:"avatar,omitempty"`
	Cover            string            `json:"cover,omitempty"`
	Policy           int16             `json:"policy"`
	MemberPublicPost bool              `json:"memberPublicPost"`
	MemberCount      int               `json:"memberCount"`
	VisitCount       int64             `json:"visitCount"`
	RoomID           string            `json:"roomId,omitempty"`
	Owner            *ClanUserResponse `json:"owner,omitempty"`
	CreatedAt        string            `json:"createdAt"`
}

type ClanListResponse struct {
	Items  []ClanResponse `json:"items"`
	Total  int64          `json:"total"`
	Limit  int            `json:"limit"`
	Offset int            `json:"offset"`
}

type MemberResponse struct {
	User     *ClanUserResponse `json:"user"`
	Role     string            `json:"role"`
	Verified bool              `json:"verified"`
	JoinedAt string            `json:"joinedAt"`
}

type MemberListResponse struct {
	Items  []MemberResponse `json:"items"`
	Total  int64            `json:"total"`
	Limit  int              `json:"limit"`
	Offset int              `json:"offset"`
}
