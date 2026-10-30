package report

import (
	"bytes"
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"html"
	"io"
	"net/http"
	"net/url"
	"strings"
	"sync"
	"time"

	"ola-chat-server/internal/config"
	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/setting"
	"ola-chat-server/internal/services"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
	"go.uber.org/zap"
)

var (
	ErrAlertChannelNotConfigured = errors.New("report alert channel is not configured")
	ErrAlertUnknownChannel       = errors.New("unknown report alert channel")
)

var alertTargetLabels = map[string]string{
	constants.ReportTargetAccount:      "Tài khoản",
	constants.ReportTargetPost:         "Bài đăng Me",
	constants.ReportTargetComment:      "Bình luận Me",
	constants.ReportTargetStoryComment: "Bình luận truyện",
	constants.ReportTargetMessage:      "Tin nhắn 1-1",
	constants.ReportTargetRoomMessage:  "Tin nhắn phòng",
	constants.ReportTargetMoment:       "Khoảnh khắc",
}

var alertReasonLabels = map[string]string{
	ReportReasonSpam:       "Spam / quảng cáo",
	ReportReasonSensitive:  "Nội dung nhạy cảm",
	ReportReasonScam:       "Lừa đảo",
	ReportReasonHarassment: "Quấy rối / xúc phạm",
	ReportReasonOther:      "Khác",
}

var telegramMentionBreaker = strings.NewReplacer("@", "@"+AlertTelegramMentionBreaker)

var discordMarkdownEscaper = strings.NewReplacer(
	`\`, `\\`, "*", `\*`, "_", `\_`, "~", `\~`, "|", `\|`, "`", "\\`", ">", `\>`, "#", `\#`, "[", `\[`, "]", `\]`,
)

type alertMessage struct {
	Title   string
	Reason  string
	People  string
	Body    string
	Excerpt string
	Note    string
	Pending int64
	Link    string
}

type alertThrottle interface {
	SetNX(key string, value interface{}, expiration time.Duration) (bool, error)
	DeleteIfValue(key string, value interface{}) (bool, error)
}

type alertChannel struct {
	name string
	send func(ctx context.Context, msg alertMessage) error
}

type Alerter struct {
	repo        *Repository
	settings    *setting.Service
	cfg         *config.Config
	throttle    alertThrottle
	client      *http.Client
	sendTimeout time.Duration
	logger      *zap.SugaredLogger
}

func NewAlerter(repo *Repository, settings *setting.Service, cfg *config.Config, cache *services.CacheService, logger *zap.SugaredLogger) *Alerter {
	return &Alerter{
		repo:        repo,
		settings:    settings,
		cfg:         cfg,
		throttle:    cache,
		client:      &http.Client{Timeout: AlertSendTimeout},
		sendTimeout: AlertSendTimeout,
		logger:      logger.Named("[report_alert]"),
	}
}

func (a *Alerter) ReportCreated(report *models.Report) {
	creds, err := a.settings.EnabledReportAlertCredentials(a.cfg)
	if err != nil {
		a.logger.Warnw("Failed to load report_alert setting", "error", err.Error())
	}
	claimed := a.claimChannels(report, a.usableChannels(creds))
	if len(claimed) == 0 {
		return
	}
	a.dispatch(report, a.reportMessage(report, creds.AdminURL), claimed)
}

func (a *Alerter) usableChannels(creds setting.ReportAlertCredentials) []alertChannel {
	channels := make([]alertChannel, 0, 2)
	if creds.DiscordWebhookURL != "" {
		webhookURL := creds.DiscordWebhookURL
		channels = append(channels, alertChannel{
			name: setting.ReportAlertChannelDiscord,
			send: func(ctx context.Context, msg alertMessage) error { return a.sendDiscord(ctx, webhookURL, msg) },
		})
	}
	if creds.TelegramBotToken != "" && creds.TelegramChatID != "" {
		botToken, chatID := creds.TelegramBotToken, creds.TelegramChatID
		channels = append(channels, alertChannel{
			name: setting.ReportAlertChannelTelegram,
			send: func(ctx context.Context, msg alertMessage) error { return a.sendTelegram(ctx, botToken, chatID, msg) },
		})
	}
	return channels
}

func alertThrottleKey(channel string, report *models.Report) string {
	return fmt.Sprintf(CacheKeyReportAlertTarget, channel, report.TargetType, report.TargetID)
}

func (a *Alerter) claimChannels(report *models.Report, channels []alertChannel) []alertChannel {
	claimed := make([]alertChannel, 0, len(channels))
	for _, channel := range channels {
		first, err := a.throttle.SetNX(alertThrottleKey(channel.name, report), report.ID.String(), CacheTTLReportAlertTarget)
		if err != nil {
			a.logger.Warnw("Failed to throttle report alert", "channel", channel.name, "report_id", report.ID, "error", err.Error())
		}
		if err != nil || first {
			claimed = append(claimed, channel)
		}
	}
	return claimed
}

func (a *Alerter) dispatch(report *models.Report, msg alertMessage, channels []alertChannel) {
	var wg sync.WaitGroup
	for _, channel := range channels {
		wg.Add(1)
		utils.SafeGo(a.logger, func() {
			defer wg.Done()
			a.deliver(report, msg, channel)
		})
	}
	wg.Wait()
}

func (a *Alerter) deliver(report *models.Report, msg alertMessage, channel alertChannel) {
	ctx, cancel := context.WithTimeout(context.Background(), a.sendTimeout)
	defer cancel()
	if err := channel.send(ctx, msg); err != nil {
		a.logger.Warnw("Failed to send report alert", "channel", channel.name, "report_id", report.ID, "error", err.Error())
		if _, err := a.throttle.DeleteIfValue(alertThrottleKey(channel.name, report), report.ID.String()); err != nil {
			a.logger.Warnw("Failed to release report alert throttle", "channel", channel.name, "report_id", report.ID, "error", err.Error())
		}
	}
}

func (a *Alerter) SendTest(ctx context.Context, channel string) error {
	if channel != setting.ReportAlertChannelDiscord && channel != setting.ReportAlertChannelTelegram {
		return ErrAlertUnknownChannel
	}
	creds, enabled, err := a.settings.ReportAlertChannelCredentials(a.cfg, channel)
	if err != nil {
		return err
	}
	channels := a.usableChannels(creds)
	if len(channels) == 0 {
		return ErrAlertChannelNotConfigured
	}
	return channels[0].send(ctx, testAlertMessage(enabled, creds.AdminURL))
}

func testAlertMessage(enabled bool, adminURL string) alertMessage {
	body := "Kênh này sẽ nhận tin khi người dùng gửi báo cáo mới."
	if !enabled {
		body = "Kênh này đang TẮT nên chưa nhận báo cáo. Bật công tắc rồi lưu cấu hình để bắt đầu nhận tin."
	}
	return alertMessage{Title: "✅ Thử thông báo báo cáo vi phạm", Body: body, Link: reportsLink(adminURL)}
}

func (a *Alerter) reportMessage(report *models.Report, adminURL string) alertMessage {
	pending, err := a.repo.CountPendingForTarget(report.TargetType, report.TargetID)
	if err != nil {
		a.logger.Warnw("Failed to count pending reports for alert", "report_id", report.ID, "error", err.Error())
	}
	reported := ""
	if report.ReportedUserID != nil {
		reported = a.userLabel(*report.ReportedUserID)
	}
	return buildAlertMessage(report, a.userLabel(report.ReporterID), reported, pending, adminURL)
}

func (a *Alerter) userLabel(id uuid.UUID) string {
	user, err := a.repo.FindUser(id)
	if err != nil {
		a.logger.Warnw("Failed to load user for report alert", "user_id", id, "error", err.Error())
		return AlertUnknownUserLabel
	}
	return "@" + user.Username
}

func buildAlertMessage(report *models.Report, reporter, reported string, pending int64, adminURL string) alertMessage {
	people := reporter + " gửi báo cáo"
	if reported != "" {
		people = reporter + " báo cáo " + reported
	}
	msg := alertMessage{
		Title:   "🚩 Báo cáo mới: " + alertTargetLabels[report.TargetType],
		Reason:  alertReasonLabels[report.Reason],
		People:  people,
		Excerpt: alertExcerpt(report),
		Pending: pending,
		Link:    reportsLink(adminURL),
	}
	if report.TargetType != constants.ReportTargetMessage {
		msg.Note = truncateAlertText(report.Note)
	}
	return msg
}

func reportsLink(adminURL string) string {
	if adminURL == "" {
		return ""
	}
	return adminURL + AlertAdminReportsPath
}

func alertExcerpt(report *models.Report) string {
	if report.TargetType == constants.ReportTargetMessage {
		return "Tin nhắn 1-1, xem nội dung trong admin"
	}
	snapshot := report.Snapshot
	if report.TargetType == constants.ReportTargetAccount {
		username := snapshotString(snapshot, "username")
		if fullName := snapshotString(snapshot, "fullName"); fullName != "" {
			return fullName + " (@" + username + ")"
		}
		return "@" + username
	}
	if text := strings.TrimSpace(snapshotString(snapshot, "text")); text != "" {
		return truncateAlertText(text)
	}
	switch {
	case snapshotString(snapshot, "videoUrl") != "":
		return "[Video]"
	case snapshotHasList(snapshot, "imageUrls"):
		return "[Ảnh]"
	case snapshotString(snapshot, "audioUrl") != "":
		return "[Ghi âm]"
	case snapshotString(snapshot, "sticker") != "":
		return "[Sticker]"
	case snapshotString(snapshot, "fileUrl") != "":
		return "[Tệp]"
	}
	return ""
}

func truncateAlertText(text string) string {
	text = strings.TrimSpace(text)
	truncated := utils.TruncateRunes(text, AlertExcerptMaxRunes)
	if truncated != text {
		return truncated + "…"
	}
	return text
}

func snapshotString(snapshot models.JSONB, key string) string {
	value, _ := snapshot[key].(string)
	return value
}

func snapshotHasList(snapshot models.JSONB, key string) bool {
	switch list := snapshot[key].(type) {
	case []string:
		return len(list) > 0
	case []interface{}:
		return len(list) > 0
	}
	return false
}

type discordEmbed struct {
	Title       string `json:"title"`
	Description string `json:"description"`
	URL         string `json:"url,omitempty"`
	Color       int    `json:"color"`
	Timestamp   string `json:"timestamp"`
}

type discordAllowedMentions struct {
	Parse []string `json:"parse"`
}

type discordPayload struct {
	Username        string                 `json:"username"`
	Embeds          []discordEmbed         `json:"embeds"`
	AllowedMentions discordAllowedMentions `json:"allowed_mentions"`
}

func discordPayloadFor(msg alertMessage, now time.Time) discordPayload {
	lines := make([]string, 0, 6)
	if msg.Reason != "" {
		lines = append(lines, "**Lý do:** "+msg.Reason)
	}
	if msg.People != "" {
		lines = append(lines, discordMarkdownEscaper.Replace(msg.People))
	}
	if msg.Body != "" {
		lines = append(lines, msg.Body)
	}
	if msg.Excerpt != "" {
		lines = append(lines, "> "+strings.ReplaceAll(discordMarkdownEscaper.Replace(msg.Excerpt), "\n", "\n> "))
	}
	if msg.Note != "" {
		lines = append(lines, "**Mô tả:** "+discordMarkdownEscaper.Replace(msg.Note))
	}
	if msg.Pending > 1 {
		lines = append(lines, fmt.Sprintf("**%d báo cáo** đang chờ cho nội dung này", msg.Pending))
	}
	if msg.Link != "" {
		lines = append(lines, "[Mở trang báo cáo]("+msg.Link+")")
	}
	return discordPayload{
		Username: AlertSenderName,
		Embeds: []discordEmbed{{
			Title:       msg.Title,
			Description: strings.Join(lines, "\n"),
			URL:         msg.Link,
			Color:       AlertDiscordColor,
			Timestamp:   now.UTC().Format(time.RFC3339),
		}},
		AllowedMentions: discordAllowedMentions{Parse: []string{}},
	}
}

func telegramTextFor(msg alertMessage) string {
	lines := []string{"<b>" + html.EscapeString(msg.Title) + "</b>"}
	if msg.Reason != "" {
		lines = append(lines, "Lý do: "+html.EscapeString(msg.Reason))
	}
	if msg.People != "" {
		lines = append(lines, telegramText(msg.People))
	}
	if msg.Body != "" {
		lines = append(lines, html.EscapeString(msg.Body))
	}
	if msg.Excerpt != "" {
		lines = append(lines, "<blockquote>"+telegramText(msg.Excerpt)+"</blockquote>")
	}
	if msg.Note != "" {
		lines = append(lines, "Mô tả: "+telegramText(msg.Note))
	}
	if msg.Pending > 1 {
		lines = append(lines, fmt.Sprintf("<b>%d báo cáo</b> đang chờ cho nội dung này", msg.Pending))
	}
	if msg.Link != "" {
		lines = append(lines, `<a href="`+html.EscapeString(msg.Link)+`">Mở trang báo cáo</a>`)
	}
	return strings.Join(lines, "\n")
}

func telegramText(text string) string {
	return html.EscapeString(telegramMentionBreaker.Replace(text))
}

type telegramPayload struct {
	ChatID                string `json:"chat_id"`
	Text                  string `json:"text"`
	ParseMode             string `json:"parse_mode"`
	DisableWebPagePreview bool   `json:"disable_web_page_preview"`
}

type telegramResponse struct {
	OK          bool   `json:"ok"`
	Description string `json:"description"`
}

func (a *Alerter) sendDiscord(ctx context.Context, webhookURL string, msg alertMessage) error {
	status, body, err := a.postJSON(ctx, webhookURL, discordPayloadFor(msg, time.Now()))
	if err != nil {
		return err
	}
	if status < 200 || status >= 300 {
		return fmt.Errorf("discord trả về HTTP %d: %s", status, strings.TrimSpace(string(body)))
	}
	return nil
}

func (a *Alerter) sendTelegram(ctx context.Context, botToken, chatID string, msg alertMessage) error {
	endpoint := fmt.Sprintf(AlertTelegramSendMessageURL, botToken)
	status, body, err := a.postJSON(ctx, endpoint, telegramPayload{
		ChatID:                chatID,
		Text:                  telegramTextFor(msg),
		ParseMode:             AlertTelegramParseMode,
		DisableWebPagePreview: true,
	})
	if err != nil {
		return err
	}
	var resp telegramResponse
	_ = json.Unmarshal(body, &resp)
	if status < 200 || status >= 300 || !resp.OK {
		if resp.Description != "" {
			return fmt.Errorf("telegram trả về HTTP %d: %s", status, resp.Description)
		}
		return fmt.Errorf("telegram trả về HTTP %d", status)
	}
	return nil
}

func (a *Alerter) postJSON(ctx context.Context, endpoint string, payload interface{}) (int, []byte, error) {
	body, err := json.Marshal(payload)
	if err != nil {
		return 0, nil, err
	}
	req, err := http.NewRequestWithContext(ctx, http.MethodPost, endpoint, bytes.NewReader(body))
	if err != nil {
		return 0, nil, errors.New("không tạo được yêu cầu gửi")
	}
	req.Header.Set("Content-Type", "application/json")
	resp, err := a.client.Do(req)
	if err != nil {
		return 0, nil, withoutURL(err)
	}
	defer resp.Body.Close()
	respBody, _ := io.ReadAll(io.LimitReader(resp.Body, AlertResponseBodyLimit))
	return resp.StatusCode, respBody, nil
}

func withoutURL(err error) error {
	var urlErr *url.Error
	if errors.As(err, &urlErr) {
		return fmt.Errorf("không kết nối được: %w", urlErr.Err)
	}
	return err
}
