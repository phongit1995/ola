package checkin

import (
	"database/sql"
	"errors"
	"fmt"
	"strings"
	"time"

	"ola-chat-server/internal/game/progression"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/setting"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

const taskUserToken = "{user}"

type taskBranch struct {
	column string
	source string
}

type taskGate int

const (
	gateNone taskGate = iota
	gateStory
	gateMoment
	gateGift
	gateMegaphone
)

type taskDef struct {
	code     string
	inRandom bool
	naive    bool
	gate     taskGate
	branches []taskBranch
}

func single(column, source string) []taskBranch {
	return []taskBranch{{column: column, source: source}}
}

func finishedMatch(prefix string) string {
	return fmt.Sprintf(`%[1]sstatus = '%[2]s' AND %[1]sreason <> '%[3]s' AND %[1]sdeleted_at IS NULL`, prefix, models.GameMatchStatusFinished, progression.ReasonVoid)
}

var taskRegistry = []taskDef{
	{code: TaskMePost, inRandom: true, naive: true, branches: single("created_at", `me WHERE author_id = {user} AND clan_id IS NULL AND enabled AND deleted_at IS NULL`)},
	{code: TaskMeComment, inRandom: true, naive: true, branches: single("created_at", `me_comments WHERE author_id = {user} AND deleted_at IS NULL`)},
	{code: TaskMeReact, inRandom: true, naive: true, branches: single("updated_at", `me_reactions WHERE user_id = {user}`)},
	{code: TaskMomentPost, inRandom: true, gate: gateMoment, branches: single("created_at", `moments WHERE author_id = {user} AND deleted_at IS NULL`)},
	{code: TaskMomentComment, inRandom: true, gate: gateMoment, branches: single("created_at", `moment_comments WHERE author_id = {user}`)},
	{code: TaskStoryComment, inRandom: true, gate: gateStory, branches: single("created_at", `story_comments WHERE author_id = {user} AND deleted_at IS NULL`)},
	{code: TaskSendGift, gate: gateGift, branches: single("created_at", `gift_transactions WHERE sender_id = {user}`)},
	{code: TaskSendMegaphone, gate: gateMegaphone, branches: single("created_at", fmt.Sprintf(`megaphones WHERE sender_id = {user} AND type = '%s'`, models.MegaphoneTypeMessage))},
	{code: TaskPlayGame, inRandom: true, branches: []taskBranch{
		{column: "finished_at", source: `game_matches WHERE player0_id = {user} AND ` + finishedMatch("")},
		{column: "finished_at", source: `game_matches WHERE player1_id = {user} AND ` + finishedMatch("")},
		{column: "gm.finished_at", source: `game_match_players gmp JOIN game_matches gm ON gm.id = gmp.game_match_id WHERE gmp.user_id = {user} AND gm.player_count > 2 AND ` + finishedMatch("gm.")},
	}},
}

func (b taskBranch) firstSQL(user, from, to string) string {
	source := strings.ReplaceAll(b.source, taskUserToken, user)
	return fmt.Sprintf("SELECT %[1]s AS done_at FROM %[2]s AND %[1]s >= %[3]s AND %[1]s < %[4]s ORDER BY %[1]s LIMIT 1", b.column, source, from, to)
}

func (d taskDef) firstDoneSQL(user, from, to string) string {
	if len(d.branches) == 1 {
		return d.branches[0].firstSQL(user, from, to)
	}
	parts := make([]string, 0, len(d.branches))
	for _, b := range d.branches {
		parts = append(parts, "("+b.firstSQL(user, from, to)+")")
	}
	return "SELECT MIN(done_at) FROM (" + strings.Join(parts, " UNION ALL ") + ") AS branches"
}

func (d taskDef) userRefs() int {
	refs := 0
	for _, b := range d.branches {
		refs += strings.Count(b.source, taskUserToken)
	}
	return refs
}

func findTask(code string) (taskDef, bool) {
	for _, def := range taskRegistry {
		if def.code == code {
			return def, true
		}
	}
	return taskDef{}, false
}

func IsTaskCode(code string) bool {
	_, ok := findTask(code)
	return ok
}

func IsSlotTask(code string) bool {
	return code == models.CheckinTaskRandom || IsTaskCode(code)
}

func DefaultRandomTasks() []string {
	codes := make([]string, 0, len(taskRegistry))
	for _, def := range taskRegistry {
		if def.inRandom {
			codes = append(codes, def.code)
		}
	}
	return codes
}

func TaskDoneAt(db *gorm.DB, code string, userID uuid.UUID, from, to time.Time) (*time.Time, error) {
	def, ok := findTask(code)
	if !ok {
		return nil, nil
	}
	args := make([]interface{}, 0, def.userRefs()+2*len(def.branches))
	for _, b := range def.branches {
		for i := strings.Count(b.source, taskUserToken); i > 0; i-- {
			args = append(args, userID)
		}
		args = append(args, from.In(time.Local), to.In(time.Local))
	}
	query := def.firstDoneSQL("?", "?", "?")
	var doneAt sql.NullTime
	if err := db.Raw(query, args...).Row().Scan(&doneAt); err != nil {
		if errors.Is(err, sql.ErrNoRows) {
			return nil, nil
		}
		return nil, err
	}
	if !doneAt.Valid {
		return nil, nil
	}
	t := doneAt.Time
	if def.naive {
		t = time.Date(t.Year(), t.Month(), t.Day(), t.Hour(), t.Minute(), t.Second(), t.Nanosecond(), time.Local)
	}
	return &t, nil
}

func BackfillMissedTaskDone(db *gorm.DB, month, from, today time.Time) error {
	return backfillMissedTaskDone(db, today, "month = ? AND day >= ?", month, from)
}

func BackfillTaskDoneByIDs(db *gorm.DB, ids []uuid.UUID, today time.Time) error {
	if len(ids) == 0 {
		return nil
	}
	return backfillMissedTaskDone(db, today, "id IN ?", ids)
}

func backfillMissedTaskDone(db *gorm.DB, today time.Time, scope string, scopeArgs ...interface{}) error {
	for _, def := range taskRegistry {
		dayStart := "c.day_start"
		dayEnd := "c.day_start + interval '1 day'"
		found := "(" + def.firstDoneSQL("c.user_id", dayStart, dayEnd) + ")"
		start := ZonedDayStartSQL("day")
		if def.naive {
			start = NaiveDayStartSQL("day")
			found = ZonedFromNaiveSQL(found)
		}
		query := fmt.Sprintf(`UPDATE user_checkins AS uc SET task_done_at = found.done_at
FROM (
	SELECT c.id, %s AS done_at
	FROM (SELECT id, user_id, %s AS day_start FROM user_checkins WHERE %s AND task = ? AND task_done_at IS NULL AND reward_status = ? AND day < ?) AS c
) AS found
WHERE uc.id = found.id AND found.done_at IS NOT NULL`, found, start, scope)
		args := append(append([]interface{}{}, scopeArgs...), def.code, models.CheckinRewardStatusPending, today)
		if err := db.Exec(query, args...).Error; err != nil {
			return err
		}
	}
	return nil
}

func filterTasks(codes []string, keep func(string) bool) []string {
	out := make([]string, 0, len(codes))
	for _, code := range codes {
		if keep(code) {
			out = append(out, code)
		}
	}
	return out
}

func PickableTasks(cfg setting.CheckinConfig, available func(string) bool) []string {
	if tasks := filterTasks(RandomTasks(cfg), available); len(tasks) > 0 {
		return tasks
	}
	return filterTasks(DefaultRandomTasks(), available)
}
