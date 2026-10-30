package report

import "time"

const (
	ReportReasonSpam       = "spam"
	ReportReasonSensitive  = "sensitive"
	ReportReasonScam       = "scam"
	ReportReasonHarassment = "harassment"
	ReportReasonOther      = "other"
	ReportNoteMaxRunes     = 500
	ReportTargetIDMaxLen   = 64
	ErrorCodeReportExists  = "REPORT_ALREADY_SUBMITTED"
)

const (
	CacheKeyReportAlertTarget = "REPORT_ALERT:%s:%s:%s"
	CacheTTLReportAlertTarget = 10 * time.Minute
)

const (
	AlertSendTimeout            = 10 * time.Second
	AlertExcerptMaxRunes        = 200
	AlertResponseBodyLimit      = 2048
	AlertAdminReportsPath       = "/reports"
	AlertSenderName             = "Ola Chat"
	AlertDiscordColor           = 0xE53935
	AlertTelegramSendMessageURL = "https://api.telegram.org/bot%s/sendMessage"
	AlertTelegramParseMode      = "HTML"
	AlertTelegramMentionBreaker = "\u2060"
	AlertUnknownUserLabel       = "(không rõ tài khoản)"
)
