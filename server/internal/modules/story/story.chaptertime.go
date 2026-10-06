package story

import (
	"regexp"
	"strconv"
	"strings"
	"time"

	"ola-chat-server/internal/constants"
)

var chapterStampPattern = regexp.MustCompile(`^(\d{1,2})/(\d{1,2})/(\d{4})(?:\s+lúc\s+(\d{1,2}):(\d{2}))?`)

var sourceZone = time.FixedZone("ICT", constants.StoryVnkingsUTCOffsetSeconds)

type chapterStamp struct {
	day    time.Time
	clock  bool
	hour12 int
	minute int
}

func parseChapterStamp(label string) (chapterStamp, bool) {
	match := chapterStampPattern.FindStringSubmatch(strings.TrimSpace(label))
	if match == nil {
		return chapterStamp{}, false
	}
	day, _ := strconv.Atoi(match[1])
	month, _ := strconv.Atoi(match[2])
	year, _ := strconv.Atoi(match[3])
	stamp := chapterStamp{day: time.Date(year, time.Month(month), day, 0, 0, 0, 0, sourceZone)}
	if match[4] != "" {
		hour, _ := strconv.Atoi(match[4])
		minute, _ := strconv.Atoi(match[5])
		if hour >= 1 && hour <= 12 && minute < 60 {
			stamp.clock, stamp.hour12, stamp.minute = true, hour, minute
		}
	}
	return stamp, true
}

func (s chapterStamp) candidates() [2]time.Time {
	morning := s.day.Add(time.Duration(s.hour12%12)*time.Hour + time.Duration(s.minute)*time.Minute)
	return [2]time.Time{morning, morning.Add(12 * time.Hour)}
}

func chapterDate(label string) *time.Time {
	stamp, ok := parseChapterStamp(label)
	if !ok {
		return nil
	}
	day := stamp.day.UTC()
	return &day
}

func chapterTimes(labels []string, now time.Time, anchors ...time.Time) []*time.Time {
	stamps := make([]chapterStamp, len(labels))
	parsed := make([]bool, len(labels))
	for i, label := range labels {
		stamps[i], parsed[i] = parseChapterStamp(label)
	}
	resolved := make([]*time.Time, len(labels))
	for i, stamp := range stamps {
		if !parsed[i] || !stamp.clock {
			continue
		}
		var matches []time.Time
		for _, candidate := range stamp.candidates() {
			if candidate.After(now) {
				continue
			}
			for _, anchor := range anchors {
				if !anchor.IsZero() && candidate.Sub(anchor).Abs() <= constants.StoryChapterAnchorTolerance {
					matches = append(matches, candidate)
					break
				}
			}
		}
		if len(matches) == 1 {
			resolved[i] = &matches[0]
		}
	}
	chronological := daysInOrder(stamps, parsed)
	for changed := true; changed; {
		changed = false
		for i, stamp := range stamps {
			if resolved[i] != nil || !parsed[i] || !stamp.clock {
				continue
			}
			var lower, upper *time.Time
			if chronological {
				lower, upper = resolvedNeighbours(resolved, i)
			}
			var fits []time.Time
			for _, candidate := range stamp.candidates() {
				if candidate.After(now) || (lower != nil && candidate.Before(*lower)) || (upper != nil && candidate.After(*upper)) {
					continue
				}
				fits = append(fits, candidate)
			}
			if len(fits) == 1 {
				resolved[i] = &fits[0]
				changed = true
			}
		}
	}
	times := make([]*time.Time, len(labels))
	for i, stamp := range stamps {
		switch {
		case resolved[i] != nil:
			value := resolved[i].UTC()
			times[i] = &value
		case parsed[i]:
			day := stamp.day.UTC()
			times[i] = &day
		}
	}
	return times
}

func daysInOrder(stamps []chapterStamp, parsed []bool) bool {
	var previous time.Time
	for i, stamp := range stamps {
		if !parsed[i] {
			continue
		}
		if stamp.day.Before(previous) {
			return false
		}
		previous = stamp.day
	}
	return true
}

func resolvedNeighbours(resolved []*time.Time, index int) (*time.Time, *time.Time) {
	var lower, upper *time.Time
	for i := index - 1; i >= 0; i-- {
		if resolved[i] != nil {
			lower = resolved[i]
			break
		}
	}
	for i := index + 1; i < len(resolved); i++ {
		if resolved[i] != nil {
			upper = resolved[i]
			break
		}
	}
	return lower, upper
}
