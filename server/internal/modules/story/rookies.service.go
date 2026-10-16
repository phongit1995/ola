package story

import (
	"context"
	"fmt"
	"net/url"
	"strconv"
	"strings"
)

// RookiesService lấy nội dung chương từ trang đọc của rookies. Trang này kèm nội dung mọi chương
// của truyện (cả chương VIP), nên chỉ giữ chương miễn phí và lưu luôn để lần đọc sau khỏi tải lại.
type RookiesService struct {
	client *rookiesClient
	slots  chan struct{}
}

func NewRookiesService() *RookiesService {
	return &RookiesService{
		client: newRookiesClient(StoryRookiesFetchTimeout, 0),
		slots:  make(chan struct{}, StoryFetchConcurrency),
	}
}

func (s *RookiesService) ShortStoryContent(ctx context.Context, chapter *ChapterRow) (string, error) {
	return s.ChapterContent(ctx, chapter)
}

func (s *RookiesService) ChapterContent(ctx context.Context, chapter *ChapterRow) (string, error) {
	text, _, err := s.ChapterWithSiblings(ctx, chapter)
	return text, err
}

func (s *RookiesService) ChapterWithSiblings(ctx context.Context, chapter *ChapterRow) (string, map[string]string, error) {
	slug, chapterID, err := rookiesChapterTarget(chapter.SourceURL)
	if err != nil {
		return "", nil, err
	}
	if chapter.SourceChapterID != "" && chapter.SourceChapterID != chapterID {
		return "", nil, fmt.Errorf("%w: chapter %s at %s", errUnsupportedSource, chapter.SourceChapterID, chapter.SourceURL)
	}
	select {
	case s.slots <- struct{}{}:
		defer func() { <-s.slots }()
	case <-ctx.Done():
		return "", nil, ctx.Err()
	}
	reading, err := s.client.Reading(ctx, slug, chapterID)
	if err != nil {
		return "", nil, err
	}
	if strconv.FormatInt(reading.Chapter.ID, 10) != chapterID {
		return "", nil, fmt.Errorf("%w: rookies returned chapter %d for %s", errStoryGone, reading.Chapter.ID, chapterID)
	}
	if reading.Chapter.IsBan > 0 || reading.Chapter.paid() {
		return "", nil, errChapterLocked
	}
	text, err := rookiesChapterBody(reading.Chapter.Content, chapter.Title)
	if err != nil {
		return "", nil, err
	}
	return text, freeSiblings(reading.Chapters, chapterID), nil
}

func freeSiblings(chapters []rookiesChapterText, skip string) map[string]string {
	out := make(map[string]string, len(chapters))
	for _, item := range chapters {
		id := strconv.FormatInt(item.ID, 10)
		if id == skip || item.IsBan > 0 || item.paid() || item.Content == "" {
			continue
		}
		if text, err := rookiesChapterBody(item.Content, string(item.Title)); err == nil {
			out[id] = text
		}
	}
	return out
}

func rookiesChapterBody(content, title string) (string, error) {
	paragraphs, err := rookiesParagraphs(content)
	if err != nil {
		return "", err
	}
	return chapterText(paragraphs, title)
}

func rookiesChapterTarget(raw string) (string, string, error) {
	target, err := url.Parse(raw)
	if err != nil || target.Scheme != "https" || target.Host != StoryRookiesHost {
		return "", "", fmt.Errorf("%w: %s", errUnsupportedSource, raw)
	}
	parts := strings.Split(strings.Trim(target.Path, "/"), "/")
	if len(parts) != 3 || parts[0] != "truyen" || !rookiesSlugPattern.MatchString(parts[1]) {
		return "", "", fmt.Errorf("%w: %s", errUnsupportedSource, raw)
	}
	if _, err := strconv.ParseUint(parts[2], 10, 64); err != nil {
		return "", "", fmt.Errorf("%w: %s", errUnsupportedSource, raw)
	}
	return parts[1], parts[2], nil
}
