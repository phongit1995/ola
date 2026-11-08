package avatarframe

const (
	FrameIDLength = 3

	DefaultStoreLimit   = 50
	MaxStoreLimit       = 100
	DefaultHistoryLimit = 20
	MaxHistoryLimit     = 100

	KenRefTypePurchase = "avatar_frame_purchase"

	ErrorCodeShopItemNotFound = "AVATAR_FRAME_SHOP_ITEM_NOT_FOUND"
	ErrorCodeInvalidFrameID   = "AVATAR_FRAME_INVALID_ID"
	ErrorCodePriceChanged     = "AVATAR_FRAME_PRICE_CHANGED"
	ErrorCodeAlreadyOwned     = "AVATAR_FRAME_ALREADY_OWNED"
	ErrorCodeReceiverOwns     = "AVATAR_FRAME_RECEIVER_OWNS"
	ErrorCodeNotOwned         = "AVATAR_FRAME_NOT_OWNED"
	ErrorCodeInUse            = "AVATAR_FRAME_IN_USE"
	ErrorCodeVipRequired      = "AVATAR_FRAME_VIP_REQUIRED"
	ErrorCodeInsufficientKen  = "AVATAR_FRAME_INSUFFICIENT_KEN"
	ErrorCodeWrongPassword    = "AVATAR_FRAME_WRONG_PASSWORD"
	ErrorCodeReceiverNotFound = "AVATAR_FRAME_RECEIVER_NOT_FOUND"
	ErrorCodeSelfTarget       = "AVATAR_FRAME_SELF_TARGET"
	ErrorCodeBlocked          = "AVATAR_FRAME_BLOCKED"
	ErrorCodePrivateStore     = "AVATAR_FRAME_PRIVATE_STORE"
)
