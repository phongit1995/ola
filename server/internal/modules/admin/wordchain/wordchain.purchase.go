package adminwordchain

import (
	"time"

	"ola-chat-server/internal/models"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

const (
	PurchaseTypeHint  = "hint"
	PurchaseTypeGuess = "guess"
)

var purchaseTxTypes = map[string]models.KenTxType{
	PurchaseTypeHint:  models.KenTxTypeWordChainHint,
	PurchaseTypeGuess: models.KenTxTypeWordChainGuess,
}

type PurchaseFilter struct {
	Type   string
	Search string
	From   *time.Time
	To     *time.Time
}

type PurchaseUser struct {
	ID       string `json:"id"`
	Username string `json:"username"`
	FullName string `json:"fullName,omitempty"`
	Avatar   string `json:"avatar,omitempty"`
}

type PurchaseItem struct {
	ID        string       `json:"id"`
	Type      string       `json:"type" example:"hint"`
	User      PurchaseUser `json:"user"`
	Word      string       `json:"word,omitempty"`
	Hints     []string     `json:"hints,omitempty"`
	Guesses   int          `json:"guesses,omitempty"`
	Amount    int          `json:"amount"`
	CreatedAt string       `json:"createdAt"`
}

type PurchaseSummary struct {
	HintCount  int64 `json:"hintCount"`
	HintKen    int64 `json:"hintKen"`
	GuessCount int64 `json:"guessCount"`
	GuessKen   int64 `json:"guessKen"`
}

type PurchaseListResponse struct {
	Items   []PurchaseItem  `json:"items"`
	Total   int64           `json:"total"`
	Summary PurchaseSummary `json:"summary"`
}

type PurchaseRepository struct {
	db *gorm.DB
}

func NewPurchaseRepository(db *gorm.DB) *PurchaseRepository {
	return &PurchaseRepository{db: db}
}

type purchaseRow struct {
	ID        uuid.UUID
	Type      models.KenTxType
	Amount    int
	Metadata  models.JSONB
	CreatedAt time.Time
	UserID    uuid.UUID
	Username  string
	FullName  string
	Avatar    string
}

type purchaseTotalRow struct {
	Type  models.KenTxType
	Count int64
	Ken   int64
}

func (r *PurchaseRepository) scope(f PurchaseFilter) *gorm.DB {
	types := []models.KenTxType{models.KenTxTypeWordChainHint, models.KenTxTypeWordChainGuess}
	if t, ok := purchaseTxTypes[f.Type]; ok {
		types = []models.KenTxType{t}
	}
	q := r.db.Table("ken_transactions AS kt").
		Joins("LEFT JOIN users u ON u.id = kt.user_id").
		Where("kt.deleted_at IS NULL AND kt.type IN ?", types)
	if f.Search != "" {
		like := "%" + f.Search + "%"
		q = q.Where("(u.username ILIKE ? OR u.full_name ILIKE ?)", like, like)
	}
	if f.From != nil {
		q = q.Where("kt.created_at >= ?", *f.From)
	}
	if f.To != nil {
		q = q.Where("kt.created_at <= ?", *f.To)
	}
	return q
}

func (r *PurchaseRepository) List(f PurchaseFilter, limit, offset int) (*PurchaseListResponse, error) {
	var totals []purchaseTotalRow
	if err := r.scope(f).
		Select("kt.type AS type, COUNT(*) AS count, COALESCE(SUM(kt.amount), 0) AS ken").
		Group("kt.type").
		Scan(&totals).Error; err != nil {
		return nil, err
	}
	resp := &PurchaseListResponse{Items: []PurchaseItem{}}
	for _, t := range totals {
		resp.Total += t.Count
		switch t.Type {
		case models.KenTxTypeWordChainHint:
			resp.Summary.HintCount, resp.Summary.HintKen = t.Count, t.Ken
		case models.KenTxTypeWordChainGuess:
			resp.Summary.GuessCount, resp.Summary.GuessKen = t.Count, t.Ken
		}
	}
	if resp.Total == 0 || int64(offset) >= resp.Total {
		return resp, nil
	}

	var rows []purchaseRow
	if err := r.scope(f).
		Select("kt.id, kt.type, kt.amount, kt.metadata, kt.created_at, kt.user_id, " +
			"COALESCE(u.username, '') AS username, COALESCE(u.full_name, '') AS full_name, COALESCE(u.avatar, '') AS avatar").
		Order("kt.created_at DESC, kt.id DESC").
		Limit(limit).
		Offset(offset).
		Scan(&rows).Error; err != nil {
		return nil, err
	}
	resp.Items = make([]PurchaseItem, 0, len(rows))
	for _, row := range rows {
		resp.Items = append(resp.Items, toPurchaseItem(row))
	}
	return resp, nil
}

func toPurchaseItem(row purchaseRow) PurchaseItem {
	item := PurchaseItem{
		ID:        row.ID.String(),
		Type:      PurchaseTypeGuess,
		User:      PurchaseUser{ID: row.UserID.String(), Username: row.Username, FullName: row.FullName, Avatar: row.Avatar},
		Amount:    row.Amount,
		CreatedAt: row.CreatedAt.UTC().Format(time.RFC3339),
	}
	if row.Type == models.KenTxTypeWordChainHint {
		item.Type = PurchaseTypeHint
	}
	if word, ok := row.Metadata["word"].(string); ok {
		item.Word = word
	}
	if hints, ok := row.Metadata["hints"].([]interface{}); ok {
		for _, hint := range hints {
			if s, ok := hint.(string); ok {
				item.Hints = append(item.Hints, s)
			}
		}
	}
	if guesses, ok := row.Metadata["guesses"].(float64); ok {
		item.Guesses = int(guesses)
	}
	return item
}
