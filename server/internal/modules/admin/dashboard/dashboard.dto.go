package admindashboard

import "time"

type OverviewQuery struct {
	From time.Time
	To   time.Time
}

type RangeInfo struct {
	From string `json:"from"`
	To   string `json:"to"`
}

type Totals struct {
	Users            int64 `json:"users"`
	Posts            int64 `json:"posts"`
	Rooms            int64 `json:"rooms"`
	KenInCirculation int64 `json:"kenInCirculation"`
	Kisses           int64 `json:"kisses"`
	ActiveMarriages  int64 `json:"activeMarriages"`
}

type UsersSection struct {
	New      int64 `json:"new"`
	Active   int64 `json:"active"`
	Verified int64 `json:"verified"`
	Male     int64 `json:"male"`
	Female   int64 `json:"female"`
}

type RegistrationsSection struct {
	Today int64 `json:"today"`
	Week  int64 `json:"week"`
}

type SpendByType struct {
	Type   string `json:"type"`
	Amount int64  `json:"amount"`
	Count  int64  `json:"count"`
}

type RevenueSection struct {
	TopupKen      int64         `json:"topupKen"`
	TopupCount    int64         `json:"topupCount"`
	VipRevenueKen int64         `json:"vipRevenueKen"`
	VipPurchases  int64         `json:"vipPurchases"`
	SpendByType   []SpendByType `json:"spendByType"`
}

type EngagementSection struct {
	NewPosts int64 `json:"newPosts"`
	Likes    int64 `json:"likes"`
	Dislikes int64 `json:"dislikes"`
	Comments int64 `json:"comments"`
}

type SocialSection struct {
	NewFollows     int64 `json:"newFollows"`
	FriendRequests int64 `json:"friendRequests"`
	NewFriendships int64 `json:"newFriendships"`
	NewMarriages   int64 `json:"newMarriages"`
}

type GamesSection struct {
	EggDraws   int64 `json:"eggDraws"`
	WheelSpins int64 `json:"wheelSpins"`
	PenShots   int64 `json:"penShots"`
}

type TimePoint struct {
	Date       string `json:"date"`
	NewUsers   int64  `json:"newUsers"`
	TopupKen   int64  `json:"topupKen"`
	RevenueKen int64  `json:"revenueKen"`
	Posts      int64  `json:"posts"`
}

type OverviewResponse struct {
	Range         RangeInfo            `json:"range"`
	Bucket        string               `json:"bucket"`
	Totals        Totals               `json:"totals"`
	Registrations RegistrationsSection `json:"registrations"`
	Users         UsersSection         `json:"users"`
	Revenue       RevenueSection       `json:"revenue"`
	Engagement    EngagementSection    `json:"engagement"`
	Social        SocialSection        `json:"social"`
	Games         GamesSection         `json:"games"`
	Timeseries    []TimePoint          `json:"timeseries"`
}

type OverviewSuccessResponse = struct {
	Success bool             `json:"success"`
	Data    OverviewResponse `json:"data"`
}
