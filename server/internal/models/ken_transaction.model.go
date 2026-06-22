package models

import "github.com/google/uuid"

type KenDirection string

const (
	KenDirectionCredit KenDirection = "credit"
	KenDirectionDebit  KenDirection = "debit"
)

type KenTxType string

const (
	KenTxTypeVipPackage   KenTxType = "VIP_PACKAGE"
	KenTxTypeVipIcon      KenTxType = "VIP_ICON"
	KenTxTypeAdminGrant   KenTxType = "ADMIN_GRANT"
	KenTxTypeAdminDeduct  KenTxType = "ADMIN_DEDUCT"
	KenTxTypeReward       KenTxType = "REWARD"
	KenTxTypeEggOpen      KenTxType = "EGG_OPEN"
	KenTxTypeTopup        KenTxType = "TOPUP"
	KenTxTypeRefund       KenTxType = "REFUND"
	KenTxTypeGiftSent     KenTxType = "GIFT_SENT"
	KenTxTypeGiftReceived KenTxType = "GIFT_RECEIVED"
	KenTxTypeTransferIn   KenTxType = "TRANSFER_IN"
	KenTxTypeTransferOut  KenTxType = "TRANSFER_OUT"
)

type KenActorType string

const (
	KenActorSystem KenActorType = "system"
	KenActorAdmin  KenActorType = "admin"
	KenActorUser   KenActorType = "user"
)

type KenTransaction struct {
	BaseModel
	UserID        uuid.UUID    `gorm:"type:uuid;not null;index:idx_ken_tx_user,priority:1"`
	Direction     KenDirection `gorm:"type:varchar(10);not null"`
	Type          KenTxType    `gorm:"type:varchar(40);not null"`
	Amount        int          `gorm:"not null"`
	BalanceBefore int          `gorm:"not null"`
	BalanceAfter  int          `gorm:"not null"`
	Description   string       `gorm:"type:varchar(255)"`
	RefType       string       `gorm:"type:varchar(40)"`
	RefID         *uuid.UUID   `gorm:"type:uuid"`
	ActorType     KenActorType `gorm:"type:varchar(20)"`
	ActorID       *uuid.UUID   `gorm:"type:uuid"`
	Metadata      JSONB        `gorm:"type:jsonb"`
}

func (KenTransaction) TableName() string {
	return "ken_transactions"
}
