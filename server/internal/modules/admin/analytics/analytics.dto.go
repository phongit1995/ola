package adminanalytics

import (
	"time"

	"ola-chat-server/internal/utils"
)

const (
	PlatformAll     = "all"
	PlatformAndroid = "android"
	PlatformIOS     = "ios"
	PlatformWeb     = "web"

	SourceMobile = "mobile"
	SourceWeb    = "web"
)

type OverviewQuery struct {
	From     string
	To       string
	Platform string
	Refresh  bool
}

type RealtimeQuery struct {
	Platform string
	Refresh  bool
}

type Setup struct {
	CredentialConfigured bool   `json:"credentialConfigured"`
	ClientEmail          string `json:"clientEmail"`
	MobilePropertyID     string `json:"mobilePropertyId"`
	WebPropertyID        string `json:"webPropertyId"`
}

type SourceStatus struct {
	Source     string `json:"source"`
	PropertyID string `json:"propertyId"`
	Error      string `json:"error,omitempty"`
}

type Totals struct {
	ActiveUsers          int64   `json:"activeUsers"`
	NewUsers             int64   `json:"newUsers"`
	Sessions             int64   `json:"sessions"`
	Views                int64   `json:"views"`
	AvgEngagementSeconds float64 `json:"avgEngagementSeconds"`
}

type PlatformRow struct {
	Platform    string `json:"platform"`
	ActiveUsers int64  `json:"activeUsers"`
	NewUsers    int64  `json:"newUsers"`
	Sessions    int64  `json:"sessions"`
	Views       int64  `json:"views"`
}

type TimePoint struct {
	Date     string `json:"date"`
	Android  int64  `json:"android"`
	IOS      int64  `json:"ios"`
	Web      int64  `json:"web"`
	NewUsers int64  `json:"newUsers"`
	Sessions int64  `json:"sessions"`
}

type NamedRow struct {
	Name  string `json:"name"`
	Count int64  `json:"count"`
	Users int64  `json:"users"`
}

type VersionRow struct {
	Platform string `json:"platform"`
	Version  string `json:"version"`
	Users    int64  `json:"users"`
}

type OverviewResponse struct {
	Setup       Setup          `json:"setup"`
	Sources     []SourceStatus `json:"sources"`
	From        string         `json:"from"`
	To          string         `json:"to"`
	FetchedAt   *time.Time     `json:"fetchedAt,omitempty"`
	Totals      Totals         `json:"totals"`
	Platforms   []PlatformRow  `json:"platforms"`
	Timeseries  []TimePoint    `json:"timeseries"`
	Screens     []NamedRow     `json:"screens"`
	Countries   []NamedRow     `json:"countries"`
	AppVersions []VersionRow   `json:"appVersions"`
	Events      []NamedRow     `json:"events"`
}

type RealtimePlatform struct {
	Platform    string `json:"platform"`
	ActiveUsers int64  `json:"activeUsers"`
}

type RealtimeResponse struct {
	Sources     []SourceStatus     `json:"sources"`
	ActiveUsers int64              `json:"activeUsers"`
	Platforms   []RealtimePlatform `json:"platforms"`
	FetchedAt   *time.Time         `json:"fetchedAt,omitempty"`
}

type OverviewSuccessResponse = utils.BaseResponse[OverviewResponse]
type RealtimeSuccessResponse = utils.BaseResponse[RealtimeResponse]
