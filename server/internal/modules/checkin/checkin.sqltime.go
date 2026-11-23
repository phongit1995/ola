package checkin

import (
	"fmt"
	"time"

	"ola-chat-server/internal/utils"
)

func zoneOffsets() (vn, local int) {
	now := time.Now()
	_, vn = now.In(utils.VietnamTime).Zone()
	_, local = now.In(time.Local).Zone()
	return vn, local
}

func ZonedDayStartSQL(day string) string {
	vn, _ := zoneOffsets()
	return fmt.Sprintf("((%s::timestamp - make_interval(secs => %d)) AT TIME ZONE 'UTC')", day, vn)
}

func NaiveDayStartSQL(day string) string {
	vn, local := zoneOffsets()
	return fmt.Sprintf("(%s::timestamp - make_interval(secs => %d))", day, vn-local)
}

func NaiveFromZonedSQL(expr string) string {
	_, local := zoneOffsets()
	return fmt.Sprintf("((%s AT TIME ZONE 'UTC') + make_interval(secs => %d))", expr, local)
}

func ZonedFromNaiveSQL(expr string) string {
	_, local := zoneOffsets()
	return fmt.Sprintf("((%s - make_interval(secs => %d)) AT TIME ZONE 'UTC')", expr, local)
}
