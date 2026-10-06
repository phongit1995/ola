package story

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"html"
	"io"
	"mime"
	"net/http"
	"net/url"
	"regexp"
	"strconv"
	"strings"
	"sync"
	"sync/atomic"
	"time"

	"ola-chat-server/internal/constants"
)

var (
	errSourceBlocked = errors.New("source blocked the crawler")
	errStoryGone     = errors.New("story no longer available at source")
)

var (
	tagPattern        = regexp.MustCompile(`<[^>]+>`)
	likePattern       = regexp.MustCompile(`Lượt thích</span><strong>:\s*([\d.]+)`)
	coverPattern      = regexp.MustCompile(`<img class="lazyload" data-original="([^"]+)"`)
	ogImagePattern    = regexp.MustCompile(`<meta property="og:image" content="([^"]+)"`)
	noncePattern      = regexp.MustCompile(`data-story-id="\d+" data-nonce="([0-9a-f]+)"`)
	chapterPattern    = regexp.MustCompile(`(?s)<a href="([^"]+)">(.*?)</a>\s*<i class="pull-right">(.*?)</i>`)
	chapterIDPattern  = regexp.MustCompile(`-p(\d+)\.html`)
	chapterDateFormat = regexp.MustCompile(`^(\d{1,2})/(\d{1,2})/(\d{4})`)
	nonDigits         = regexp.MustCompile(`[^\d]`)
	authorPattern     = infoPattern("Tác giả")
	statusPattern     = infoPattern("Tình trạng")
	ratingPattern     = infoPattern("Rating")
)

func infoPattern(label string) *regexp.Regexp {
	return regexp.MustCompile(`(?s)<span>` + regexp.QuoteMeta(label) + `</span>\s*:(.*?)</li>`)
}

type renderedText struct {
	Rendered string `json:"rendered"`
}

type SourcePost struct {
	ID          int64        `json:"id"`
	Slug        string       `json:"slug"`
	Link        string       `json:"link"`
	Title       renderedText `json:"title"`
	Content     renderedText `json:"content"`
	Excerpt     renderedText `json:"excerpt"`
	DateGMT     string       `json:"date_gmt"`
	ModifiedGMT string       `json:"modified_gmt"`
	Categories  []int64      `json:"categories"`
	Tags        []int64      `json:"tags"`
	Author      int64        `json:"author"`
}

type PostPage struct {
	Posts      []SourcePost
	Total      int
	TotalPages int
}

type StoryPageInfo struct {
	AuthorName string
	Status     string
	AgeRating  string
	LikeCount  int
	CoverURL   *string
	Nonce      string
	LoggedIn   bool
}

type ChapterLink struct {
	SourceID  string
	URL       string
	Title     string
	DateLabel string
}

type Catalog interface {
	ModifiedPosts(ctx context.Context, since time.Time, page int) (PostPage, error)
	Categories(ctx context.Context) (map[int64]string, error)
	TagNames(ctx context.Context, ids []int64) (map[int64]string, error)
	StoryPage(ctx context.Context, link string) (StoryPageInfo, error)
	ChapterLinks(ctx context.Context, storyID int64, nonce string) ([]ChapterLink, error)
	CheckLogin(ctx context.Context) (bool, error)
	SetUserAgent(userAgent string)
	SetCookie(cookie string)
	Requests() int64
}

type VnkingsCatalog struct {
	client    *http.Client
	homeURL   string
	gap       time.Duration
	retryWait time.Duration
	mu        sync.Mutex
	last      time.Time
	requests  atomic.Int64
	userAgent atomic.Value
	cookie    atomic.Value
}

func NewVnkingsCatalog() *VnkingsCatalog {
	return &VnkingsCatalog{
		client:    &http.Client{Timeout: constants.StoryFetchTimeout},
		homeURL:   constants.StoryVnkingsHomeURL,
		gap:       constants.StoryCrawlGap,
		retryWait: constants.StoryCrawlRetryWait,
	}
}

func (c *VnkingsCatalog) SetUserAgent(userAgent string) {
	c.userAgent.Store(userAgent)
}

func (c *VnkingsCatalog) currentUserAgent() string {
	if value, ok := c.userAgent.Load().(string); ok && value != "" {
		return value
	}
	return constants.StoryFetchUserAgent
}

func (c *VnkingsCatalog) SetCookie(cookie string) {
	c.cookie.Store(strings.TrimSpace(cookie))
}

func (c *VnkingsCatalog) currentCookie() string {
	value, _ := c.cookie.Load().(string)
	return value
}

func (c *VnkingsCatalog) CheckLogin(ctx context.Context) (bool, error) {
	body, _, err := c.do(ctx, http.MethodGet, c.homeURL, nil)
	if err != nil {
		return false, err
	}
	return loggedIn(string(body)), nil
}

func (c *VnkingsCatalog) Requests() int64 {
	return c.requests.Load()
}

func restURL(route string, query url.Values) string {
	return constants.StoryVnkingsRESTURL + route + "&" + query.Encode()
}

func (c *VnkingsCatalog) ModifiedPosts(ctx context.Context, since time.Time, page int) (PostPage, error) {
	query := url.Values{
		"categories":     {constants.StoryVnkingsCategoryIDs},
		"modified_after": {since.UTC().Format("2006-01-02T15:04:05Z")},
		"orderby":        {"modified"},
		"order":          {"asc"},
		"per_page":       {strconv.Itoa(constants.StoryVnkingsPerPage)},
		"page":           {strconv.Itoa(page)},
		"_fields":        {"id,slug,link,title,content,excerpt,date_gmt,modified_gmt,categories,tags,author"},
	}
	var posts []SourcePost
	header, err := c.getJSON(ctx, restURL("/wp/v2/posts", query), &posts)
	if err != nil {
		return PostPage{}, err
	}
	return PostPage{
		Posts:      posts,
		Total:      headerInt(header, "X-WP-Total"),
		TotalPages: headerInt(header, "X-WP-TotalPages"),
	}, nil
}

func (c *VnkingsCatalog) Categories(ctx context.Context) (map[int64]string, error) {
	names := map[int64]string{}
	for page := 1; ; page++ {
		query := url.Values{
			"per_page": {strconv.Itoa(constants.StoryVnkingsPerPage)},
			"page":     {strconv.Itoa(page)},
			"_fields":  {"id,name"},
		}
		var items []struct {
			ID   int64  `json:"id"`
			Name string `json:"name"`
		}
		header, err := c.getJSON(ctx, restURL("/wp/v2/categories", query), &items)
		if err != nil {
			return nil, err
		}
		for _, item := range items {
			names[item.ID] = html.UnescapeString(item.Name)
		}
		if page >= headerInt(header, "X-WP-TotalPages") {
			return names, nil
		}
	}
}

func (c *VnkingsCatalog) TagNames(ctx context.Context, ids []int64) (map[int64]string, error) {
	names := map[int64]string{}
	for start := 0; start < len(ids); start += constants.StoryVnkingsPerPage {
		end := min(start+constants.StoryVnkingsPerPage, len(ids))
		include := make([]string, 0, end-start)
		for _, id := range ids[start:end] {
			include = append(include, strconv.FormatInt(id, 10))
		}
		query := url.Values{
			"include":  {strings.Join(include, ",")},
			"per_page": {strconv.Itoa(constants.StoryVnkingsPerPage)},
			"_fields":  {"id,name"},
		}
		var items []struct {
			ID   int64  `json:"id"`
			Name string `json:"name"`
		}
		if _, err := c.getJSON(ctx, restURL("/wp/v2/tags", query), &items); err != nil {
			return nil, err
		}
		for _, item := range items {
			names[item.ID] = html.UnescapeString(item.Name)
		}
	}
	return names, nil
}

func (c *VnkingsCatalog) StoryPage(ctx context.Context, link string) (StoryPageInfo, error) {
	target, err := url.Parse(link)
	if err != nil || target.Scheme != "https" || target.Host != constants.StoryVnkingsHost {
		return StoryPageInfo{}, fmt.Errorf("%w: %s", errUnsupportedSource, link)
	}
	body, _, err := c.do(ctx, http.MethodGet, target.String(), nil)
	if err != nil {
		return StoryPageInfo{}, err
	}
	return parseStoryPage(string(body)), nil
}

func (c *VnkingsCatalog) ChapterLinks(ctx context.Context, storyID int64, nonce string) ([]ChapterLink, error) {
	var links []ChapterLink
	for page := 1; ; page++ {
		form := url.Values{
			"action":        {constants.StoryVnkingsChaptersAction},
			"story_id":      {strconv.FormatInt(storyID, 10)},
			"page":          {strconv.Itoa(page)},
			"chapter_nonce": {nonce},
		}
		body, header, err := c.do(ctx, http.MethodPost, constants.StoryVnkingsAjaxURL, form)
		if err != nil {
			return nil, err
		}
		if err := requireJSON(header); err != nil {
			return nil, err
		}
		result, err := parseChapterPage(body)
		if err != nil {
			return nil, err
		}
		if !result.Success {
			if page == 1 {
				return nil, nil
			}
			return links, nil
		}
		links = append(links, parseChapterLinks(result.Data.Items)...)
		if page >= max(int(result.Data.TotalPages), 1) {
			return links, nil
		}
	}
}

func (c *VnkingsCatalog) getJSON(ctx context.Context, target string, out interface{}) (http.Header, error) {
	body, header, err := c.do(ctx, http.MethodGet, target, nil)
	if err != nil {
		return nil, err
	}
	if err := requireJSON(header); err != nil {
		return nil, err
	}
	if err := json.Unmarshal(body, out); err != nil {
		return nil, fmt.Errorf("decode %s: %w", target, err)
	}
	return header, nil
}

func requireJSON(header http.Header) error {
	mediaType, _, err := mime.ParseMediaType(header.Get("Content-Type"))
	if err != nil || !strings.HasSuffix(mediaType, "json") {
		return fmt.Errorf("unexpected content type %q", header.Get("Content-Type"))
	}
	return nil
}

func headerInt(header http.Header, name string) int {
	value, err := strconv.Atoi(strings.TrimSpace(header.Get(name)))
	if err != nil {
		return 0
	}
	return value
}

func (c *VnkingsCatalog) wait(ctx context.Context) error {
	c.mu.Lock()
	delay := time.Until(c.last.Add(c.gap))
	if delay < 0 {
		delay = 0
	}
	c.last = time.Now().Add(delay)
	c.mu.Unlock()
	if delay == 0 {
		return nil
	}
	select {
	case <-ctx.Done():
		return ctx.Err()
	case <-time.After(delay):
		return nil
	}
}

func (c *VnkingsCatalog) do(ctx context.Context, method, target string, form url.Values) ([]byte, http.Header, error) {
	var lastErr error
	for attempt := 0; attempt <= constants.StoryCrawlRetries; attempt++ {
		if attempt > 0 {
			select {
			case <-ctx.Done():
				return nil, nil, ctx.Err()
			case <-time.After(time.Duration(attempt) * c.retryWait):
			}
		}
		body, header, retry, err := c.once(ctx, method, target, form)
		if err == nil {
			return body, header, nil
		}
		if !retry || ctx.Err() != nil {
			return nil, nil, err
		}
		lastErr = err
	}
	return nil, nil, lastErr
}

func (c *VnkingsCatalog) once(ctx context.Context, method, target string, form url.Values) ([]byte, http.Header, bool, error) {
	if err := c.wait(ctx); err != nil {
		return nil, nil, false, err
	}
	var payload io.Reader
	if form != nil {
		payload = strings.NewReader(form.Encode())
	}
	req, err := http.NewRequestWithContext(ctx, method, target, payload)
	if err != nil {
		return nil, nil, false, err
	}
	req.Header.Set("User-Agent", c.currentUserAgent())
	if cookie := c.currentCookie(); cookie != "" {
		req.Header.Set("Cookie", cookie)
	}
	if form != nil {
		req.Header.Set("Content-Type", "application/x-www-form-urlencoded")
	}
	c.requests.Add(1)
	resp, err := c.client.Do(req)
	if err != nil {
		return nil, nil, true, err
	}
	defer resp.Body.Close()
	switch {
	case resp.StatusCode == http.StatusForbidden || resp.StatusCode == http.StatusTooManyRequests || resp.StatusCode == http.StatusServiceUnavailable:
		return nil, nil, false, fmt.Errorf("%w: status %d at %s", errSourceBlocked, resp.StatusCode, target)
	case resp.StatusCode == http.StatusNotFound || resp.StatusCode == http.StatusGone:
		return nil, nil, false, fmt.Errorf("%w: status %d at %s", errStoryGone, resp.StatusCode, target)
	case resp.StatusCode >= http.StatusInternalServerError:
		return nil, nil, true, fmt.Errorf("status %d at %s", resp.StatusCode, target)
	case resp.StatusCode != http.StatusOK:
		return nil, nil, false, fmt.Errorf("status %d at %s", resp.StatusCode, target)
	}
	body, err := io.ReadAll(io.LimitReader(resp.Body, constants.StoryFetchMaxBytes+1))
	if err != nil {
		return nil, nil, true, err
	}
	if len(body) > constants.StoryFetchMaxBytes {
		return nil, nil, false, fmt.Errorf("%s: response too large", target)
	}
	return body, resp.Header, false, nil
}

type flexInt int

func (f *flexInt) UnmarshalJSON(data []byte) error {
	var number json.Number
	if err := json.Unmarshal(data, &number); err == nil {
		value, err := number.Int64()
		if err != nil {
			return err
		}
		*f = flexInt(value)
		return nil
	}
	var text string
	if err := json.Unmarshal(data, &text); err != nil {
		return err
	}
	value, err := strconv.Atoi(strings.TrimSpace(text))
	if err != nil {
		*f = 0
		return nil
	}
	*f = flexInt(value)
	return nil
}

type chapterPage struct {
	Success bool `json:"success"`
	Data    struct {
		Items      string  `json:"items"`
		TotalPages flexInt `json:"totalPages"`
	} `json:"data"`
}

func parseChapterPage(body []byte) (chapterPage, error) {
	var page chapterPage
	var probe struct {
		Success bool            `json:"success"`
		Data    json.RawMessage `json:"data"`
	}
	if err := json.Unmarshal(body, &probe); err != nil {
		return page, fmt.Errorf("decode chapter list: %w", err)
	}
	page.Success = probe.Success
	if !probe.Success {
		return page, nil
	}
	if err := json.Unmarshal(probe.Data, &page.Data); err != nil {
		return page, fmt.Errorf("decode chapter list: %w", err)
	}
	return page, nil
}

func plainText(fragment string) string {
	return strings.Join(strings.Fields(html.UnescapeString(tagPattern.ReplaceAllString(fragment, " "))), " ")
}

func infoValue(page string, pattern *regexp.Regexp) string {
	match := pattern.FindStringSubmatch(page)
	if match == nil {
		return ""
	}
	return plainText(match[1])
}

func digitsInt(text string) int {
	value, err := strconv.Atoi(nonDigits.ReplaceAllString(text, ""))
	if err != nil {
		return 0
	}
	return value
}

func storyStatus(text string) string {
	lower := strings.ToLower(text)
	switch {
	case strings.Contains(lower, "chưa"):
		return constants.StoryStatusOngoing
	case strings.Contains(lower, "hoàn thành"), strings.Contains(lower, "full"):
		return constants.StoryStatusCompleted
	default:
		return constants.StoryStatusUnknown
	}
}

func firstMatch(pattern *regexp.Regexp, text string) string {
	match := pattern.FindStringSubmatch(text)
	if match == nil {
		return ""
	}
	return match[1]
}

func parseStoryPage(page string) StoryPageInfo {
	info := StoryPageInfo{
		AuthorName: infoValue(page, authorPattern),
		Status:     storyStatus(infoValue(page, statusPattern)),
		AgeRating:  infoValue(page, ratingPattern),
		LikeCount:  digitsInt(firstMatch(likePattern, page)),
		Nonce:      firstMatch(noncePattern, page),
		LoggedIn:   loggedIn(page),
	}
	cover := firstMatch(coverPattern, page)
	if cover == "" {
		cover = firstMatch(ogImagePattern, page)
	}
	if cover != "" {
		info.CoverURL = &cover
	}
	return info
}

func loggedIn(page string) bool {
	return !strings.Contains(page, constants.StoryVnkingsGuestMarker) || strings.Contains(strings.ToLower(page), constants.StoryVnkingsLogoutMarker)
}

func parseChapterLinks(items string) []ChapterLink {
	matches := chapterPattern.FindAllStringSubmatch(items, -1)
	links := make([]ChapterLink, 0, len(matches))
	for _, match := range matches {
		href := match[1]
		sourceID := firstMatch(chapterIDPattern, href)
		if sourceID == "" {
			sourceID = href
		}
		links = append(links, ChapterLink{
			SourceID:  sourceID,
			URL:       href,
			Title:     plainText(match[2]),
			DateLabel: plainText(match[3]),
		})
	}
	return links
}

func chapterDate(label string) *time.Time {
	match := chapterDateFormat.FindStringSubmatch(strings.TrimSpace(label))
	if match == nil {
		return nil
	}
	day, _ := strconv.Atoi(match[1])
	month, _ := strconv.Atoi(match[2])
	year, _ := strconv.Atoi(match[3])
	zone := time.FixedZone("ICT", constants.StoryVnkingsUTCOffsetSeconds)
	value := time.Date(year, time.Month(month), day, 0, 0, 0, 0, zone).UTC()
	return &value
}

func gmtTime(value string) (time.Time, error) {
	return time.ParseInLocation("2006-01-02T15:04:05", strings.TrimSuffix(value, "Z"), time.UTC)
}
