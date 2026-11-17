package game

import (
	"context"
	"fmt"

	"ola-chat-server/internal/game/engine"
	"ola-chat-server/internal/game/protocol"
	"ola-chat-server/internal/livekit"
	"ola-chat-server/internal/utils"

	"github.com/zishang520/socket.io/servers/socket/v3"
)

func (s *Server) voiceToken(client *socket.Socket, data *SocketData, request protocol.VoiceTokenRequest) {
	client.Emit(messageEvent, protocol.OutEnvelope{
		Type: protocol.S2CVoiceToken,
		Data: s.voiceTokenFor(client.Id(), data, request),
	})
}

func (s *Server) voiceTokenFor(socketID socket.SocketId, data *SocketData, request protocol.VoiceTokenRequest) protocol.VoiceTokenData {
	reply := protocol.VoiceTokenData{RoomID: request.RoomID}
	if !livekit.Configured(s.cfg) {
		reply.Error = protocol.ErrorCodeVoiceUnavailable
		return reply
	}
	access, err := s.engine.VoiceAccess(data.GameID, data.UserID, request.RoomID, request.MatchID, s.isWatchingRoom(socketID, request.RoomID))
	switch {
	case err != nil:
		s.logger.Warnw("Failed to resolve voice access", "user_id", data.UserID, "room_id", request.RoomID, "match_id", request.MatchID, "error", err)
		reply.Error = protocol.ErrorCodeVoiceUnavailable
		return reply
	case access.RoomID == "":
		reply.Error = protocol.ErrorCodeVoiceNotMember
		return reply
	case !access.Enabled:
		reply.RoomID = access.RoomID
		reply.Error = protocol.ErrorCodeVoiceDisabled
		return reply
	case access.Role == engine.VoiceRoleNone:
		reply.RoomID = access.RoomID
		reply.Error = protocol.ErrorCodeVoiceNotMember
		return reply
	}

	canSpeak := access.Role == engine.VoiceRoleSpeaker
	token, err := livekit.MintToken(s.cfg, livekit.Grant{
		Identity:   data.UserID,
		Name:       data.Name,
		Room:       voiceRoomName(data.GameID, access.RoomID),
		CanPublish: canSpeak,
		VoiceOnly:  true,
		ValidFor:   VoiceTokenTTL,
	})
	if err != nil {
		s.logger.Errorw("Failed to mint voice token", "user_id", data.UserID, "room_id", access.RoomID, "error", err)
		reply.Error = protocol.ErrorCodeVoiceUnavailable
		return reply
	}
	return protocol.VoiceTokenData{
		RoomID:   access.RoomID,
		URL:      s.cfg.LiveKitURL,
		Token:    token,
		CanSpeak: canSpeak,
	}
}

func (s *Server) RemoveVoiceMember(gameID, roomID, userID string) {
	s.revokeVoice(func(ctx context.Context) error {
		return livekit.RemoveParticipant(ctx, s.cfg, voiceRoomName(gameID, roomID), userID)
	}, "room_id", roomID, "user_id", userID)
}

func (s *Server) CloseVoiceRoom(gameID, roomID string) {
	s.revokeVoice(func(ctx context.Context) error {
		return livekit.DeleteRoom(ctx, s.cfg, voiceRoomName(gameID, roomID))
	}, "room_id", roomID)
}

func (s *Server) revokeVoice(call func(ctx context.Context) error, fields ...any) {
	if !livekit.Configured(s.cfg) {
		return
	}
	utils.SafeGo(s.logger, func() {
		ctx, cancel := context.WithTimeout(context.Background(), VoiceRevokeTimeout)
		defer cancel()
		if err := call(ctx); err != nil {
			s.logger.Warnw("Failed to revoke voice access", append(fields, "error", err)...)
		}
	})
}

func voiceRoomName(gameID, roomID string) string {
	return fmt.Sprintf(VoiceRoomNameFormat, gameID, roomID)
}

func (s *Server) isWatchingRoom(socketID socket.SocketId, roomID string) bool {
	if roomID == "" {
		return false
	}
	s.connMu.Lock()
	defer s.connMu.Unlock()
	return s.roomWatching[socketID] == roomID
}
