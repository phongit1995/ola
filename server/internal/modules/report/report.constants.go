package report

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
