package push

import (
	"testing"
	"time"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
)

func TestDMPreviewByMessageType(t *testing.T) {
	cases := []struct {
		name      string
		msgType   string
		content   string
		metadata  string
		wantText  string
		wantImage string
		wantPush  bool
	}{
		{"text", constants.MessageTypeText, "xin chào", "", "xin chào", "", true},
		{"sticker", constants.MessageTypeText, "[kul:12]", "", dmPreviewSticker, "", true},
		{"image", constants.MessageTypeImage, "", `{"url":"https://s3/a.webp"}`, dmPreviewImage, "https://s3/a.webp", true},
		{"image caption", constants.MessageTypeImage, "nhìn nè", `{"url":"https://s3/a.webp"}`, "📷 nhìn nè", "https://s3/a.webp", true},
		{"audio", constants.MessageTypeAudio, "", `{"url":"https://s3/a.m4a"}`, dmPreviewAudio, "", true},
		{"missed call", constants.MessageTypeCall, "", `{"callType":"audio","callStatus":"missed"}`, dmPreviewMissed, "", true},
		{"missed video", constants.MessageTypeCall, "", `{"callType":"video","callStatus":"missed"}`, dmPreviewMissedV, "", true},
		{"ended call", constants.MessageTypeCall, "", `{"callType":"audio","callStatus":"ended"}`, "", "", false},
		{"gift", constants.MessageTypeGift, "chúc mừng", `{"giftName":"Hoa hồng","quantity":3}`, "🎁 Đã tặng Hoa hồng ×3", "", true},
		{"gift no meta", constants.MessageTypeGift, "", "", dmPreviewGift, "", true},
	}
	for _, tc := range cases {
		got, push := DMPreview(tc.msgType, tc.content, tc.metadata)
		if push != tc.wantPush || got.Text != tc.wantText || got.ImageURL != tc.wantImage {
			t.Errorf("%s: got (%q, %q, %v), want (%q, %q, %v)", tc.name, got.Text, got.ImageURL, push, tc.wantText, tc.wantImage, tc.wantPush)
		}
	}
}

func TestAPNSMutableContentOnlyWithMedia(t *testing.T) {
	ios := models.DeviceToken{Token: "t", Platform: constants.PushPlatformIOS}
	plain := buildDMContent(DMPush{ConversationID: "c1", ConversationType: "direct", SenderName: "An", Preview: "hi"})
	if buildMessage(ios, plain, plain.Data, time.Hour).APNS.Payload.Aps.MutableContent {
		t.Fatal("plain DM without avatar or image must not set mutable-content")
	}
	rich := buildDMContent(DMPush{ConversationID: "c1", ConversationType: "direct", SenderName: "An", Preview: "hi", ImageURL: "https://s3/a.webp"})
	if rich.Data["imageUrl"] != "https://s3/a.webp" {
		t.Fatalf("imageUrl missing from data: %v", rich.Data)
	}
	if !buildMessage(ios, rich, rich.Data, time.Hour).APNS.Payload.Aps.MutableContent {
		t.Fatal("DM with image must set mutable-content")
	}
}

func TestDMTitlePrefersDisplayName(t *testing.T) {
	cases := []struct {
		in   DMPush
		want string
	}{
		{DMPush{SenderFullName: "Minh Anh", SenderName: "minhanh99"}, "Minh Anh"},
		{DMPush{SenderName: "minhanh99"}, "minhanh99"},
		{DMPush{ConversationName: "Nhóm bạn"}, "Nhóm bạn"},
		{DMPush{}, fallbackTitle},
	}
	for _, c := range cases {
		if got := buildDMContent(c.in).Title; got != c.want {
			t.Fatalf("title = %q, want %q", got, c.want)
		}
	}
}

func TestFriendContentPushBodies(t *testing.T) {
	post, ok := buildFriendContent(FriendContentPush{Kind: constants.FriendContentPost, ContentID: "p1", AuthorID: "a1", AuthorName: "Minh Anh", Preview: "Đi Đà Lạt không"})
	if !ok || post.Title != "Minh Anh" || post.Body != "Vừa đăng bài mới: Đi Đà Lạt không" {
		t.Fatalf("friend post push = %v %q / %q", ok, post.Title, post.Body)
	}
	if post.Data["type"] != PushDataTypeFriendContent || post.Data["contentId"] != "p1" || post.Data["kind"] != constants.FriendContentPost {
		t.Fatalf("friend post data = %v", post.Data)
	}
	imageOnly, _ := buildFriendContent(FriendContentPush{Kind: constants.FriendContentPost, AuthorName: "Minh Anh"})
	if imageOnly.Body != "Vừa đăng bài mới" {
		t.Fatalf("friend post without text = %q", imageOnly.Body)
	}
	moment, _ := buildFriendContent(FriendContentPush{Kind: constants.FriendContentMoment, ContentID: "m1", AuthorName: "Minh Anh", Preview: "ignored"})
	if moment.Body != "Vừa đăng khoảnh khắc mới" || moment.NotifID != "friend:m1" {
		t.Fatalf("friend moment push = %q %q", moment.Body, moment.NotifID)
	}
	if _, ok := buildFriendContent(FriendContentPush{Kind: "story"}); ok {
		t.Fatal("unknown kinds must not build a push")
	}
}
