package admindashboard

import (
	"sort"
	"time"
)

type Service struct {
	repo *Repository
}

func NewService(repo *Repository) *Service {
	return &Service{repo: repo}
}

func (s *Service) Overview(q OverviewQuery) (*OverviewResponse, error) {
	bucket := "day"
	if q.To.Sub(q.From) > 90*24*time.Hour {
		bucket = "month"
	}

	totals, err := s.repo.Totals()
	if err != nil {
		return nil, err
	}
	registrations, err := s.registrations()
	if err != nil {
		return nil, err
	}
	users, err := s.repo.Users(q)
	if err != nil {
		return nil, err
	}
	revenue, err := s.repo.Revenue(q)
	if err != nil {
		return nil, err
	}
	engagement, err := s.repo.Engagement(q)
	if err != nil {
		return nil, err
	}
	social, err := s.repo.Social(q)
	if err != nil {
		return nil, err
	}
	games, err := s.repo.Games(q)
	if err != nil {
		return nil, err
	}

	timeseries, err := s.buildTimeseries(q, bucket)
	if err != nil {
		return nil, err
	}

	return &OverviewResponse{
		Range:         RangeInfo{From: q.From.Format(time.RFC3339), To: q.To.Format(time.RFC3339)},
		Bucket:        bucket,
		Totals:        totals,
		Registrations: registrations,
		Users:         users,
		Revenue:       revenue,
		Engagement:    engagement,
		Social:        social,
		Games:         games,
		Timeseries:    timeseries,
	}, nil
}

func (s *Service) registrations() (RegistrationsSection, error) {
	var section RegistrationsSection
	now := time.Now()
	startOfToday := time.Date(now.Year(), now.Month(), now.Day(), 0, 0, 0, 0, now.Location())
	weekdayOffset := (int(startOfToday.Weekday()) + 6) % 7
	startOfWeek := startOfToday.AddDate(0, 0, -weekdayOffset)

	today, err := s.repo.CountUsersSince(startOfToday)
	if err != nil {
		return section, err
	}
	week, err := s.repo.CountUsersSince(startOfWeek)
	if err != nil {
		return section, err
	}
	section.Today = today
	section.Week = week
	return section, nil
}

func (s *Service) buildTimeseries(q OverviewQuery, bucket string) ([]TimePoint, error) {
	signups, err := s.repo.SignupSeries(q, bucket)
	if err != nil {
		return nil, err
	}
	topups, err := s.repo.TopupSeries(q, bucket)
	if err != nil {
		return nil, err
	}
	vip, err := s.repo.VipRevenueSeries(q, bucket)
	if err != nil {
		return nil, err
	}
	posts, err := s.repo.PostSeries(q, bucket)
	if err != nil {
		return nil, err
	}

	points := map[string]*TimePoint{}
	pointAt := func(date string) *TimePoint {
		if p, ok := points[date]; ok {
			return p
		}
		p := &TimePoint{Date: date}
		points[date] = p
		return p
	}
	for _, row := range signups {
		pointAt(row.Date).NewUsers = row.Value
	}
	for _, row := range topups {
		pointAt(row.Date).TopupKen = row.Value
	}
	for _, row := range vip {
		pointAt(row.Date).RevenueKen = row.Value
	}
	for _, row := range posts {
		pointAt(row.Date).Posts = row.Value
	}

	dates := make([]string, 0, len(points))
	for date := range points {
		dates = append(dates, date)
	}
	sort.Strings(dates)

	result := make([]TimePoint, len(dates))
	for i, date := range dates {
		result[i] = *points[date]
	}
	return result, nil
}
