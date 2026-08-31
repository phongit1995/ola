package topup

import (
	"bytes"
	"encoding/json"
	"fmt"
	"net/http"
	"net/url"
	"strings"
	"time"

	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/setting"

	"go.uber.org/zap"
)

const (
	discordTimeout = 5 * time.Second
	colorGreen     = 0x57F287
	colorOrange    = 0xE67E22
	colorRed       = 0xED4245
)

type discordField struct {
	Name   string `json:"name"`
	Value  string `json:"value"`
	Inline bool   `json:"inline,omitempty"`
}

type discordEmbed struct {
	Title     string         `json:"title"`
	Color     int            `json:"color"`
	Fields    []discordField `json:"fields"`
	Timestamp string         `json:"timestamp"`
}

type Notifier struct {
	settings *setting.Service
	logger   *zap.SugaredLogger
	client   *http.Client
}

func NewNotifier(settings *setting.Service, logger *zap.SugaredLogger) *Notifier {
	return &Notifier{
		settings: settings,
		logger:   logger.Named("[topup_notifier]"),
		client:   &http.Client{Timeout: discordTimeout},
	}
}

func (n *Notifier) NotifyCredited(providerTxID, description string, amountVnd int64, username string, balanceBefore, balanceAfter int, manual bool) {
	title := "💰 Nạp KEN thành công"
	if manual {
		title = "✅ Admin cộng KEN thủ công"
	}
	n.dispatch(discordEmbed{
		Title:     title,
		Color:     colorGreen,
		Timestamp: time.Now().UTC().Format(time.RFC3339),
		Fields: []discordField{
			{Name: "Người nạp", Value: "@" + username, Inline: true},
			{Name: "Số tiền", Value: groupDigits(amountVnd) + "đ", Inline: true},
			{Name: "KEN", Value: fmt.Sprintf("%s → %s", groupDigits(int64(balanceBefore)), groupDigits(int64(balanceAfter))), Inline: true},
			{Name: "Mã GD", Value: orDash(providerTxID), Inline: true},
			{Name: "Nội dung CK", Value: orDash(description)},
		},
	})
}

func (n *Notifier) NotifyIssue(row *models.TopupTransaction) {
	var title string
	color := colorOrange
	switch row.Status {
	case models.TopupTxStatusNoMatch:
		title = "⚠️ Nạp KEN: không tìm thấy user"
	case models.TopupTxStatusBelowMin:
		title = "⚠️ Nạp KEN dưới mức tối thiểu"
	case models.TopupTxStatusSkippedDisabled:
		title = "⚠️ Nạp KEN khi đang tắt nạp"
	case models.TopupTxStatusFailed:
		title = "❌ Nạp KEN lỗi"
		color = colorRed
	default:
		return
	}

	fields := []discordField{
		{Name: "Số tiền", Value: groupDigits(row.Amount) + "đ", Inline: true},
		{Name: "Mã GD", Value: orDash(row.ProviderTxID), Inline: true},
	}
	if row.MatchedUsername != nil && *row.MatchedUsername != "" {
		fields = append(fields, discordField{Name: "Username trong CK", Value: "@" + *row.MatchedUsername, Inline: true})
	}
	fields = append(fields, discordField{Name: "Nội dung CK", Value: orDash(row.Description)})
	if row.Note != nil && *row.Note != "" {
		fields = append(fields, discordField{Name: "Ghi chú", Value: *row.Note})
	}
	fields = append(fields, discordField{Name: "Xử lý", Value: "Cộng tay tại admin: Người dùng → Nạp KEN"})

	n.dispatch(discordEmbed{
		Title:     title,
		Color:     color,
		Timestamp: time.Now().UTC().Format(time.RFC3339),
		Fields:    fields,
	})
}

var allowedDiscordHosts = map[string]bool{
	"discord.com":        true,
	"discordapp.com":     true,
	"ptb.discord.com":    true,
	"canary.discord.com": true,
}

func validDiscordWebhookURL(raw string) bool {
	u, err := url.Parse(raw)
	if err != nil {
		return false
	}
	return u.Scheme == "https" && allowedDiscordHosts[u.Hostname()] && strings.HasPrefix(u.Path, "/api/webhooks/")
}

func redactWebhookURL(message, webhookURL string) string {
	return strings.ReplaceAll(message, webhookURL, "[discord-webhook]")
}

func (n *Notifier) dispatch(embed discordEmbed) {
	go func() {
		bank, err := n.settings.GetTopupBank()
		if err != nil {
			n.logger.Warnw("Failed to load topup bank config for discord notify", "error", err.Error())
			return
		}
		webhookURL := strings.TrimSpace(bank.DiscordWebhookURL)
		if webhookURL == "" {
			return
		}
		if !validDiscordWebhookURL(webhookURL) {
			n.logger.Warnw("Discord webhook URL not allowed, notification skipped")
			return
		}
		payload, err := json.Marshal(map[string]interface{}{"embeds": []discordEmbed{embed}})
		if err != nil {
			n.logger.Warnw("Failed to encode discord payload", "error", err.Error())
			return
		}
		resp, err := n.client.Post(webhookURL, "application/json", bytes.NewReader(payload))
		if err != nil {
			n.logger.Warnw("Failed to send discord topup notification", "error", redactWebhookURL(err.Error(), webhookURL))
			return
		}
		defer resp.Body.Close()
		if resp.StatusCode >= 300 {
			n.logger.Warnw("Discord topup notification rejected", "status", resp.StatusCode)
		}
	}()
}

func groupDigits(n int64) string {
	s := fmt.Sprintf("%d", n)
	neg := strings.HasPrefix(s, "-")
	if neg {
		s = s[1:]
	}
	var b strings.Builder
	for i, r := range s {
		if i > 0 && (len(s)-i)%3 == 0 {
			b.WriteByte('.')
		}
		b.WriteRune(r)
	}
	if neg {
		return "-" + b.String()
	}
	return b.String()
}

func orDash(s string) string {
	if strings.TrimSpace(s) == "" {
		return "—"
	}
	return s
}
