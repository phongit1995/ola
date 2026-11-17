package livekit

import (
	"time"

	"ola-chat-server/internal/config"

	"github.com/livekit/protocol/auth"
	lkproto "github.com/livekit/protocol/livekit"
)

type Grant struct {
	Identity   string
	Name       string
	Room       string
	CanPublish bool
	VoiceOnly  bool
	ValidFor   time.Duration
}

func Configured(cfg *config.Config) bool {
	return cfg != nil && cfg.LiveKitURL != "" && cfg.LiveKitAPIKey != "" && cfg.LiveKitAPISecret != ""
}

func MintToken(cfg *config.Config, grant Grant) (string, error) {
	video := &auth.VideoGrant{RoomJoin: true, Room: grant.Room}
	video.SetCanPublish(grant.CanPublish)
	video.SetCanSubscribe(true)
	if grant.VoiceOnly {
		video.SetCanPublishData(false)
		if grant.CanPublish {
			video.SetCanPublishSources([]lkproto.TrackSource{lkproto.TrackSource_MICROPHONE})
		}
	}
	token := auth.NewAccessToken(cfg.LiveKitAPIKey, cfg.LiveKitAPISecret).
		SetVideoGrant(video).
		SetIdentity(grant.Identity).
		SetValidFor(grant.ValidFor)
	if grant.Name != "" {
		token.SetName(grant.Name)
	}
	return token.ToJWT()
}
