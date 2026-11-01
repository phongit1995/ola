package moderation

import (
	"time"

	"ola-chat-server/internal/constants"
)

const (
	SourceReport = "report"
	SourceMeHide = "me_hide"

	SeverityNone       = "none"
	SeverityViolation  = "violation"
	SeverityDeliberate = "deliberate"

	ErrorCodePostHiddenByAdmin = "ME_POST_HIDDEN_BY_ADMIN"

	ViolationNoteMaxRunes = 1000
	ViolationListLimit    = 100

	reasonSpam       = "spam"
	reasonSensitive  = "sensitive"
	reasonScam       = "scam"
	reasonHarassment = "harassment"
	reasonOther      = "other"

	lockTimeLayout = "15:04 02/01/2006"
)

var vietnamTime = time.FixedZone("ICT", 7*60*60)

var reasonLabels = map[string]string{
	reasonSpam:       "spam / quảng cáo",
	reasonSensitive:  "nội dung nhạy cảm",
	reasonScam:       "lừa đảo",
	reasonHarassment: "quấy rối / xúc phạm",
	reasonOther:      "vi phạm tiêu chuẩn cộng đồng",
}

var contentLabels = map[string]string{
	constants.ReportTargetAccount:      "Tài khoản",
	constants.ReportTargetPost:         "Bài viết",
	constants.ReportTargetComment:      "Bình luận",
	constants.ReportTargetStoryComment: "Bình luận truyện",
	constants.ReportTargetMessage:      "Tin nhắn",
	constants.ReportTargetRoomMessage:  "Tin nhắn trong phòng",
	constants.ReportTargetMoment:       "Khoảnh khắc",
}

var hiddenTargets = map[string]bool{
	constants.ReportTargetPost:   true,
	constants.ReportTargetMoment: true,
}
