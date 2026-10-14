package story

import (
	"context"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"net/url"
	"regexp"
	"slices"
	"strconv"
	"strings"
)

var lockedNotice = regexp.MustCompile(`(?i)bạn cần .{1,40} để đọc (truyện|chương) này!`)

func lockedAtSource(paragraphs []string) bool {
	return slices.ContainsFunc(paragraphs, lockedNotice.MatchString)
}

func chapterText(paragraphs []string, title string) (string, error) {
	if lockedAtSource(paragraphs) {
		return "", errChapterLocked
	}
	paragraphs = dropRepeatedTitle(paragraphs, title)
	if len(paragraphs) == 0 {
		return "", errEmptyContent
	}
	return strings.Join(paragraphs, "\n\n"), nil
}

type VnkingsService struct {
	client *http.Client
	slots  chan struct{}
}

func NewVnkingsService() *VnkingsService {
	return &VnkingsService{
		client: &http.Client{Timeout: StoryFetchTimeout},
		slots:  make(chan struct{}, StoryFetchConcurrency),
	}
}

func (s *VnkingsService) ShortStoryContent(ctx context.Context, chapter *ChapterRow) (string, error) {
	postID, err := strconv.ParseUint(chapter.StorySourceID, 10, 64)
	if err != nil {
		return "", fmt.Errorf("%w: post %q", errUnsupportedSource, chapter.StorySourceID)
	}
	body, err := s.get(ctx, fmt.Sprintf(StoryVnkingsPostURL, postID))
	if err != nil {
		return "", err
	}
	var post struct {
		Content struct {
			Rendered string `json:"rendered"`
		} `json:"content"`
	}
	if err := json.Unmarshal(body, &post); err != nil {
		return "", err
	}
	paragraphs, err := fragmentParagraphs(post.Content.Rendered)
	if err != nil {
		return "", err
	}
	return chapterText(paragraphs, chapter.Title)
}

func (s *VnkingsService) ChapterContent(ctx context.Context, chapter *ChapterRow) (string, error) {
	target, err := url.Parse(chapter.SourceURL)
	if err != nil || target.Scheme != "https" || target.Host != StoryVnkingsHost {
		return "", fmt.Errorf("%w: %s", errUnsupportedSource, chapter.SourceURL)
	}
	page, err := s.get(ctx, target.String())
	if err != nil {
		return "", err
	}
	paragraphs, err := pageParagraphs(page, StoryVnkingsContentID)
	if err != nil {
		return "", err
	}
	return chapterText(paragraphs, chapter.Title)
}

func (s *VnkingsService) get(ctx context.Context, target string) ([]byte, error) {
	select {
	case s.slots <- struct{}{}:
		defer func() { <-s.slots }()
	case <-ctx.Done():
		return nil, ctx.Err()
	}
	req, err := http.NewRequestWithContext(ctx, http.MethodGet, target, nil)
	if err != nil {
		return nil, err
	}
	req.Header.Set("User-Agent", StoryFetchUserAgent)
	resp, err := s.client.Do(req)
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()
	if resp.StatusCode != http.StatusOK {
		return nil, fmt.Errorf("%s: status %d", target, resp.StatusCode)
	}
	body, err := io.ReadAll(io.LimitReader(resp.Body, StoryFetchMaxBytes+1))
	if err != nil {
		return nil, err
	}
	if len(body) > StoryFetchMaxBytes {
		return nil, fmt.Errorf("%s: response too large", target)
	}
	return body, nil
}
