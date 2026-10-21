package setting

import (
	"crypto/sha256"
	"encoding/hex"
	"encoding/json"
	"strings"

	"go.uber.org/zap"
)

// Keys of GET /settings/app. A key's payload is the same as its standalone endpoint, so clients can
// switch over without remapping. Renaming a key or changing the meaning of an existing field breaks
// released apps; add a new field or key instead.
const (
	AppConfigKeyTopup          = "topup"
	AppConfigKeyUsernameChange = "usernameChange"
	AppConfigKeyWordChain      = "wordChain"
	AppConfigKeyStory          = "story"
	AppConfigKeyChatBot        = "chatBot"
)

type appConfigSource struct {
	Key  string
	Load func(client Client) (interface{}, error)
}

func (ctrl *Controller) appConfigSources() []appConfigSource {
	return []appConfigSource{
		{AppConfigKeyTopup, func(client Client) (interface{}, error) { return ctrl.topupConfigFor(client) }},
		{AppConfigKeyUsernameChange, func(client Client) (interface{}, error) { return ctrl.usernameChangeConfigFor(client) }},
		{AppConfigKeyWordChain, func(Client) (interface{}, error) { return ctrl.service.GetWordChain() }},
		{AppConfigKeyStory, func(client Client) (interface{}, error) { return ctrl.storyConfigFor(client) }},
		{AppConfigKeyChatBot, func(client Client) (interface{}, error) { return ctrl.chatBotConfigFor(client) }},
	}
}

func parseAppConfigKeys(raw string) map[string]bool {
	wanted := map[string]bool{}
	for _, key := range strings.Split(raw, ",") {
		if key = strings.TrimSpace(key); key != "" {
			wanted[key] = true
		}
	}
	return wanted
}

// A failing key is left out instead of failing the whole response; clients fall back to their defaults for it.
func collectAppConfig(sources []appConfigSource, client Client, wanted map[string]bool, knownVersion string, logger *zap.SugaredLogger) AppConfigResponse {
	configs := make(map[string]json.RawMessage, len(sources))
	for _, source := range sources {
		if len(wanted) > 0 && !wanted[source.Key] {
			continue
		}
		value, err := source.Load(client)
		if err == nil {
			var raw []byte
			if raw, err = json.Marshal(value); err == nil {
				configs[source.Key] = raw
				continue
			}
		}
		logger.Warnw("Skipping app config key", "key", source.Key, "error", err)
	}

	encoded, _ := json.Marshal(configs)
	sum := sha256.Sum256(encoded)
	version := hex.EncodeToString(sum[:8])
	if knownVersion != "" && knownVersion == version {
		return AppConfigResponse{Version: version, NotModified: true}
	}
	return AppConfigResponse{Version: version, Configs: configs}
}
