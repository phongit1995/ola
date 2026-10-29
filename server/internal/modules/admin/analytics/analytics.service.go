package adminanalytics

import (
	"context"
	"fmt"
	"sort"
	"strconv"
	"strings"
	"sync"
	"time"

	"go.uber.org/zap"
	analyticsdata "google.golang.org/api/analyticsdata/v1beta"

	"ola-chat-server/internal/config"
	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/modules/setting"
	"ola-chat-server/internal/services"
)

const (
	dateLayout       = "2006-01-02"
	gaDateLayout     = "20060102"
	batchLimit       = 5
	screenLimit      = 15
	countryLimit     = 10
	eventLimit       = 20
	versionLimit     = 15
	dailyRowLimit    = 5000
	notSetDimension  = "(not set)"
	engagementMetric = "userEngagementDuration"
)

const (
	reportPlatforms = iota
	reportDaily
	reportScreens
	reportCountries
	reportEvents
	reportVersions
)

var gaPlatformNames = map[string]string{
	PlatformAndroid: "Android",
	PlatformIOS:     "iOS",
	PlatformWeb:     "web",
}

type Service struct {
	settings *setting.Service
	cfg      *config.Config
	cache    *services.CacheService
	client   *gaClient
	logger   *zap.SugaredLogger
}

func NewService(settings *setting.Service, cfg *config.Config, cache *services.CacheService, logger *zap.SugaredLogger) *Service {
	return &Service{
		settings: settings,
		cfg:      cfg,
		cache:    cache,
		client:   &gaClient{},
		logger:   logger.Named("[admin_analytics_service]"),
	}
}

type source struct {
	name       string
	propertyID string
}

type connection struct {
	setup   Setup
	sources []source
	svc     *analyticsdata.Service
	err     error
}

func (s *Service) connect(platform string) (connection, error) {
	cfg, err := s.settings.GetAnalytics()
	if err != nil {
		return connection{}, err
	}
	account, configured, err := s.settings.GetGoogleServiceAccount(s.cfg)
	if err != nil {
		s.logger.Warnw("Failed to load Google service account", "error", err.Error())
	}
	conn := connection{
		setup: Setup{
			CredentialConfigured: configured,
			ClientEmail:          account.ClientEmail,
			MobilePropertyID:     cfg.MobilePropertyID,
			WebPropertyID:        cfg.WebPropertyID,
		},
	}
	if cfg.MobilePropertyID != "" && platform != PlatformWeb {
		conn.sources = append(conn.sources, source{name: SourceMobile, propertyID: cfg.MobilePropertyID})
	}
	if cfg.WebPropertyID != "" && (platform == PlatformAll || platform == PlatformWeb) {
		conn.sources = append(conn.sources, source{name: SourceWeb, propertyID: cfg.WebPropertyID})
	}
	if !configured || len(conn.sources) == 0 {
		return conn, nil
	}
	conn.svc, conn.err = s.client.service(account.JSON)
	return conn, nil
}

func (c connection) ready() bool {
	return c.setup.CredentialConfigured && len(c.sources) > 0
}

func (c connection) cacheKey(pattern string, parts ...string) string {
	all := append(parts, c.setup.MobilePropertyID, c.setup.WebPropertyID)
	return fmt.Sprintf(pattern, strings.Join(all, ":"))
}

func (c connection) each(fetch func(int, source) error) ([]SourceStatus, []bool) {
	statuses := make([]SourceStatus, len(c.sources))
	succeeded := make([]bool, len(c.sources))
	var wg sync.WaitGroup
	for i, src := range c.sources {
		statuses[i] = SourceStatus{Source: src.name, PropertyID: src.propertyID}
		if c.err != nil {
			statuses[i].Error = friendlyError(c.err)
			continue
		}
		wg.Add(1)
		go func(i int, src source) {
			defer wg.Done()
			if err := fetch(i, src); err != nil {
				statuses[i].Error = friendlyError(err)
				return
			}
			succeeded[i] = true
		}(i, src)
	}
	wg.Wait()
	return statuses, succeeded
}

func allSucceeded(flags []bool) bool {
	for _, ok := range flags {
		if !ok {
			return false
		}
	}
	return true
}

func (s *Service) Overview(ctx context.Context, q OverviewQuery) (*OverviewResponse, error) {
	conn, err := s.connect(q.Platform)
	if err != nil {
		return nil, err
	}
	resp := &OverviewResponse{Setup: conn.setup, Sources: []SourceStatus{}, From: q.From, To: q.To}
	if !conn.ready() {
		newAggregate(q.From, q.To).fill(resp)
		return resp, nil
	}

	key := conn.cacheKey(constants.CacheKeyAdminAnalyticsOverview, q.From, q.To, q.Platform)
	if !q.Refresh {
		var cached OverviewResponse
		if err := s.cache.Get(key, &cached); err == nil {
			cached.Setup = conn.setup
			return &cached, nil
		}
	}

	reports := make([][]*analyticsdata.RunReportResponse, len(conn.sources))
	statuses, succeeded := conn.each(func(i int, src source) error {
		result, err := fetchOverviewReports(ctx, conn.svc, src, q)
		reports[i] = result
		return err
	})

	agg := newAggregate(q.From, q.To)
	for i := range conn.sources {
		if succeeded[i] {
			agg.add(reports[i])
		}
	}
	agg.fill(resp)
	resp.Sources = statuses
	now := time.Now()
	resp.FetchedAt = &now
	if allSucceeded(succeeded) {
		if err := s.cache.Set(key, resp, constants.AdminAnalyticsOverviewTTL); err != nil {
			s.logger.Warnw("Failed to cache analytics overview", "error", err.Error())
		}
	}
	return resp, nil
}

func (s *Service) Realtime(ctx context.Context, q RealtimeQuery) (*RealtimeResponse, error) {
	conn, err := s.connect(q.Platform)
	if err != nil {
		return nil, err
	}
	resp := &RealtimeResponse{Sources: []SourceStatus{}, Platforms: []RealtimePlatform{}}
	if !conn.ready() {
		return resp, nil
	}

	key := conn.cacheKey(constants.CacheKeyAdminAnalyticsRealtime, q.Platform)
	if !q.Refresh {
		var cached RealtimeResponse
		if err := s.cache.Get(key, &cached); err == nil {
			return &cached, nil
		}
	}

	var mu sync.Mutex
	byPlatform := map[string]int64{}
	statuses, succeeded := conn.each(func(_ int, src source) error {
		report, err := conn.svc.Properties.RunRealtimeReport(propertyName(src.propertyID), &analyticsdata.RunRealtimeReportRequest{
			Dimensions:      []*analyticsdata.Dimension{{Name: "platform"}},
			Metrics:         []*analyticsdata.Metric{{Name: "activeUsers"}},
			DimensionFilter: platformFilter(q.Platform),
		}).Context(ctx).Do()
		if err != nil {
			return err
		}
		mu.Lock()
		defer mu.Unlock()
		for _, row := range report.Rows {
			byPlatform[normalizePlatform(dimension(row, 0))] += metric(row, 0)
		}
		return nil
	})

	for platform, users := range byPlatform {
		resp.ActiveUsers += users
		resp.Platforms = append(resp.Platforms, RealtimePlatform{Platform: platform, ActiveUsers: users})
	}
	sort.Slice(resp.Platforms, func(i, j int) bool { return resp.Platforms[i].ActiveUsers > resp.Platforms[j].ActiveUsers })
	resp.Sources = statuses
	now := time.Now()
	resp.FetchedAt = &now
	if allSucceeded(succeeded) {
		if err := s.cache.Set(key, resp, constants.AdminAnalyticsRealtimeTTL); err != nil {
			s.logger.Warnw("Failed to cache analytics realtime", "error", err.Error())
		}
	}
	return resp, nil
}

func fetchOverviewReports(ctx context.Context, svc *analyticsdata.Service, src source, q OverviewQuery) ([]*analyticsdata.RunReportResponse, error) {
	requests := overviewRequests(q, src.name == SourceMobile)
	out := make([]*analyticsdata.RunReportResponse, 0, len(requests))
	for start := 0; start < len(requests); start += batchLimit {
		end := min(start+batchLimit, len(requests))
		resp, err := svc.Properties.BatchRunReports(propertyName(src.propertyID), &analyticsdata.BatchRunReportsRequest{
			Requests: requests[start:end],
		}).Context(ctx).Do()
		if err != nil {
			return nil, err
		}
		out = append(out, resp.Reports...)
	}
	return out, nil
}

func overviewRequests(q OverviewQuery, withVersions bool) []*analyticsdata.RunReportRequest {
	dateRanges := []*analyticsdata.DateRange{{StartDate: q.From, EndDate: q.To}}
	filter := platformFilter(q.Platform)
	build := func(dims []string, metrics []string, orderBy string, limit int64) *analyticsdata.RunReportRequest {
		req := &analyticsdata.RunReportRequest{
			DateRanges:      dateRanges,
			DimensionFilter: filter,
			Limit:           limit,
		}
		for _, name := range dims {
			req.Dimensions = append(req.Dimensions, &analyticsdata.Dimension{Name: name})
		}
		for _, name := range metrics {
			req.Metrics = append(req.Metrics, &analyticsdata.Metric{Name: name})
		}
		if orderBy != "" {
			req.OrderBys = []*analyticsdata.OrderBy{{Desc: true, Metric: &analyticsdata.MetricOrderBy{MetricName: orderBy}}}
		}
		return req
	}
	requests := []*analyticsdata.RunReportRequest{
		reportPlatforms: build([]string{"platform"}, []string{"activeUsers", "newUsers", "sessions", "screenPageViews", engagementMetric}, "", 0),
		reportDaily:     build([]string{"date", "platform"}, []string{"activeUsers", "newUsers", "sessions"}, "", dailyRowLimit),
		reportScreens:   build([]string{"unifiedPagePathScreen"}, []string{"screenPageViews", "activeUsers"}, "screenPageViews", screenLimit),
		reportCountries: build([]string{"country"}, []string{"activeUsers"}, "activeUsers", countryLimit),
		reportEvents:    build([]string{"eventName"}, []string{"eventCount", "totalUsers"}, "eventCount", eventLimit),
	}
	if withVersions {
		requests = append(requests, build([]string{"platform", "appVersion"}, []string{"activeUsers"}, "activeUsers", versionLimit))
	}
	return requests
}

func platformFilter(platform string) *analyticsdata.FilterExpression {
	name, ok := gaPlatformNames[platform]
	if !ok {
		return nil
	}
	return &analyticsdata.FilterExpression{
		Filter: &analyticsdata.Filter{
			FieldName:    "platform",
			StringFilter: &analyticsdata.StringFilter{MatchType: "EXACT", Value: name},
		},
	}
}

func normalizePlatform(value string) string {
	return strings.ToLower(strings.TrimSpace(value))
}

func dimension(row *analyticsdata.Row, i int) string {
	if i >= len(row.DimensionValues) {
		return ""
	}
	return row.DimensionValues[i].Value
}

func metricFloat(row *analyticsdata.Row, i int) float64 {
	if i >= len(row.MetricValues) {
		return 0
	}
	value, err := strconv.ParseFloat(row.MetricValues[i].Value, 64)
	if err != nil {
		return 0
	}
	return value
}

func metric(row *analyticsdata.Row, i int) int64 {
	return int64(metricFloat(row, i))
}

type aggregate struct {
	platforms  map[string]*PlatformRow
	engagement float64
	days       map[string]*TimePoint
	dayOrder   []string
	screens    map[string]*NamedRow
	countries  map[string]*NamedRow
	events     map[string]*NamedRow
	versions   []VersionRow
}

func newAggregate(from, to string) *aggregate {
	agg := &aggregate{
		platforms: map[string]*PlatformRow{},
		days:      map[string]*TimePoint{},
		screens:   map[string]*NamedRow{},
		countries: map[string]*NamedRow{},
		events:    map[string]*NamedRow{},
	}
	start, errFrom := time.Parse(dateLayout, from)
	end, errTo := time.Parse(dateLayout, to)
	if errFrom != nil || errTo != nil {
		return agg
	}
	for day := start; !day.After(end); day = day.AddDate(0, 0, 1) {
		key := day.Format(dateLayout)
		agg.days[key] = &TimePoint{Date: key}
		agg.dayOrder = append(agg.dayOrder, key)
	}
	return agg
}

func reportAt(reports []*analyticsdata.RunReportResponse, i int) []*analyticsdata.Row {
	if i >= len(reports) || reports[i] == nil {
		return nil
	}
	return reports[i].Rows
}

func (a *aggregate) add(reports []*analyticsdata.RunReportResponse) {
	for _, row := range reportAt(reports, reportPlatforms) {
		platform := normalizePlatform(dimension(row, 0))
		item, ok := a.platforms[platform]
		if !ok {
			item = &PlatformRow{Platform: platform}
			a.platforms[platform] = item
		}
		item.ActiveUsers += metric(row, 0)
		item.NewUsers += metric(row, 1)
		item.Sessions += metric(row, 2)
		item.Views += metric(row, 3)
		a.engagement += metricFloat(row, 4)
	}
	for _, row := range reportAt(reports, reportDaily) {
		day, err := time.Parse(gaDateLayout, dimension(row, 0))
		if err != nil {
			continue
		}
		point, ok := a.days[day.Format(dateLayout)]
		if !ok {
			continue
		}
		users := metric(row, 0)
		switch normalizePlatform(dimension(row, 1)) {
		case PlatformAndroid:
			point.Android += users
		case PlatformIOS:
			point.IOS += users
		case PlatformWeb:
			point.Web += users
		}
		point.NewUsers += metric(row, 1)
		point.Sessions += metric(row, 2)
	}
	for _, row := range reportAt(reports, reportScreens) {
		mergeNamed(a.screens, dimension(row, 0), metric(row, 0), metric(row, 1))
	}
	for _, row := range reportAt(reports, reportCountries) {
		mergeNamed(a.countries, dimension(row, 0), metric(row, 0), metric(row, 0))
	}
	for _, row := range reportAt(reports, reportEvents) {
		mergeNamed(a.events, dimension(row, 0), metric(row, 0), metric(row, 1))
	}
	for _, row := range reportAt(reports, reportVersions) {
		a.versions = append(a.versions, VersionRow{
			Platform: normalizePlatform(dimension(row, 0)),
			Version:  dimension(row, 1),
			Users:    metric(row, 0),
		})
	}
}

func mergeNamed(rows map[string]*NamedRow, name string, count, users int64) {
	if name == "" {
		name = notSetDimension
	}
	item, ok := rows[name]
	if !ok {
		item = &NamedRow{Name: name}
		rows[name] = item
	}
	item.Count += count
	item.Users += users
}

func topNamed(rows map[string]*NamedRow, limit int) []NamedRow {
	out := make([]NamedRow, 0, len(rows))
	for _, item := range rows {
		out = append(out, *item)
	}
	sort.Slice(out, func(i, j int) bool {
		if out[i].Count != out[j].Count {
			return out[i].Count > out[j].Count
		}
		return out[i].Name < out[j].Name
	})
	if len(out) > limit {
		out = out[:limit]
	}
	return out
}

func (a *aggregate) fill(resp *OverviewResponse) {
	resp.Platforms = make([]PlatformRow, 0, len(a.platforms))
	for _, item := range a.platforms {
		resp.Platforms = append(resp.Platforms, *item)
		resp.Totals.ActiveUsers += item.ActiveUsers
		resp.Totals.NewUsers += item.NewUsers
		resp.Totals.Sessions += item.Sessions
		resp.Totals.Views += item.Views
	}
	sort.Slice(resp.Platforms, func(i, j int) bool { return resp.Platforms[i].ActiveUsers > resp.Platforms[j].ActiveUsers })
	if resp.Totals.ActiveUsers > 0 {
		resp.Totals.AvgEngagementSeconds = a.engagement / float64(resp.Totals.ActiveUsers)
	}

	resp.Timeseries = make([]TimePoint, 0, len(a.dayOrder))
	for _, key := range a.dayOrder {
		resp.Timeseries = append(resp.Timeseries, *a.days[key])
	}
	resp.Screens = topNamed(a.screens, screenLimit)
	resp.Countries = topNamed(a.countries, countryLimit)
	resp.Events = topNamed(a.events, eventLimit)

	sort.Slice(a.versions, func(i, j int) bool { return a.versions[i].Users > a.versions[j].Users })
	if len(a.versions) > versionLimit {
		a.versions = a.versions[:versionLimit]
	}
	resp.AppVersions = append([]VersionRow{}, a.versions...)
}
