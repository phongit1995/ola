package topup

import "encoding/json"

type WebhookTransaction struct {
	TransactionID string      `json:"transactionID"`
	Description   string      `json:"description"`
	Amount        json.Number `json:"amount"`
	Type          string      `json:"type"`
}

type WebhookRequest struct {
	Transactions []WebhookTransaction `json:"transactions"`
}

type WebhookResponse struct {
	Status bool   `json:"status"`
	Msg    string `json:"msg"`
}
