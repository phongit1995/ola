package websocket

import (
	"errors"
	"net/http"
	"ola-chat-server/internal/utils"
	"testing"
)

func TestReplyAckError(t *testing.T) {
	cases := []struct {
		name     string
		err      error
		wantCode any
	}{
		{"coded error", utils.NewHTTPErrorWithCode(http.StatusForbidden, "vip", "WORD_CHAIN_VIP_REQUIRED_VIEW"), "WORD_CHAIN_VIP_REQUIRED_VIEW"},
		{"plain error", errors.New("boom"), nil},
	}
	for _, tc := range cases {
		var got map[string]any
		replyAckError(func(args []any, _ error) { got = args[0].(map[string]any) }, tc.err)
		if got["ok"] != false || got["error"] != tc.err.Error() || got["code"] != tc.wantCode {
			t.Errorf("%s: got %v", tc.name, got)
		}
	}
	replyAckError(nil, errors.New("no ack"))
}
