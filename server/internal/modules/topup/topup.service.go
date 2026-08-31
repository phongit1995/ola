package topup

import (
	"errors"
	"regexp"
	"strings"
	"unicode"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/setting"
	"ola-chat-server/internal/modules/user"
	"ola-chat-server/internal/transport/websocket"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
	"go.uber.org/zap"
	"golang.org/x/text/unicode/norm"
)

const maxTopupAmountVnd = 1_000_000_000

var usernameCapturePattern = `([A-Za-z0-9._-]+)`

type Service struct {
	repo      *Repository
	settings  *setting.Service
	notifier  *Notifier
	userCache *user.CacheService
	wsServer  *websocket.Server
	logger    *zap.SugaredLogger
}

func NewService(
	repo *Repository,
	settings *setting.Service,
	notifier *Notifier,
	userCache *user.CacheService,
	wsServer *websocket.Server,
	logger *zap.SugaredLogger,
) *Service {
	return &Service{
		repo:      repo,
		settings:  settings,
		notifier:  notifier,
		userCache: userCache,
		wsServer:  wsServer,
		logger:    logger.Named("[topup_service]"),
	}
}

func (s *Service) WebhookSecret() (string, error) {
	bank, err := s.settings.GetTopupBank()
	if err != nil {
		return "", err
	}
	return strings.TrimSpace(bank.SieuthicodeSecret), nil
}

func (s *Service) ProcessTransaction(wtx WebhookTransaction) error {
	txID := strings.TrimSpace(wtx.TransactionID)
	if txID == "" {
		s.logger.Warnw("Topup webhook transaction without transactionID, skipped", "description", wtx.Description)
		return nil
	}

	amount, err := wtx.Amount.Int64()
	if err != nil {
		if f, ferr := wtx.Amount.Float64(); ferr == nil {
			amount = int64(f)
		}
	}

	row := models.TopupTransaction{
		ProviderTxID: truncate(txID, 120),
		Description:  truncate(strings.TrimSpace(wtx.Description), 500),
		Amount:       amount,
		Type:         truncate(strings.ToUpper(strings.TrimSpace(wtx.Type)), 10),
		Raw: models.JSONB{
			"transactionID": wtx.TransactionID,
			"description":   wtx.Description,
			"amount":        wtx.Amount.String(),
			"type":          wtx.Type,
		},
	}

	topupCfg, err := s.settings.GetTopup()
	if err != nil {
		s.logger.Errorw("Failed to load topup config", "provider_tx_id", txID, "error", err.Error())
		return err
	}
	bankCfg, err := s.settings.GetTopupBank()
	if err != nil {
		s.logger.Errorw("Failed to load topup bank config", "provider_tx_id", txID, "error", err.Error())
		return err
	}

	var matchedUser *models.User
	shouldCredit := false

	switch {
	case row.Type != "IN":
		row.Status = models.TopupTxStatusSkippedOut
	case amount <= 0 || amount > maxTopupAmountVnd:
		row.Status = models.TopupTxStatusFailed
		row.Note = ptr("invalid amount")
	default:
		capture, u, lookupErr := s.matchUser(bankCfg.MemoTemplate, row.Description)
		if lookupErr != nil {
			s.logger.Errorw("Topup user lookup failed", "provider_tx_id", txID, "error", lookupErr.Error())
			return lookupErr
		}
		if capture != "" {
			row.MatchedUsername = ptr(truncate(capture, 50))
		}
		if u == nil {
			row.Status = models.TopupTxStatusNoMatch
			break
		}
		row.MatchedUsername = ptr(truncate(u.Username, 50))
		row.UserID = &u.ID
		switch {
		case !topupCfg.Enabled:
			row.Status = models.TopupTxStatusSkippedDisabled
		case amount < int64(topupCfg.MinAmount):
			row.Status = models.TopupTxStatusBelowMin
		default:
			row.Status = models.TopupTxStatusProcessing
			matchedUser = u
			shouldCredit = true
		}
	}

	inserted, err := s.repo.InsertIgnoreDuplicate(&row)
	if err != nil {
		s.logger.Errorw("Failed to insert topup transaction", "provider_tx_id", txID, "error", err.Error())
		return err
	}
	if !inserted {
		return s.retryExisting(row.ProviderTxID)
	}
	if !shouldCredit {
		s.logger.Infow("Topup transaction recorded without credit",
			"provider_tx_id", txID, "status", row.Status, "amount", amount)
		s.notifier.NotifyIssue(&row)
		return nil
	}

	return s.credit(&row, matchedUser.ID, true)
}

func (s *Service) retryExisting(providerTxID string) error {
	row, err := s.repo.FindByProviderTxID(providerTxID)
	if err != nil {
		return err
	}
	if row == nil {
		return nil
	}
	retryable := row.Status == models.TopupTxStatusProcessing || row.Status == models.TopupTxStatusFailed
	if !retryable || row.UserID == nil || row.Type != "IN" || row.Amount <= 0 {
		s.logger.Infow("Duplicate topup transaction skipped", "provider_tx_id", providerTxID, "status", row.Status)
		return nil
	}
	s.logger.Infow("Retrying unfinished topup credit", "provider_tx_id", providerTxID, "status", row.Status)
	return s.credit(row, *row.UserID, row.Status == models.TopupTxStatusProcessing)
}

func (s *Service) credit(row *models.TopupTransaction, userID uuid.UUID, notifyOnFail bool) error {
	updatedUser, kenTx, err := s.repo.Credit(CreditParams{
		RowID:        row.ID,
		UserID:       userID,
		KenAmount:    int(row.Amount),
		ProviderTxID: row.ProviderTxID,
		AmountVnd:    row.Amount,
		ActorType:    models.KenActorSystem,
		Description:  "Nạp KEN qua chuyển khoản",
	})
	if err != nil {
		if errors.Is(err, ErrAlreadyCredited) {
			s.logger.Infow("Topup transaction already credited, skipped", "provider_tx_id", row.ProviderTxID)
			return nil
		}
		s.logger.Errorw("Failed to credit topup", "provider_tx_id", row.ProviderTxID, "user_id", userID, "error", err.Error())
		note := truncate(err.Error(), 255)
		if updateErr := s.repo.UpdateStatus(row.ID, models.TopupTxStatusFailed, &note); updateErr != nil {
			s.logger.Errorw("Failed to mark topup transaction failed", "provider_tx_id", row.ProviderTxID, "error", updateErr.Error())
		}
		if notifyOnFail {
			row.Status = models.TopupTxStatusFailed
			row.Note = &note
			s.notifier.NotifyIssue(row)
		}
		return err
	}

	if err := s.userCache.InvalidateUser(userID); err != nil {
		s.logger.Warnw("Failed to invalidate user cache after topup", "user_id", userID, "error", err.Error())
	}
	if s.wsServer != nil {
		payload := utils.WrapWebSocketMessage(constants.WebSocketEventKenUpdated, map[string]interface{}{
			"ken": updatedUser.Ken,
		})
		s.wsServer.EmitToUser(userID.String(), constants.WebSocketMessageEvent, payload)
	}
	s.notifier.NotifyCredited(row.ProviderTxID, row.Description, row.Amount, updatedUser.Username, kenTx.BalanceBefore, kenTx.BalanceAfter, false)
	s.logger.Infow("Topup credited",
		"provider_tx_id", row.ProviderTxID,
		"user_id", userID,
		"amount_vnd", row.Amount,
		"balance_after", updatedUser.Ken,
	)
	return nil
}

func (s *Service) matchUser(memoTemplate, description string) (string, *models.User, error) {
	re, ok := buildMemoRegex(memoTemplate)
	if !ok {
		s.logger.Warnw("Topup memo template has no {username} placeholder", "template", memoTemplate)
		return "", nil, nil
	}
	match := re.FindStringSubmatch(normalizeMemoText(description))
	if len(match) < 2 || match[1] == "" {
		return "", nil, nil
	}
	capture := match[1]
	u, err := s.repo.FindUserByUsernameCI(capture)
	if err != nil {
		return capture, nil, err
	}
	return capture, u, nil
}

func buildMemoRegex(template string) (*regexp.Regexp, bool) {
	parts := strings.Split(template, "{username}")
	if len(parts) < 2 {
		return nil, false
	}
	quoted := make([]string, len(parts))
	for i, part := range parts {
		quoted[i] = memoLiteralPattern(part)
	}
	re, err := regexp.Compile("(?i)" + strings.Join(quoted, usernameCapturePattern))
	if err != nil {
		return nil, false
	}
	return re, true
}

func memoLiteralPattern(part string) string {
	chunks := strings.Split(normalizeMemoChars(part), " ")
	for i, chunk := range chunks {
		chunks[i] = regexp.QuoteMeta(chunk)
	}
	return strings.Join(chunks, `\s+`)
}

func normalizeMemoText(input string) string {
	return strings.TrimSpace(normalizeMemoChars(input))
}

func normalizeMemoChars(input string) string {
	decomposed := norm.NFD.String(input)
	var b strings.Builder
	for _, r := range decomposed {
		if unicode.Is(unicode.Mn, r) {
			continue
		}
		switch r {
		case 'đ':
			r = 'd'
		case 'Đ':
			r = 'D'
		}
		if (r >= 'A' && r <= 'Z') || (r >= 'a' && r <= 'z') || (r >= '0' && r <= '9') ||
			r == ' ' || r == '@' || r == '.' || r == '_' || r == '-' {
			b.WriteRune(r)
		}
	}
	return b.String()
}

func truncate(s string, max int) string {
	if len(s) <= max {
		return s
	}
	runes := []rune(s)
	if len(runes) <= max {
		return s
	}
	return string(runes[:max])
}

func ptr(s string) *string {
	return &s
}
