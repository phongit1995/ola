package services

import (
	"bytes"
	"context"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"time"

	"ola-chat-server/internal/config"

	"go.uber.org/zap"
)

const resendEmailsEndpoint = "https://api.resend.com/emails"

type MailService struct {
	apiKey string
	from   string
	client *http.Client
	logger *zap.SugaredLogger
}

func NewMailService(cfg *config.Config, logger *zap.SugaredLogger) *MailService {
	l := logger.Named("[mail_service]")
	if cfg.ResendAPIKey == "" {
		l.Warn("RESEND_API_KEY is empty, email sending is disabled")
	}
	return &MailService{
		apiKey: cfg.ResendAPIKey,
		from:   cfg.MailFrom,
		client: &http.Client{Timeout: 10 * time.Second},
		logger: l,
	}
}

type resendPayload struct {
	From    string   `json:"from"`
	To      []string `json:"to"`
	Subject string   `json:"subject"`
	HTML    string   `json:"html"`
}

func (s *MailService) send(ctx context.Context, toEmail, subject, html string) error {
	if s.apiKey == "" {
		return fmt.Errorf("email service is not configured")
	}

	body, err := json.Marshal(resendPayload{
		From:    s.from,
		To:      []string{toEmail},
		Subject: subject,
		HTML:    html,
	})
	if err != nil {
		return fmt.Errorf("failed to marshal email payload: %w", err)
	}

	req, err := http.NewRequestWithContext(ctx, http.MethodPost, resendEmailsEndpoint, bytes.NewReader(body))
	if err != nil {
		return fmt.Errorf("failed to build email request: %w", err)
	}
	req.Header.Set("Authorization", "Bearer "+s.apiKey)
	req.Header.Set("Content-Type", "application/json")

	resp, err := s.client.Do(req)
	if err != nil {
		s.logger.Errorw("Failed to call Resend API", "to", toEmail, "error", err)
		return fmt.Errorf("failed to send email: %w", err)
	}
	defer resp.Body.Close()

	if resp.StatusCode < 200 || resp.StatusCode >= 300 {
		respBody, _ := io.ReadAll(resp.Body)
		s.logger.Errorw("Resend API returned error", "to", toEmail, "status", resp.StatusCode, "body", string(respBody))
		return fmt.Errorf("failed to send email: status %d", resp.StatusCode)
	}

	s.logger.Infow("Verification email sent", "to", toEmail)
	return nil
}

func (s *MailService) SendVerificationCode(ctx context.Context, toEmail, code string) error {
	subject := "Mã xác thực Ola của bạn"
	html := buildVerificationEmailHTML(code)
	return s.send(ctx, toEmail, subject, html)
}

func buildVerificationEmailHTML(code string) string {
	return fmt.Sprintf(`<!DOCTYPE html>
<html lang="vi">
<head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"></head>
<body style="margin:0;padding:0;background-color:#f2f4f7;">
  <table role="presentation" width="100%%" cellpadding="0" cellspacing="0" style="background-color:#f2f4f7;padding:32px 12px;">
    <tr><td align="center">
      <table role="presentation" width="100%%" cellpadding="0" cellspacing="0" style="max-width:460px;background-color:#ffffff;border-radius:16px;overflow:hidden;box-shadow:0 4px 24px rgba(16,24,40,0.08);font-family:'Segoe UI',Roboto,Helvetica,Arial,sans-serif;">
        <tr><td style="background:linear-gradient(135deg,#6366f1 0%%,#8b5cf6 100%%);padding:28px 32px;">
          <span style="color:#ffffff;font-size:22px;font-weight:700;letter-spacing:0.5px;">Ola</span>
        </td></tr>
        <tr><td style="padding:36px 32px 8px 32px;">
          <h1 style="margin:0 0 12px 0;font-size:20px;color:#101828;font-weight:600;">Xác thực email của bạn</h1>
          <p style="margin:0;font-size:15px;line-height:22px;color:#475467;">Dùng mã bên dưới để hoàn tất xác thực email trên Ola. Mã có hiệu lực trong <strong>5 phút</strong>.</p>
        </td></tr>
        <tr><td style="padding:24px 32px;">
          <div style="background-color:#f9fafb;border:1px solid #eaecf0;border-radius:12px;padding:20px;text-align:center;">
            <span style="font-size:34px;font-weight:700;letter-spacing:10px;color:#101828;font-family:'Courier New',monospace;">%s</span>
          </div>
        </td></tr>
        <tr><td style="padding:0 32px 32px 32px;">
          <p style="margin:0;font-size:13px;line-height:20px;color:#98a2b3;">Nếu bạn không yêu cầu mã này, hãy bỏ qua email. Đừng chia sẻ mã cho bất kỳ ai.</p>
        </td></tr>
        <tr><td style="background-color:#f9fafb;padding:18px 32px;border-top:1px solid #eaecf0;">
          <p style="margin:0;font-size:12px;color:#98a2b3;">&copy; Ola Chat &middot; noreply@olachat.net</p>
        </td></tr>
      </table>
    </td></tr>
  </table>
</body>
</html>`, code)
}
