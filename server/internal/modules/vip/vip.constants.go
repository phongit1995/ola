package vip

const (
	CacheKeyVipPackages = "VIP:PACKAGES:ACTIVE"

	CacheTTLVipPackages = 3600

	ErrorCodeVipNotTransferable = "VIP_NOT_TRANSFERABLE"
	ErrorCodeVipIconExpired     = "VIP_ICON_EXPIRED"
	ErrorCodeVipExpiryInPast    = "VIP_ICON_EXPIRY_IN_PAST"
	ErrorCodeVipExpiryKindFixed = "VIP_ICON_EXPIRY_KIND_FIXED"
	ErrorCodeDayTransferOff     = "VIP_DAY_TRANSFER_DISABLED"
	ErrorCodeDayTransferDays    = "VIP_DAY_TRANSFER_INVALID_DAYS"
	ErrorCodeDayTransferBalance = "VIP_DAY_TRANSFER_NOT_ENOUGH_DAYS"
	ErrorCodeDayTransferRate    = "VIP_DAY_TRANSFER_RATE_CHANGED"
)
