package adminanalytics

import (
	"context"
	"encoding/json"
	"io"
	"net/http"
	"net/http/httptest"
	"slices"
	"strings"
	"sync"
	"testing"

	analyticsdata "google.golang.org/api/analyticsdata/v1beta"
	"google.golang.org/api/option"

	"ola-chat-server/internal/modules/setting"
)

type fakeGA struct {
	mu       sync.Mutex
	paths    []string
	batch    func(property string, req analyticsdata.BatchRunReportsRequest) analyticsdata.BatchRunReportsResponse
	report   func(property string, req analyticsdata.RunReportRequest) analyticsdata.RunReportResponse
	realtime func(property string, req analyticsdata.RunRealtimeReportRequest) analyticsdata.RunRealtimeReportResponse
}

func (f *fakeGA) serve(t *testing.T) *analyticsdata.Service {
	t.Helper()
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		body, _ := io.ReadAll(r.Body)
		path := strings.TrimPrefix(r.URL.Path, "/v1beta/")
		property, method, _ := strings.Cut(path, ":")
		f.mu.Lock()
		f.paths = append(f.paths, path)
		f.mu.Unlock()
		var out interface{}
		switch method {
		case "batchRunReports":
			var req analyticsdata.BatchRunReportsRequest
			_ = json.Unmarshal(body, &req)
			out = f.batch(property, req)
		case "runReport":
			var req analyticsdata.RunReportRequest
			_ = json.Unmarshal(body, &req)
			out = f.report(property, req)
		case "runRealtimeReport":
			var req analyticsdata.RunRealtimeReportRequest
			_ = json.Unmarshal(body, &req)
			out = f.realtime(property, req)
		default:
			http.NotFound(w, r)
			return
		}
		_ = json.NewEncoder(w).Encode(out)
	}))
	t.Cleanup(server.Close)
	svc, err := analyticsdata.NewService(context.Background(), option.WithEndpoint(server.URL+"/"), option.WithHTTPClient(server.Client()))
	if err != nil {
		t.Fatal(err)
	}
	return svc
}

func row(dims []string, metrics ...string) *analyticsdata.Row {
	r := &analyticsdata.Row{}
	for _, d := range dims {
		r.DimensionValues = append(r.DimensionValues, &analyticsdata.DimensionValue{Value: d})
	}
	for _, m := range metrics {
		r.MetricValues = append(r.MetricValues, &analyticsdata.MetricValue{Value: m})
	}
	return r
}

func filterValues(expr *analyticsdata.FilterExpression) []string {
	if expr == nil || expr.Filter == nil || expr.Filter.InListFilter == nil {
		return nil
	}
	return expr.Filter.InListFilter.Values
}

func TestScopedSourcesMergesSharedPropertyAndScopesPlatforms(t *testing.T) {
	shared := setting.AnalyticsConfig{MobilePropertyID: "111", WebPropertyID: "111"}
	got := scopedSources(shared, PlatformAll)
	if len(got) != 1 || got[0].name != SourceAll || !slices.Equal(got[0].platforms, allPlatforms) {
		t.Fatalf("one shared property must be read once for all platforms, got %+v", got)
	}
	if got := scopedSources(shared, PlatformIOS); len(got) != 1 || !slices.Equal(got[0].platforms, []string{PlatformIOS}) {
		t.Fatalf("ios filter on a shared property, got %+v", got)
	}

	split := setting.AnalyticsConfig{MobilePropertyID: "111", WebPropertyID: "222"}
	got = scopedSources(split, PlatformAll)
	if len(got) != 2 || !slices.Equal(got[0].platforms, appPlatforms) || !slices.Equal(got[1].platforms, []string{PlatformWeb}) {
		t.Fatalf("two properties must each keep their own platforms, got %+v", got)
	}
	if got := scopedSources(split, PlatformWeb); len(got) != 1 || got[0].name != SourceWeb {
		t.Fatalf("web filter must only read the web property, got %+v", got)
	}
	if got := scopedSources(setting.AnalyticsConfig{WebPropertyID: "222"}, PlatformAndroid); len(got) != 0 {
		t.Fatalf("android without a mobile property has no source, got %+v", got)
	}
}

func TestTotalsComeFromTheUnsplitReport(t *testing.T) {
	reports := []*analyticsdata.RunReportResponse{
		reportTotals: {Rows: []*analyticsdata.Row{row(nil, "1", "1", "2", "4", "120")}},
		reportPlatforms: {Rows: []*analyticsdata.Row{
			row([]string{"Android"}, "1", "1", "1", "2"),
			row([]string{"iOS"}, "1", "0", "1", "2"),
		}},
	}
	agg := newAggregate("2026-10-01", "2026-10-01")
	agg.add(reports)
	resp := &OverviewResponse{}
	agg.fill(resp)
	if resp.Totals.ActiveUsers != 1 || resp.Totals.AvgEngagementSeconds != 120 || resp.Totals.UsersSummed {
		t.Fatalf("one person on android and ios is one user with 120s, got %+v", resp.Totals)
	}
	if len(resp.Platforms) != 2 {
		t.Fatalf("the platform breakdown still lists both platforms, got %+v", resp.Platforms)
	}

	agg.add([]*analyticsdata.RunReportResponse{reportTotals: {Rows: []*analyticsdata.Row{row(nil, "1", "0", "1", "1", "60")}}})
	agg.fill(resp)
	if resp.Totals.ActiveUsers != 2 || !resp.Totals.UsersSummed {
		t.Fatalf("totals from two properties are summed and flagged, got %+v", resp.Totals)
	}
}

func TestMergedRankingUsesFullRowsOfEverySource(t *testing.T) {
	ranked := func(names ...string) []*analyticsdata.Row {
		var rows []*analyticsdata.Row
		for _, name := range names {
			count := "100"
			if name == "X" {
				count = "99"
			}
			rows = append(rows, row([]string{name}, count, "1"))
		}
		return rows
	}
	mobile := make([]string, 0, screenLimit+1)
	web := make([]string, 0, screenLimit+1)
	for i := range screenLimit {
		mobile = append(mobile, "m"+string(rune('a'+i)))
		web = append(web, "w"+string(rune('a'+i)))
	}
	mobile = append(mobile, "X")
	web = append(web, "X")

	agg := newAggregate("2026-10-01", "2026-10-01")
	agg.add([]*analyticsdata.RunReportResponse{reportScreens: {Rows: ranked(mobile...)}})
	agg.add([]*analyticsdata.RunReportResponse{reportScreens: {Rows: ranked(web...)}})
	resp := &OverviewResponse{}
	agg.fill(resp)
	if len(resp.Screens) != screenLimit || resp.Screens[0].Name != "X" || resp.Screens[0].Count != 198 {
		t.Fatalf("X has 198 views in total and must lead, got %+v", resp.Screens[:2])
	}
}

func TestFetchOverviewReportsPagesRankedReportsWhenMerging(t *testing.T) {
	const total = 3
	ga := &fakeGA{}
	var batchFilters [][]string
	ga.batch = func(_ string, req analyticsdata.BatchRunReportsRequest) analyticsdata.BatchRunReportsResponse {
		var out analyticsdata.BatchRunReportsResponse
		for _, r := range req.Requests {
			batchFilters = append(batchFilters, filterValues(r.DimensionFilter))
			report := &analyticsdata.RunReportResponse{}
			if len(r.Dimensions) == 1 && r.Dimensions[0].Name == "country" {
				report.RowCount = total
				report.Rows = []*analyticsdata.Row{row([]string{"Vietnam"}, "5")}
			}
			out.Reports = append(out.Reports, report)
		}
		return out
	}
	var offsets []int64
	ga.report = func(_ string, req analyticsdata.RunReportRequest) analyticsdata.RunReportResponse {
		offsets = append(offsets, req.Offset)
		if req.Limit != mergeRowLimit {
			t.Errorf("a merged ranking must ask for full pages, got limit %d", req.Limit)
		}
		names := []string{"Japan", "Korea"}
		return analyticsdata.RunReportResponse{RowCount: total, Rows: []*analyticsdata.Row{row([]string{names[req.Offset-1]}, "1")}}
	}
	svc := ga.serve(t)

	src := source{name: SourceWeb, propertyID: "222", platforms: []string{PlatformWeb}}
	reports, err := fetchOverviewReports(context.Background(), svc, src, OverviewQuery{From: "2026-10-01", To: "2026-10-07"}, true)
	if err != nil {
		t.Fatal(err)
	}
	if got := len(reports[reportCountries].Rows); got != total {
		t.Fatalf("expected all %d country rows, got %d", total, got)
	}
	if !slices.Equal(offsets, []int64{1, 2}) {
		t.Fatalf("expected follow-up pages at offsets 1 and 2, got %v", offsets)
	}
	if len(reports) != reportVersions {
		t.Fatalf("a web-only source has no app version report, got %d reports", len(reports))
	}
	for _, values := range batchFilters {
		if !slices.Equal(values, []string{"web"}) {
			t.Fatalf("every web request must be scoped to the web platform, got %v", values)
		}
	}
}

func TestRealtimeCountsUsersOnceAndSplitsEventsByMinuteAndName(t *testing.T) {
	ga := &fakeGA{}
	ga.realtime = func(_ string, req analyticsdata.RunRealtimeReportRequest) analyticsdata.RunRealtimeReportResponse {
		if !slices.Equal(filterValues(req.DimensionFilter), []string{"Android", "iOS", "web"}) {
			t.Errorf("realtime must be scoped to the source platforms, got %v", filterValues(req.DimensionFilter))
		}
		if len(req.Dimensions) == 0 {
			return analyticsdata.RunRealtimeReportResponse{Rows: []*analyticsdata.Row{row(nil, "1")}}
		}
		var rows []*analyticsdata.Row
		switch req.Dimensions[0].Name {
		case "platform":
			rows = []*analyticsdata.Row{row([]string{"Android"}, "1"), row([]string{"iOS"}, "1")}
		case "minutesAgo":
			rows = []*analyticsdata.Row{row([]string{"00"}, "1"), row([]string{"29"}, "1")}
		case "eventName":
			if len(req.Metrics) != 1 || req.Metrics[0].Name != "eventCount" {
				t.Errorf("realtime rejects eventName with any user metric, got %+v", req.Metrics)
			}
			rows = []*analyticsdata.Row{
				row([]string{"screen_view", "00"}, "3"),
				row([]string{"screen_view", "29"}, "2"),
				row([]string{"session_start", "00"}, "1"),
				row([]string{"session_start", "29"}, "1"),
			}
		case "country":
			rows = []*analyticsdata.Row{row([]string{"Vietnam"}, "1")}
		}
		return analyticsdata.RunRealtimeReportResponse{Rows: rows}
	}
	svc := ga.serve(t)

	src := source{name: SourceAll, propertyID: "111", platforms: allPlatforms}
	reports, err := fetchRealtime(context.Background(), svc, src)
	if err != nil {
		t.Fatal(err)
	}
	agg := newRealtimeAggregate()
	agg.add(reports)
	resp := &RealtimeResponse{}
	agg.fill(resp)
	if resp.ActiveUsers != 1 || resp.EventCount != 7 || len(resp.Platforms) != 2 {
		t.Fatalf("one person on android and ios is one user with 7 events, got %d users %d events %+v", resp.ActiveUsers, resp.EventCount, resp.Platforms)
	}
	if len(resp.Minutes) != realtimeWindow {
		t.Fatalf("every minute of the window must be listed, got %d", len(resp.Minutes))
	}
	if first, last := resp.Minutes[0], resp.Minutes[realtimeWindow-1]; first.MinutesAgo != 29 || first.EventCount != 3 || last.MinutesAgo != 0 || last.EventCount != 4 {
		t.Fatalf("minutes run from 29 minutes ago to now, got first %+v last %+v", first, last)
	}
	if resp.Minutes[1].ActiveUsers != 0 {
		t.Fatalf("a quiet minute stays at zero, got %+v", resp.Minutes[1])
	}
	if len(resp.Events) != 2 || resp.Events[0].Name != "screen_view" || resp.Events[0].Count != 5 {
		t.Fatalf("events are ranked by count, got %+v", resp.Events)
	}

	agg.add(reports)
	agg.fill(resp)
	if resp.Events[0].Count != 10 || resp.Minutes[realtimeWindow-1].EventCount != 8 || resp.Countries[0].Count != 2 {
		t.Fatalf("a second property adds to the same rows, got events %+v minutes %+v countries %+v", resp.Events[0], resp.Minutes[realtimeWindow-1], resp.Countries)
	}
}

func TestRealtimeEventTotalSurvivesCutRows(t *testing.T) {
	ga := &fakeGA{}
	ga.realtime = func(_ string, req analyticsdata.RunRealtimeReportRequest) analyticsdata.RunRealtimeReportResponse {
		if len(req.Dimensions) == 0 || req.Dimensions[0].Name != "eventName" {
			return analyticsdata.RunRealtimeReportResponse{}
		}
		if req.Limit != realtimeRowMax || !slices.Equal(req.MetricAggregations, []string{"TOTAL"}) {
			t.Errorf("events must ask for every row and the full total, got limit %d aggregations %v", req.Limit, req.MetricAggregations)
		}
		return analyticsdata.RunRealtimeReportResponse{
			RowCount: 3,
			Rows:     []*analyticsdata.Row{row([]string{"screen_view", "00"}, "6"), row([]string{"screen_view", "01"}, "3")},
			Totals:   []*analyticsdata.Row{row([]string{"RESERVED_TOTAL", "RESERVED_TOTAL"}, "10")},
		}
	}
	svc := ga.serve(t)

	reports, err := fetchRealtime(context.Background(), svc, source{name: SourceMobile, propertyID: "111", platforms: appPlatforms})
	if err != nil {
		t.Fatal(err)
	}
	agg := newRealtimeAggregate()
	agg.add(reports)
	resp := &RealtimeResponse{}
	agg.fill(resp)
	if resp.EventCount != 10 || !resp.EventsTruncated {
		t.Fatalf("the total comes from GA's own sum and the cut is flagged, got %d truncated=%v", resp.EventCount, resp.EventsTruncated)
	}
	if resp.Events[0].Count != 9 {
		t.Fatalf("the table only has the rows GA returned, got %+v", resp.Events)
	}
}

func cut(rowCount int64, pairs ...string) *analyticsdata.RunReportResponse {
	report := &analyticsdata.RunReportResponse{RowCount: rowCount}
	for _, pair := range pairs {
		name, count, _ := strings.Cut(pair, "=")
		report.Rows = append(report.Rows, row([]string{name}, count, "1"))
	}
	return report
}

func TestCutRankingStaysExactWhenTheTailCannotCatchUp(t *testing.T) {
	r := newRanking()
	r.add(cut(mergeRowCap*2, "a=100", "b=50", "c=2"), 1)
	r.add(cut(mergeRowCap*2, "a=80", "b=40", "c=1"), 1)
	top, exact := r.top(2)
	if !exact || top[0].Name != "a" || top[0].Count != 180 || top[1].Count != 90 {
		t.Fatalf("rows beyond the cap can add at most 3, so the top 2 is exact, got %v %+v", exact, top)
	}
}

func TestCutRankingIsApproximateWhenMissingRowsCouldMatter(t *testing.T) {
	r := newRanking()
	r.add(cut(mergeRowCap*2, "a=100", "b=60", "c=10"), 1)
	r.add(cut(mergeRowCap*2, "a=100", "c=50", "d=10"), 1)
	if _, exact := r.top(2); exact {
		t.Fatal("b may have up to 10 more in the second source, so its total is unknown")
	}

	r = newRanking()
	r.add(cut(mergeRowCap*2, "x=150", "y=120", "z=120"), 1)
	r.add(cut(mergeRowCap*2, "x=150", "y=120", "w=120"), 1)
	if _, exact := r.top(2); exact {
		t.Fatal("an unseen name may reach 240 and tie with y")
	}

	agg := newAggregate("2026-10-01", "2026-10-01")
	agg.add([]*analyticsdata.RunReportResponse{reportScreens: cut(mergeRowCap*2, "a=100", "b=60", "c=10")})
	agg.add([]*analyticsdata.RunReportResponse{reportScreens: cut(mergeRowCap*2, "a=100", "c=50", "d=10")})
	resp := &OverviewResponse{}
	agg.fill(resp)
	if !slices.Equal(resp.ApproximateRankings, []string{RankingScreens}) {
		t.Fatalf("the screens table must be flagged as approximate, got %v", resp.ApproximateRankings)
	}
}
