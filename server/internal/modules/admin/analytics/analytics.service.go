package adminanalytics

import (
	"context"
	"fmt"
	"math"
	"slices"
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
	mergeRowLimit    = 10000
	mergeRowCap      = 50000
	notSetDimension  = "(not set)"
	engagementMetric = "userEngagementDuration"
)

const (
	reportTotals = iota
	reportPlatforms
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

var (
	appPlatforms = []string{PlatformAndroid, PlatformIOS}
	allPlatforms = []string{PlatformAndroid, PlatformIOS, PlatformWeb}
)

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
	platforms  []string
}

func (src source) appScope() []string {
	out := make([]string, 0, len(appPlatforms))
	for _, platform := range src.platforms {
		if slices.Contains(appPlatforms, platform) {
			out = append(out, platform)
		}
	}
	return out
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
	conn.sources = scopedSources(cfg, platform)
	if !configured || len(conn.sources) == 0 {
		return conn, nil
	}
	conn.svc, conn.err = s.client.service(account.JSON)
	return conn, nil
}

func scopedSources(cfg setting.AnalyticsConfig, platform string) []source {
	var all []source
	if cfg.MobilePropertyID != "" && cfg.MobilePropertyID == cfg.WebPropertyID {
		all = []source{{name: SourceAll, propertyID: cfg.MobilePropertyID, platforms: allPlatforms}}
	} else {
		if cfg.MobilePropertyID != "" {
			all = append(all, source{name: SourceMobile, propertyID: cfg.MobilePropertyID, platforms: appPlatforms})
		}
		if cfg.WebPropertyID != "" {
			all = append(all, source{name: SourceWeb, propertyID: cfg.WebPropertyID, platforms: []string{PlatformWeb}})
		}
	}
	if platform == PlatformAll {
		return all
	}
	out := make([]source, 0, 1)
	for _, src := range all {
		if slices.Contains(src.platforms, platform) {
			src.platforms = []string{platform}
			out = append(out, src)
		}
	}
	return out
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

func countSucceeded(flags []bool) int {
	count := 0
	for _, ok := range flags {
		if ok {
			count++
		}
	}
	return count
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
	merging := len(conn.sources) > 1
	statuses, succeeded := conn.each(func(i int, src source) error {
		result, err := fetchOverviewReports(ctx, conn.svc, src, q, merging)
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
		breakdown, total, err := fetchRealtime(ctx, conn.svc, src)
		if err != nil {
			return err
		}
		mu.Lock()
		defer mu.Unlock()
		for platform, users := range breakdown {
			byPlatform[platform] += users
		}
		resp.ActiveUsers += total
		return nil
	})

	for platform, users := range byPlatform {
		resp.Platforms = append(resp.Platforms, RealtimePlatform{Platform: platform, ActiveUsers: users})
	}
	resp.UsersSummed = countSucceeded(succeeded) > 1
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

func fetchRealtime(ctx context.Context, svc *analyticsdata.Service, src source) (map[string]int64, int64, error) {
	filter := platformFilter(src.platforms)
	report, err := svc.Properties.RunRealtimeReport(propertyName(src.propertyID), &analyticsdata.RunRealtimeReportRequest{
		Dimensions:      []*analyticsdata.Dimension{{Name: "platform"}},
		Metrics:         []*analyticsdata.Metric{{Name: "activeUsers"}},
		DimensionFilter: filter,
	}).Context(ctx).Do()
	if err != nil {
		return nil, 0, err
	}
	byPlatform := map[string]int64{}
	var total int64
	for _, row := range report.Rows {
		users := metric(row, 0)
		byPlatform[normalizePlatform(dimension(row, 0))] += users
		total += users
	}
	if len(byPlatform) <= 1 {
		return byPlatform, total, nil
	}
	totals, err := svc.Properties.RunRealtimeReport(propertyName(src.propertyID), &analyticsdata.RunRealtimeReportRequest{
		Metrics:         []*analyticsdata.Metric{{Name: "activeUsers"}},
		DimensionFilter: filter,
	}).Context(ctx).Do()
	if err != nil {
		return nil, 0, err
	}
	total = 0
	for _, row := range totals.Rows {
		total += metric(row, 0)
	}
	return byPlatform, total, nil
}

func fetchOverviewReports(ctx context.Context, svc *analyticsdata.Service, src source, q OverviewQuery, merging bool) ([]*analyticsdata.RunReportResponse, error) {
	requests := overviewRequests(q, src, merging)
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
	if !merging {
		return out, nil
	}
	for _, i := range []int{reportScreens, reportCountries, reportEvents} {
		if i >= len(out) || out[i] == nil {
			continue
		}
		if err := fetchRemainingRows(ctx, svc, src, requests[i], out[i]); err != nil {
			return nil, err
		}
	}
	return out, nil
}

func fetchRemainingRows(ctx context.Context, svc *analyticsdata.Service, src source, req *analyticsdata.RunReportRequest, report *analyticsdata.RunReportResponse) error {
	for int64(len(report.Rows)) < report.RowCount && len(report.Rows) < mergeRowCap {
		page := *req
		page.Offset = int64(len(report.Rows))
		next, err := svc.Properties.RunReport(propertyName(src.propertyID), &page).Context(ctx).Do()
		if err != nil {
			return err
		}
		if len(next.Rows) == 0 {
			return nil
		}
		report.Rows = append(report.Rows, next.Rows...)
	}
	return nil
}

func overviewRequests(q OverviewQuery, src source, merging bool) []*analyticsdata.RunReportRequest {
	dateRanges := []*analyticsdata.DateRange{{StartDate: q.From, EndDate: q.To}}
	rankLimit := func(limit int64) int64 {
		if merging {
			return mergeRowLimit
		}
		return limit
	}
	build := func(platforms []string, dims []string, metrics []string, orderBy string, limit int64) *analyticsdata.RunReportRequest {
		req := &analyticsdata.RunReportRequest{
			DateRanges:      dateRanges,
			DimensionFilter: platformFilter(platforms),
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
	scope := src.platforms
	requests := []*analyticsdata.RunReportRequest{
		reportTotals:    build(scope, nil, []string{"activeUsers", "newUsers", "sessions", "screenPageViews", engagementMetric}, "", 0),
		reportPlatforms: build(scope, []string{"platform"}, []string{"activeUsers", "newUsers", "sessions", "screenPageViews"}, "", 0),
		reportDaily:     build(scope, []string{"date", "platform"}, []string{"activeUsers", "newUsers", "sessions"}, "", dailyRowLimit),
		reportScreens:   build(scope, []string{"unifiedPagePathScreen"}, []string{"screenPageViews", "activeUsers"}, "screenPageViews", rankLimit(screenLimit)),
		reportCountries: build(scope, []string{"country"}, []string{"activeUsers"}, "activeUsers", rankLimit(countryLimit)),
		reportEvents:    build(scope, []string{"eventName"}, []string{"eventCount", "totalUsers"}, "eventCount", rankLimit(eventLimit)),
	}
	if apps := src.appScope(); len(apps) > 0 {
		requests = append(requests, build(apps, []string{"platform", "appVersion"}, []string{"activeUsers"}, "activeUsers", versionLimit))
	}
	return requests
}

func platformFilter(platforms []string) *analyticsdata.FilterExpression {
	names := make([]string, 0, len(platforms))
	for _, platform := range platforms {
		if name, ok := gaPlatformNames[platform]; ok {
			names = append(names, name)
		}
	}
	if len(names) == 0 {
		return nil
	}
	return &analyticsdata.FilterExpression{
		Filter: &analyticsdata.Filter{
			FieldName:    "platform",
			InListFilter: &analyticsdata.InListFilter{Values: names},
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
	totals     Totals
	sources    int
	platforms  map[string]*PlatformRow
	engagement float64
	days       map[string]*TimePoint
	dayOrder   []string
	screens    *ranking
	countries  *ranking
	events     *ranking
	versions   []VersionRow
}

type ranking struct {
	rows    map[string]*NamedRow
	partial []rankedPart
}

type rankedPart struct {
	seen  map[string]bool
	floor int64
}

func newAggregate(from, to string) *aggregate {
	agg := &aggregate{
		platforms: map[string]*PlatformRow{},
		days:      map[string]*TimePoint{},
		screens:   newRanking(),
		countries: newRanking(),
		events:    newRanking(),
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

func reportResponse(reports []*analyticsdata.RunReportResponse, i int) *analyticsdata.RunReportResponse {
	if i >= len(reports) {
		return nil
	}
	return reports[i]
}

func reportAt(reports []*analyticsdata.RunReportResponse, i int) []*analyticsdata.Row {
	if report := reportResponse(reports, i); report != nil {
		return report.Rows
	}
	return nil
}

func (a *aggregate) add(reports []*analyticsdata.RunReportResponse) {
	a.sources++
	for _, row := range reportAt(reports, reportTotals) {
		a.totals.ActiveUsers += metric(row, 0)
		a.totals.NewUsers += metric(row, 1)
		a.totals.Sessions += metric(row, 2)
		a.totals.Views += metric(row, 3)
		a.engagement += metricFloat(row, 4)
	}
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
	a.screens.add(reportResponse(reports, reportScreens), 1)
	a.countries.add(reportResponse(reports, reportCountries), 0)
	a.events.add(reportResponse(reports, reportEvents), 1)
	for _, row := range reportAt(reports, reportVersions) {
		a.versions = append(a.versions, VersionRow{
			Platform: normalizePlatform(dimension(row, 0)),
			Version:  dimension(row, 1),
			Users:    metric(row, 0),
		})
	}
}

func newRanking() *ranking {
	return &ranking{rows: map[string]*NamedRow{}}
}

func (r *ranking) add(report *analyticsdata.RunReportResponse, usersMetric int) {
	if report == nil {
		return
	}
	part := rankedPart{seen: make(map[string]bool, len(report.Rows)), floor: math.MaxInt64}
	for _, row := range report.Rows {
		count := metric(row, 0)
		name := mergeNamed(r.rows, dimension(row, 0), count, metric(row, usersMetric))
		part.seen[name] = true
		part.floor = min(part.floor, count)
	}
	if int64(len(report.Rows)) < report.RowCount {
		r.partial = append(r.partial, part)
	}
}

func (r *ranking) top(limit int) ([]NamedRow, bool) {
	top := topNamed(r.rows, limit)
	return top, r.exact(top, limit)
}

func (r *ranking) exact(top []NamedRow, limit int) bool {
	if len(r.partial) == 0 {
		return true
	}
	var unseen int64
	for _, part := range r.partial {
		if part.floor == math.MaxInt64 {
			return false
		}
		unseen += part.floor
	}
	inTop := make(map[string]bool, len(top))
	for _, item := range top {
		if r.unknownShare(item.Name) > 0 {
			return false
		}
		inTop[item.Name] = true
	}
	if len(top) < limit {
		return unseen == 0
	}
	cutoff := top[len(top)-1].Count
	if unseen >= cutoff {
		return false
	}
	for name, item := range r.rows {
		if !inTop[name] && item.Count+r.unknownShare(name) >= cutoff {
			return false
		}
	}
	return true
}

func (r *ranking) unknownShare(name string) int64 {
	var bound int64
	for _, part := range r.partial {
		if !part.seen[name] {
			bound += part.floor
		}
	}
	return bound
}

func mergeNamed(rows map[string]*NamedRow, name string, count, users int64) string {
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
	return name
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
	}
	sort.Slice(resp.Platforms, func(i, j int) bool { return resp.Platforms[i].ActiveUsers > resp.Platforms[j].ActiveUsers })
	resp.Totals = a.totals
	resp.Totals.UsersSummed = a.sources > 1
	if resp.Totals.ActiveUsers > 0 {
		resp.Totals.AvgEngagementSeconds = a.engagement / float64(resp.Totals.ActiveUsers)
	}

	resp.Timeseries = make([]TimePoint, 0, len(a.dayOrder))
	for _, key := range a.dayOrder {
		resp.Timeseries = append(resp.Timeseries, *a.days[key])
	}
	resp.ApproximateRankings = []string{}
	resp.Screens = rankInto(resp, RankingScreens, a.screens, screenLimit)
	resp.Countries = rankInto(resp, RankingCountries, a.countries, countryLimit)
	resp.Events = rankInto(resp, RankingEvents, a.events, eventLimit)

	sort.Slice(a.versions, func(i, j int) bool { return a.versions[i].Users > a.versions[j].Users })
	if len(a.versions) > versionLimit {
		a.versions = a.versions[:versionLimit]
	}
	resp.AppVersions = append([]VersionRow{}, a.versions...)
}

func rankInto(resp *OverviewResponse, name string, r *ranking, limit int) []NamedRow {
	top, exact := r.top(limit)
	if !exact {
		resp.ApproximateRankings = append(resp.ApproximateRankings, name)
	}
	return top
}
