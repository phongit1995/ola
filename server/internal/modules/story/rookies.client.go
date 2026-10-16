package story

import (
	"bytes"
	"context"
	"crypto/sha256"
	"encoding/hex"
	"encoding/json"
	"errors"
	"fmt"
	"html"
	"io"
	"net/http"
	"regexp"
	"slices"
	"strconv"
	"strings"
	"sync"
	"sync/atomic"
	"time"
)

var (
	rookiesPagePattern = regexp.MustCompile(`data-page="([^"]+)"`)
	rookiesSlugPattern = regexp.MustCompile(`^[a-z0-9][a-z0-9-]*$`)
	rookiesShortForms  = []string{"Truyện ngắn", "Oneshot"}
)

var (
	errInertiaVersion   = errors.New("rookies inertia version changed")
	errRookiesNoVersion = errors.New("rookies page has no inertia version")
)

// rookiesNumber đọc số mà rookies trả lúc là số, lúc là chuỗi, bool hoặc null.
type rookiesNumber float64

func (n *rookiesNumber) UnmarshalJSON(data []byte) error {
	text := strings.Trim(strings.TrimSpace(string(data)), `"`)
	switch text {
	case "", "null", "false":
		*n = 0
		return nil
	case "true":
		*n = 1
		return nil
	}
	value, err := strconv.ParseFloat(text, 64)
	if err != nil {
		return err
	}
	*n = rookiesNumber(value)
	return nil
}

// rookiesText đọc chuỗi mà rookies trả lúc là chuỗi, lúc là mảng chuỗi (title của chapter_detail) hoặc null.
type rookiesText string

func (t *rookiesText) UnmarshalJSON(data []byte) error {
	var text string
	if err := json.Unmarshal(data, &text); err == nil {
		*t = rookiesText(text)
		return nil
	}
	var parts []string
	if err := json.Unmarshal(data, &parts); err != nil {
		return err
	}
	*t = rookiesText(strings.Join(parts, " "))
	return nil
}

// rookiesTime đọc giờ của rookies: chuỗi không múi giờ là giờ Việt Nam, chuỗi có Z là UTC.
func rookiesTime(value string) (time.Time, bool) {
	value = strings.TrimSpace(value)
	if value == "" {
		return time.Time{}, false
	}
	if moment, err := time.Parse(time.RFC3339Nano, value); err == nil {
		return moment.UTC(), true
	}
	if moment, err := time.ParseInLocation(time.DateTime, value, sourceZone); err == nil {
		return moment.UTC(), true
	}
	return time.Time{}, false
}

type rookiesFilter struct {
	GroupID int    `json:"group_id"`
	Title   string `json:"title"`
}

// Chỉ khai báo trường cần dùng: object user của rookies có cả email, sđt, token nên không bao giờ decode hết.
type rookiesNovel struct {
	ID           int64           `json:"id"`
	Slug         string          `json:"friendly_link"`
	Title        string          `json:"title"`
	Picture      string          `json:"picture"`
	Content      string          `json:"content"`
	Short        string          `json:"short"`
	Filters      []rookiesFilter `json:"novels_filter"`
	ChapterCount rookiesNumber   `json:"novels_chapters_count"`
	PublishedAt  string          `json:"published_at"`
	ChapterAt    string          `json:"chapter_at"`
	CreatedAt    string          `json:"created_at"`
	IsComplete   rookiesNumber   `json:"is_complete"`
	IsMature     rookiesNumber   `json:"is_mature"`
	IsBan        rookiesNumber   `json:"is_ban"`
	IsShow       *rookiesNumber  `json:"is_show"`
	UserID       int64           `json:"user_id"`
	LikeCount    rookiesNumber   `json:"novels_like_count"`
}

func (n rookiesNovel) sourceID() string {
	return strconv.FormatInt(n.ID, 10)
}

func (n rookiesNovel) labels(groups ...int) []string {
	var out []string
	for _, item := range n.Filters {
		if title := strings.TrimSpace(item.Title); title != "" && slices.Contains(groups, item.GroupID) {
			out = append(out, title)
		}
	}
	return out
}

func (n rookiesNovel) otherLabels(groups ...int) []string {
	var out []string
	for _, item := range n.Filters {
		if title := strings.TrimSpace(item.Title); title != "" && !slices.Contains(groups, item.GroupID) {
			out = append(out, title)
		}
	}
	return out
}

func (n rookiesNovel) translated() bool {
	return slices.Contains(n.labels(StoryRookiesGroupKind), StoryRookiesTranslatedLabel)
}

func (n rookiesNovel) hidden() bool {
	return n.IsBan > 0 || (n.IsShow != nil && *n.IsShow == 0)
}

func (n rookiesNovel) skipped() bool {
	return n.hidden() || n.translated() || !rookiesSlugPattern.MatchString(n.Slug)
}

// fingerprint gồm các trường ảnh hưởng tới bản lưu, bỏ lượt xem, lượt thích và updated_at
// vì các trường này đổi liên tục dù truyện không có gì mới.
func (n rookiesNovel) fingerprint() string {
	parts := []string{
		n.Slug, n.Title, n.Picture, n.Content, n.Short, n.PublishedAt, n.ChapterAt,
		strconv.FormatFloat(float64(n.ChapterCount), 'f', -1, 64),
		strconv.FormatFloat(float64(n.IsComplete), 'f', -1, 64),
		strconv.FormatFloat(float64(n.IsMature), 'f', -1, 64),
		strconv.FormatInt(n.UserID, 10),
	}
	for _, item := range n.Filters {
		parts = append(parts, strconv.Itoa(item.GroupID)+":"+item.Title)
	}
	sum := sha256.Sum256([]byte(strings.Join(parts, "\x1f")))
	return hex.EncodeToString(sum[:16])
}

type rookiesAuthor struct {
	Username string `json:"username"`
	FullName string `json:"full_name"`
}

type rookiesChapter struct {
	ID          int64         `json:"id"`
	Title       rookiesText   `json:"title"`
	ShowOrder   rookiesNumber `json:"show_order"`
	PublishedAt string        `json:"published_at"`
	IsBan       rookiesNumber `json:"is_ban"`
	IsVip       rookiesNumber `json:"is_vip"`
	IsPreview   rookiesNumber `json:"is_preview"`
	PriceCoin1  rookiesNumber `json:"price_coin_1"`
	PriceCoin2  rookiesNumber `json:"price_coin_2"`
}

func (c rookiesChapter) paid() bool {
	return c.IsVip > 0 || c.IsPreview > 0 || c.PriceCoin1 > 0 || c.PriceCoin2 > 0
}

type rookiesStory struct {
	rookiesNovel
	Author   rookiesAuthor    `json:"user"`
	Chapters []rookiesChapter `json:"novels_chapters_detail"`
	LoggedIn bool             `json:"-"`
}

// Chỉ cần biết có đăng nhập hay không nên giữ nguyên dạng thô, không decode thông tin tài khoản.
type rookiesAuth struct {
	User json.RawMessage `json:"user"`
}

func (a rookiesAuth) loggedIn() bool {
	user := bytes.TrimSpace(a.User)
	return len(user) > 0 && !bytes.Equal(user, []byte("null"))
}

type rookiesChapterText struct {
	rookiesChapter
	Content string `json:"content"`
}

type rookiesReading struct {
	Chapter  rookiesChapterText
	Chapters []rookiesChapterText
}

type rookiesListing struct {
	Items   []rookiesNovel
	PerPage int
}

type rookiesRequest struct {
	path      string
	inertia   string
	component string
	data      string
	limit     int
}

type rookiesClient struct {
	client    *http.Client
	site      string
	gap       time.Duration
	retryWait time.Duration
	mu        sync.Mutex
	last      time.Time
	versionMu sync.Mutex
	version   string
	requests  atomic.Int64
	userAgent atomic.Value
	cookie    atomic.Value
}

func newRookiesClient(timeout, gap time.Duration) *rookiesClient {
	return &rookiesClient{
		client:    &http.Client{Timeout: timeout},
		site:      StoryRookiesSite,
		gap:       gap,
		retryWait: StoryCrawlRetryWait,
	}
}

func (c *rookiesClient) SetUserAgent(userAgent string) {
	c.userAgent.Store(userAgent)
}

func (c *rookiesClient) currentUserAgent() string {
	if value, ok := c.userAgent.Load().(string); ok && value != "" {
		return value
	}
	return StoryFetchUserAgent
}

func (c *rookiesClient) SetCookie(cookie string) {
	c.cookie.Store(strings.TrimSpace(cookie))
}

func (c *rookiesClient) currentCookie() string {
	value, _ := c.cookie.Load().(string)
	return value
}

func (c *rookiesClient) Requests() int64 {
	return c.requests.Load()
}

func (c *rookiesClient) CheckLogin(ctx context.Context) (bool, error) {
	var page struct {
		Props struct {
			Auth rookiesAuth `json:"auth"`
		} `json:"props"`
	}
	if err := c.page(ctx, "/", StoryRookiesHomeComponent, StoryRookiesAuthData, StoryRookiesPageMaxBytes, &page); err != nil {
		return false, err
	}
	return page.Props.Auth.loggedIn(), nil
}

func (c *rookiesClient) Latest(ctx context.Context) (rookiesListing, error) {
	var page struct {
		Props struct {
			Novels struct {
				List struct {
					Data    []rookiesNovel `json:"data"`
					PerPage rookiesNumber  `json:"per_page"`
				} `json:"list_novels"`
			} `json:"novels"`
		} `json:"props"`
	}
	if err := c.page(ctx, StoryRookiesLatestPath, StoryRookiesListComponent, StoryRookiesPartialData, StoryRookiesPageMaxBytes, &page); err != nil {
		return rookiesListing{}, err
	}
	list := page.Props.Novels.List
	return rookiesListing{Items: list.Data, PerPage: int(list.PerPage)}, nil
}

func (c *rookiesClient) Story(ctx context.Context, slug string) (rookiesStory, error) {
	if !rookiesSlugPattern.MatchString(slug) {
		return rookiesStory{}, fmt.Errorf("%w: slug %q", errUnsupportedSource, slug)
	}
	var page struct {
		Props struct {
			Novels struct {
				Detail *rookiesStory `json:"novels_detail"`
			} `json:"novels"`
			Auth rookiesAuth `json:"auth"`
		} `json:"props"`
	}
	data := StoryRookiesPartialData + "," + StoryRookiesAuthData
	if err := c.page(ctx, "/truyen/"+slug, StoryRookiesStoryComponent, data, StoryRookiesPageMaxBytes, &page); err != nil {
		return rookiesStory{}, err
	}
	if page.Props.Novels.Detail == nil || page.Props.Novels.Detail.ID == 0 {
		return rookiesStory{}, fmt.Errorf("%w: %s", errStoryGone, slug)
	}
	story := *page.Props.Novels.Detail
	story.LoggedIn = page.Props.Auth.loggedIn()
	return story, nil
}

// Trang đọc kèm nội dung của mọi chương trong truyện, gồm cả chương VIP, nên người gọi phải tự lọc chương trả phí.
func (c *rookiesClient) Reading(ctx context.Context, slug, chapterID string) (rookiesReading, error) {
	var page struct {
		Props struct {
			Novels struct {
				Chapter *rookiesChapterText `json:"chapter_detail"`
				Detail  struct {
					Chapters []rookiesChapterText `json:"novels_chapters_detail"`
				} `json:"novels_detail"`
			} `json:"novels"`
		} `json:"props"`
	}
	path := "/truyen/" + slug + "/" + chapterID
	if err := c.page(ctx, path, StoryRookiesReadingComponent, StoryRookiesPartialData, StoryRookiesContentMaxBytes, &page); err != nil {
		return rookiesReading{}, err
	}
	if page.Props.Novels.Chapter == nil || page.Props.Novels.Chapter.ID == 0 {
		return rookiesReading{}, fmt.Errorf("%w: %s", errStoryGone, path)
	}
	return rookiesReading{Chapter: *page.Props.Novels.Chapter, Chapters: page.Props.Novels.Detail.Chapters}, nil
}

// Rookies trả 409 khi version Inertia cũ (vừa deploy), lúc đó đọc lại version và thử lại một lần.
func (c *rookiesClient) page(ctx context.Context, path, component, data string, limit int, out any) error {
	for attempt := 0; ; attempt++ {
		version, err := c.inertiaVersion(ctx)
		if err != nil {
			return err
		}
		body, err := c.do(ctx, rookiesRequest{path: path, inertia: version, component: component, data: data, limit: limit})
		if errors.Is(err, errInertiaVersion) && attempt == 0 {
			c.forgetVersion(version)
			continue
		}
		if err != nil {
			return err
		}
		if err := json.Unmarshal(body, out); err != nil {
			return fmt.Errorf("decode %s: %w", path, err)
		}
		return nil
	}
}

func (c *rookiesClient) inertiaVersion(ctx context.Context) (string, error) {
	c.versionMu.Lock()
	version := c.version
	c.versionMu.Unlock()
	if version != "" {
		return version, nil
	}
	body, err := c.do(ctx, rookiesRequest{path: "/", limit: StoryRookiesPageMaxBytes})
	if err != nil {
		return "", err
	}
	version, err = pageVersion(body)
	if err != nil {
		return "", err
	}
	c.versionMu.Lock()
	c.version = version
	c.versionMu.Unlock()
	return version, nil
}

func (c *rookiesClient) forgetVersion(stale string) {
	c.versionMu.Lock()
	defer c.versionMu.Unlock()
	if c.version == stale {
		c.version = ""
	}
}

func pageVersion(page []byte) (string, error) {
	match := rookiesPagePattern.FindSubmatch(page)
	if match == nil {
		return "", errRookiesNoVersion
	}
	var data struct {
		Version string `json:"version"`
	}
	if err := json.Unmarshal([]byte(html.UnescapeString(string(match[1]))), &data); err != nil || data.Version == "" {
		return "", errRookiesNoVersion
	}
	return data.Version, nil
}

func (c *rookiesClient) do(ctx context.Context, request rookiesRequest) ([]byte, error) {
	var lastErr error
	for attempt := 0; attempt <= StoryCrawlRetries; attempt++ {
		body, wait, retry, err := c.once(ctx, request)
		if err == nil {
			return body, nil
		}
		if !retry || ctx.Err() != nil {
			return nil, err
		}
		lastErr = err
		if attempt == StoryCrawlRetries {
			break
		}
		if wait == 0 {
			wait = time.Duration(attempt+1) * c.retryWait
		}
		select {
		case <-ctx.Done():
			return nil, ctx.Err()
		case <-time.After(wait):
		}
	}
	return nil, lastErr
}

func (c *rookiesClient) once(ctx context.Context, request rookiesRequest) ([]byte, time.Duration, bool, error) {
	if err := c.wait(ctx); err != nil {
		return nil, 0, false, err
	}
	target := c.site + request.path
	req, err := http.NewRequestWithContext(ctx, http.MethodGet, target, nil)
	if err != nil {
		return nil, 0, false, err
	}
	req.Header.Set("User-Agent", c.currentUserAgent())
	if cookie := c.currentCookie(); cookie != "" {
		req.Header.Set("Cookie", cookie)
	}
	if request.inertia != "" {
		req.Header.Set("X-Inertia", "true")
		req.Header.Set("X-Inertia-Version", request.inertia)
		req.Header.Set("X-Requested-With", "XMLHttpRequest")
		if request.component != "" {
			req.Header.Set("X-Inertia-Partial-Component", request.component)
			req.Header.Set("X-Inertia-Partial-Data", request.data)
		}
	}
	c.requests.Add(1)
	resp, err := c.client.Do(req)
	if err != nil {
		return nil, 0, true, err
	}
	defer resp.Body.Close()
	switch {
	case resp.StatusCode == http.StatusConflict && request.inertia != "":
		return nil, 0, false, errInertiaVersion
	case resp.StatusCode == http.StatusTooManyRequests:
		wait := retryAfter(resp.Header)
		return nil, wait, wait > 0 && wait <= StoryRookiesMaxRetryAfter, fmt.Errorf("%w: status %d at %s", errSourceBlocked, resp.StatusCode, request.path)
	case resp.StatusCode == http.StatusForbidden || resp.StatusCode == http.StatusServiceUnavailable:
		return nil, 0, false, fmt.Errorf("%w: status %d at %s", errSourceBlocked, resp.StatusCode, request.path)
	case resp.StatusCode == http.StatusNotFound || resp.StatusCode == http.StatusGone:
		return nil, 0, false, fmt.Errorf("%w: status %d at %s", errStoryGone, resp.StatusCode, request.path)
	case resp.StatusCode >= http.StatusInternalServerError:
		return nil, 0, true, fmt.Errorf("status %d at %s", resp.StatusCode, request.path)
	case resp.StatusCode != http.StatusOK:
		return nil, 0, false, fmt.Errorf("status %d at %s", resp.StatusCode, request.path)
	}
	body, err := io.ReadAll(io.LimitReader(resp.Body, int64(request.limit)+1))
	if err != nil {
		return nil, 0, true, err
	}
	if len(body) > request.limit {
		return nil, 0, false, fmt.Errorf("%s: response too large", request.path)
	}
	return body, 0, false, nil
}

func retryAfter(header http.Header) time.Duration {
	seconds, err := strconv.Atoi(strings.TrimSpace(header.Get("Retry-After")))
	if err != nil || seconds <= 0 {
		return 0
	}
	return time.Duration(seconds) * time.Second
}

func (c *rookiesClient) wait(ctx context.Context) error {
	if c.gap <= 0 {
		return nil
	}
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

// rookiesParagraphs tách đoạn từ HTML của rookies (có lúc bị escape thành &lt;p&gt;) hoặc chữ thường xuống dòng.
func rookiesParagraphs(text string) ([]string, error) {
	if !strings.Contains(text, "<") && strings.Contains(text, "&lt;") {
		text = html.UnescapeString(text)
	}
	if strings.Contains(text, "<") {
		return fragmentParagraphs(text)
	}
	var out []string
	for _, line := range strings.Split(html.UnescapeString(text), "\n") {
		if line = strings.Join(strings.Fields(line), " "); line != "" {
			out = append(out, line)
		}
	}
	return out, nil
}
