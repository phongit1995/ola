package models

import "time"

const ItemNotExpiredSQL = "(expires_at IS NULL OR expires_at > ?)"

type ItemGrant struct {
	Locked   bool
	Duration time.Duration
}

var PermanentGrant = ItemGrant{}

var PermanentLockedGrant = ItemGrant{Locked: true}

func LockedGrantForDays(days int) ItemGrant {
	if days <= 0 {
		return PermanentLockedGrant
	}
	return ItemGrant{Locked: true, Duration: time.Duration(days) * 24 * time.Hour}
}

func (g ItemGrant) Normalized() ItemGrant {
	if g.Duration < 0 {
		g.Duration = 0
	}
	if g.Duration > 0 {
		g.Locked = true
	}
	return g
}

func (g ItemGrant) ExpiresAt(now time.Time) *time.Time {
	if g.Duration <= 0 {
		return nil
	}
	t := now.Add(g.Duration)
	return &t
}

func ItemExpired(expiresAt *time.Time, now time.Time) bool {
	return expiresAt != nil && !expiresAt.After(now)
}

func ActiveVipUsedSQL(alias string) string {
	return "CASE WHEN " + alias + ".vip_used_expires_at IS NULL OR " + alias + ".vip_used_expires_at > now() THEN " + alias + ".vip_used END"
}

func ActiveAvatarFrameIDSQL(alias string) string {
	return "CASE WHEN " + alias + ".avatar_frame_expires_at IS NULL OR " + alias + ".avatar_frame_expires_at > now() THEN " + alias + ".avatar_frame_id END"
}
