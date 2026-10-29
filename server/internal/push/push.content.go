package push

import (
	"strconv"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/utils"
)

type Content struct {
	Title    string
	Body     string
	NotifID  string
	Channel  string
	Collapse string
	Data     map[string]string
	Seq      int64
}

type DMPush struct {
	ConversationID   string
	ConversationType string
	MessageID        string
	SenderID         string
	SenderName       string
	SenderAvatar     string
	ConversationName string
	Preview          string
	SentAt           string
	UnreadCount      int
	UnreadByUser     map[string]int
}

const fallbackTitle = "Okela"

func excerpt(s string) string {
	trimmed := utils.TruncateRunes(s, PushExcerptMaxRunes)
	if trimmed != s {
		return trimmed + "…"
	}
	return s
}

func withUnread(data map[string]string, unread int) {
	if unread > 0 {
		data["unreadCount"] = strconv.Itoa(unread)
	}
}

func firstNonEmpty(values ...string) string {
	for _, v := range values {
		if v != "" {
			return v
		}
	}
	return ""
}

func buildDMContent(in DMPush) Content {
	notifID := constants.PushDMSource(in.ConversationID)
	data := map[string]string{
		"type":           PushDataTypeDM,
		"conversationId": in.ConversationID,
		"senderId":       in.SenderID,
	}
	if in.SenderAvatar != "" {
		data["senderAvatar"] = in.SenderAvatar
	}
	if in.SentAt != "" {
		data["sentAt"] = in.SentAt
	}
	withUnread(data, in.UnreadCount)
	return Content{
		Title:    firstNonEmpty(in.SenderName, in.ConversationName, fallbackTitle),
		Body:     excerpt(firstNonEmpty(in.Preview, "Bạn có tin nhắn mới")),
		NotifID:  notifID,
		Channel:  PushChannelMessages,
		Collapse: PushCollapseDM,
		Data:     data,
	}
}

var meNotifBodies = map[string]string{
	models.MeNotificationLike:        "Đã thích trạng thái của bạn",
	models.MeNotificationComment:     "Đã bình luận về trạng thái của bạn",
	models.MeNotificationReply:       "Đã trả lời bình luận của bạn",
	models.MeNotificationMention:     "Đã nhắc đến bạn trong một trạng thái",
	models.MeNotificationCommentLike: "Đã thích bình luận của bạn",

	models.MeNotificationMomentComment:  "Đã bình luận về khoảnh khắc của bạn",
	models.MeNotificationMomentReaction: "Đã bày tỏ cảm xúc về khoảnh khắc của bạn",
}

var meNotifPreviewTypes = map[string]bool{
	models.MeNotificationComment: true,
	models.MeNotificationReply:   true,
	models.MeNotificationMention: true,

	models.MeNotificationMomentComment: true,
}

func withItemID(data map[string]string, id string) {
	if id != "" {
		data["itemId"] = id
	}
}

func withOthers(actorName string, actorCount int) string {
	if actorName == "" || actorCount <= 1 {
		return actorName
	}
	return actorName + " và " + strconv.Itoa(actorCount-1) + " người khác"
}

func buildMeNotifContent(id, actorName, ntype, preview string, actorCount, unread int) Content {
	body, known := meNotifBodies[ntype]
	if !known {
		body = "Bạn có thông báo mới"
	}
	if known && preview != "" && meNotifPreviewTypes[ntype] {
		body += ": " + excerpt(preview)
	}
	data := map[string]string{
		"type": PushDataTypeMeNotif,
	}
	withItemID(data, id)
	withUnread(data, unread)
	return Content{
		Title:    firstNonEmpty(withOthers(actorName, actorCount), fallbackTitle),
		Body:     body,
		NotifID:  constants.PushSourceMeNotif,
		Channel:  PushChannelSocial,
		Collapse: constants.PushSourceMeNotif,
		Data:     data,
	}
}

var appNotifBodies = map[string]string{
	models.AppNotificationFriendRequest:    "Đã gửi cho bạn lời mời kết bạn",
	models.AppNotificationMarriageProposal: "Muốn cầu hôn bạn",
	models.AppNotificationClanRoleAssigned: "Bạn được gán vai trò mới trong Clan",
	models.AppNotificationClanRoleRevoked:  "Vai trò của bạn trong Clan đã bị gỡ",
	models.AppNotificationClanVerified:     "Clan của bạn đã được xác minh",
	models.AppNotificationClanUnverified:   "Clan của bạn đã bị bỏ xác minh",
	models.AppNotificationClanBanned:       "Clan của bạn đã bị khoá",
}

var appNotifSystemTypes = map[string]bool{
	models.AppNotificationClanRoleAssigned: true,
	models.AppNotificationClanRoleRevoked:  true,
	models.AppNotificationClanVerified:     true,
	models.AppNotificationClanUnverified:   true,
	models.AppNotificationClanBanned:       true,
}

func buildAppNotifContent(id, actorName, ntype, preview string, unread int) Content {
	body, known := appNotifBodies[ntype]
	if !known {
		body = "Bạn có thông báo mới"
	}
	title := fallbackTitle
	if !appNotifSystemTypes[ntype] {
		title = firstNonEmpty(actorName, fallbackTitle)
	}
	if known && preview != "" && appNotifSystemTypes[ntype] {
		body += ": " + excerpt(preview)
	}
	data := map[string]string{
		"type": PushDataTypeAppNotif,
	}
	withItemID(data, id)
	withUnread(data, unread)
	return Content{
		Title:    title,
		Body:     body,
		NotifID:  constants.PushSourceAppNotif,
		Channel:  PushChannelSystem,
		Collapse: constants.PushSourceAppNotif,
		Data:     data,
	}
}
