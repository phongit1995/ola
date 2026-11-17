package sociallimit

type PostQuota struct {
	Used       int  `json:"used"`
	Limit      int  `json:"limit"`
	Upgradable bool `json:"upgradable"`
}

type PostQuotaResponse struct {
	IsVip  bool      `json:"isVip"`
	Me     PostQuota `json:"me"`
	Moment PostQuota `json:"moment"`
}
