package friendcontent

type Event struct {
	AuthorID  string `json:"authorId"`
	Kind      string `json:"kind"`
	ContentID string `json:"contentId"`
	Preview   string `json:"preview,omitempty"`
}

type authorPayload struct {
	ID            string  `json:"id"`
	Username      string  `json:"username"`
	FullName      string  `json:"fullName,omitempty"`
	Avatar        string  `json:"avatar,omitempty"`
	AvatarFrameID *string `json:"avatarFrameId,omitempty"`
}

type noticePayload struct {
	Kind      string         `json:"kind"`
	ContentID string         `json:"contentId"`
	Author    *authorPayload `json:"author"`
	Preview   string         `json:"preview,omitempty"`
}
