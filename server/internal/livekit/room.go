package livekit

import (
	"context"
	"errors"
	"net/http"
	"strings"

	"ola-chat-server/internal/config"

	"github.com/livekit/protocol/auth"
	lkproto "github.com/livekit/protocol/livekit"
	"github.com/twitchtv/twirp"
)

var roomServiceHTTP = &http.Client{Timeout: RoomServiceTimeout}

func RemoveParticipant(ctx context.Context, cfg *config.Config, room, identity string) error {
	if !Configured(cfg) {
		return nil
	}
	ctx, err := withAdminAuth(ctx, cfg, &auth.VideoGrant{RoomAdmin: true, Room: room})
	if err != nil {
		return err
	}
	_, err = roomService(cfg).RemoveParticipant(ctx, &lkproto.RoomParticipantIdentity{Room: room, Identity: identity})
	return ignoreNotFound(err)
}

func DeleteRoom(ctx context.Context, cfg *config.Config, room string) error {
	if !Configured(cfg) {
		return nil
	}
	ctx, err := withAdminAuth(ctx, cfg, &auth.VideoGrant{RoomCreate: true})
	if err != nil {
		return err
	}
	_, err = roomService(cfg).DeleteRoom(ctx, &lkproto.DeleteRoomRequest{Room: room})
	return ignoreNotFound(err)
}

func roomService(cfg *config.Config) lkproto.RoomService {
	return lkproto.NewRoomServiceJSONClient(httpBaseURL(cfg.LiveKitURL), roomServiceHTTP)
}

func withAdminAuth(ctx context.Context, cfg *config.Config, grant *auth.VideoGrant) (context.Context, error) {
	token, err := auth.NewAccessToken(cfg.LiveKitAPIKey, cfg.LiveKitAPISecret).
		SetVideoGrant(grant).
		SetValidFor(AdminTokenTTL).
		ToJWT()
	if err != nil {
		return nil, err
	}
	header := http.Header{}
	header.Set("Authorization", "Bearer "+token)
	return twirp.WithHTTPRequestHeaders(ctx, header)
}

func ignoreNotFound(err error) error {
	var twirpErr twirp.Error
	if errors.As(err, &twirpErr) && twirpErr.Code() == twirp.NotFound {
		return nil
	}
	return err
}

func httpBaseURL(raw string) string {
	base := strings.TrimRight(raw, "/")
	switch {
	case strings.HasPrefix(base, "wss://"):
		return "https://" + strings.TrimPrefix(base, "wss://")
	case strings.HasPrefix(base, "ws://"):
		return "http://" + strings.TrimPrefix(base, "ws://")
	}
	return base
}
