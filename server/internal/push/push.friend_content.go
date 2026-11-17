package push

import (
	"time"

	"ola-chat-server/internal/constants"
)

type FriendContentPush struct {
	Kind       string
	ContentID  string
	AuthorID   string
	AuthorName string
	Preview    string
}

var friendContentBodies = map[string]string{
	constants.FriendContentPost:   "Vừa đăng bài mới",
	constants.FriendContentMoment: "Vừa đăng khoảnh khắc mới",
}

func buildFriendContent(in FriendContentPush) (Content, bool) {
	body, ok := friendContentBodies[in.Kind]
	if !ok {
		return Content{}, false
	}
	if in.Kind == constants.FriendContentPost && in.Preview != "" {
		body += ": " + excerpt(in.Preview)
	}
	return Content{
		Title:   firstNonEmpty(in.AuthorName, fallbackTitle),
		Body:    body,
		NotifID: constants.PushFriendContentNotifID(in.ContentID),
		Channel: PushChannelSocial,
		Data: map[string]string{
			"type":      PushDataTypeFriendContent,
			"kind":      in.Kind,
			"contentId": in.ContentID,
			"authorId":  in.AuthorID,
		},
	}, true
}

func (s *Sender) SendFriendContent(recipientID string, in FriendContentPush) {
	if recipientID == "" || recipientID == in.AuthorID {
		return
	}
	content, ok := buildFriendContent(in)
	if !ok {
		return
	}
	content.Seq = time.Now().UnixNano()
	s.enqueue(func() {
		s.process(recipientID, constants.PushSourceFriendContent, in.ContentID, false, content)
	})
}
