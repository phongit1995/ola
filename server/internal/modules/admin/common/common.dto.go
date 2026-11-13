package admincommon

import (
	userModule "ola-chat-server/internal/modules/user"

	"github.com/google/uuid"
)

type UserBrief = userModule.UserSummary

func UserBriefOf(id uuid.UUID, username, fullName, avatar string) UserBrief {
	return userModule.UserSummaryOf(id, username, fullName, avatar)
}
