package checkin

import "time"

const (
	TaskMePost        = "me_post"
	TaskMeComment     = "me_comment"
	TaskMeReact       = "me_react"
	TaskMomentPost    = "moment_post"
	TaskMomentComment = "moment_comment"
	TaskStoryComment  = "story_comment"
	TaskSendGift      = "send_gift"
	TaskSendMegaphone = "send_megaphone"
	TaskPlayGame      = "play_game"
)

const (
	MaxGifts        = 5
	MaxOptions      = 10
	TotalWeight     = 100
	MaxItemDays     = 365
	MaxVipDays      = 3650
	MaxKenAmount    = 10000
	KenRandomStep   = 100
	KenRandomMin    = 100
	KenRandomMax    = 1000
	MaxSlotsInMonth = 31
)

const (
	SlotStatusClaimed    = "claimed"
	SlotStatusNone       = "none"
	SlotStatusMissed     = "missed"
	SlotStatusPending    = "pending"
	SlotStatusToday      = "today"
	SlotStatusUpcoming   = "upcoming"
	SlotStatusOutOfReach = "out_of_reach"

	BoxNone   = "none"
	BoxNormal = "normal"
	BoxBig    = "big"

	MissReasonTask      = "task"
	MissReasonVip       = "vip"
	MissReasonNotOpened = "not_opened"

	OpenReasonTaskPending = "task_pending"
	OpenReasonVipRequired = "vip_required"
)

const (
	MonthLayout = "2006-01"
	DayLayout   = "2006-01-02"

	KenRefTypeUserCheckin = "user_checkin"
)

const (
	ErrorCodeCheckinDisabled         = "CHECKIN_DISABLED"
	ErrorCodeCheckinCompleted        = "CHECKIN_COMPLETED"
	ErrorCodeCheckinEmailNotVerified = "CHECKIN_EMAIL_NOT_VERIFIED"
	ErrorCodeCheckinTaskNotDone      = "CHECKIN_TASK_NOT_DONE"
	ErrorCodeCheckinVipRequired      = "CHECKIN_VIP_REQUIRED"
	ErrorCodeCheckinNothingToOpen    = "CHECKIN_NOTHING_TO_OPEN"
)

const (
	CacheKeyCheckinMonth = "CHECKIN:MONTH:%s"
	CacheTTLCheckinMonth = time.Minute
)
