package push

import (
	"encoding/json"
	"regexp"
	"strconv"
	"strings"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
)

var stickerToken = regexp.MustCompile(`^\[kul:\d{1,2}\]$`)

type dmMediaMetadata struct {
	URL string `json:"url"`
}

type dmCallMetadata struct {
	CallType   string `json:"callType"`
	CallStatus string `json:"callStatus"`
}

type dmGiftMetadata struct {
	GiftName string `json:"giftName"`
	Quantity int    `json:"quantity"`
}

type DMMessagePreview struct {
	Text     string
	ImageURL string
}

func DMPreview(messageType, content, metadata string) (DMMessagePreview, bool) {
	text := strings.TrimSpace(content)
	switch messageType {
	case constants.MessageTypeImage:
		var meta dmMediaMetadata
		_ = json.Unmarshal([]byte(metadata), &meta)
		if text == "" {
			text = dmPreviewImage
		} else {
			text = "📷 " + text
		}
		return DMMessagePreview{Text: text, ImageURL: meta.URL}, true
	case constants.MessageTypeAudio:
		return DMMessagePreview{Text: dmPreviewAudio}, true
	case constants.MessageTypeCall:
		var meta dmCallMetadata
		if json.Unmarshal([]byte(metadata), &meta) != nil || meta.CallStatus != string(models.CallStatusMissed) {
			return DMMessagePreview{}, false
		}
		if meta.CallType == string(models.CallTypeVideo) {
			return DMMessagePreview{Text: dmPreviewMissedV}, true
		}
		return DMMessagePreview{Text: dmPreviewMissed}, true
	case constants.MessageTypeGift:
		var meta dmGiftMetadata
		if json.Unmarshal([]byte(metadata), &meta) != nil || meta.GiftName == "" {
			return DMMessagePreview{Text: dmPreviewGift}, true
		}
		gift := "🎁 Đã tặng " + meta.GiftName
		if meta.Quantity > 1 {
			gift += " ×" + strconv.Itoa(meta.Quantity)
		}
		return DMMessagePreview{Text: gift}, true
	}
	if stickerToken.MatchString(text) {
		return DMMessagePreview{Text: dmPreviewSticker}, true
	}
	return DMMessagePreview{Text: text}, true
}
