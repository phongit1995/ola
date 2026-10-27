package setting

import (
	"errors"
	"testing"

	"go.uber.org/zap"
)

func testAppSources(storyEnabled bool, chatBotErr error) []appConfigSource {
	return []appConfigSource{
		{AppConfigKeyStory, func(client Client) (interface{}, error) {
			return FeatureEnabledResponse{Enabled: storyEnabled && client.Platform != "ios"}, nil
		}},
		{AppConfigKeyWordChain, func(Client) (interface{}, error) { return WordChainConfig{Enabled: true, HintPrice: 500}, nil }},
		{AppConfigKeyChatBot, func(Client) (interface{}, error) { return ChatBotPublicConfig{DailyLimit: 5}, chatBotErr }},
	}
}

func TestCollectAppConfigReturnsEachKey(t *testing.T) {
	resp := collectAppConfig(testAppSources(true, nil), Client{Platform: "web"}, nil, "", zap.NewNop().Sugar())
	if resp.NotModified || resp.Version == "" {
		t.Fatalf("unexpected response: %+v", resp)
	}
	if got := string(resp.Configs[AppConfigKeyStory]); got != `{"enabled":true}` {
		t.Fatalf("story = %s", got)
	}
	for _, key := range []string{AppConfigKeyWordChain, AppConfigKeyChatBot} {
		if _, ok := resp.Configs[key]; !ok {
			t.Fatalf("missing key %s", key)
		}
	}
}

func TestCollectAppConfigNotModifiedAndVersionChanges(t *testing.T) {
	logger := zap.NewNop().Sugar()
	first := collectAppConfig(testAppSources(true, nil), Client{Platform: "web"}, nil, "", logger)

	same := collectAppConfig(testAppSources(true, nil), Client{Platform: "web"}, nil, first.Version, logger)
	if !same.NotModified || same.Configs != nil || same.Version != first.Version {
		t.Fatalf("unchanged config must be notModified without payload: %+v", same)
	}

	changed := collectAppConfig(testAppSources(false, nil), Client{Platform: "web"}, nil, first.Version, logger)
	if changed.NotModified || changed.Version == first.Version {
		t.Fatalf("changed config must return a new version and payload: %+v", changed)
	}

	ios := collectAppConfig(testAppSources(true, nil), Client{Platform: "ios"}, nil, first.Version, logger)
	if ios.NotModified {
		t.Fatal("a platform with a different answer must not share the web version")
	}
}

func TestCollectAppConfigFiltersKeysAndSkipsFailures(t *testing.T) {
	logger := zap.NewNop().Sugar()
	only := collectAppConfig(testAppSources(true, nil), Client{}, parseAppConfigKeys(" story , unknown,"), "", logger)
	if len(only.Configs) != 1 || only.Configs[AppConfigKeyStory] == nil {
		t.Fatalf("keys filter must return only story, got %v", only.Configs)
	}

	failed := collectAppConfig(testAppSources(true, errors.New("db down")), Client{}, nil, "", logger)
	if _, ok := failed.Configs[AppConfigKeyChatBot]; ok {
		t.Fatal("a failing key must be left out")
	}
	if len(failed.Configs) != 2 {
		t.Fatalf("other keys must still be returned, got %v", failed.Configs)
	}
}
