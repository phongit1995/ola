package story

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"io"
	"net/http"
	"net/url"
	"strconv"
	"strings"
)

var (
	errUnsupportedSource = errors.New("unsupported story source")
	errEmptyContent      = errors.New("chapter content is empty")
)

type ContentSource interface {
	ChapterContent(ctx context.Context, chapter *ChapterRow) (string, error)
}

type VnkingsSource struct {
	client *http.Client
	slots  chan struct{}
}

func NewVnkingsSource() *VnkingsSource {
	return &VnkingsSource{
		client: &http.Client{Timeout: StoryFetchTimeout},
		slots:  make(chan struct{}, StoryFetchConcurrency),
	}
}

func (v *VnkingsSource) ChapterContent(ctx context.Context, chapter *ChapterRow) (string, error) {
	if chapter.StorySource != StorySourceVnkings {
		return "", fmt.Errorf("%w: %s", errUnsupportedSource, chapter.StorySource)
	}
	var paragraphs []string
	var err error
	if chapter.StoryKind == StoryKindShort {
		paragraphs, err = v.postParagraphs(ctx, chapter.StorySourceID)
	} else {
		paragraphs, err = v.chapterParagraphs(ctx, chapter.SourceURL)
	}
	if err != nil {
		return "", err
	}
	paragraphs = dropRepeatedTitle(paragraphs, chapter.Title)
	if len(paragraphs) == 0 {
		return "", errEmptyContent
	}
	return strings.Join(paragraphs, "\n\n"), nil
}

func (v *VnkingsSource) chapterParagraphs(ctx context.Context, rawURL string) ([]string, error) {
	target, err := url.Parse(rawURL)
	if err != nil || target.Scheme != "https" || target.Host != StoryVnkingsHost {
		return nil, fmt.Errorf("%w: %s", errUnsupportedSource, rawURL)
	}
	page, err := v.get(ctx, target.String())
	if err != nil {
		return nil, err
	}
	return pageParagraphs(page, StoryVnkingsContentID)
}

func (v *VnkingsSource) postParagraphs(ctx context.Context, rawPostID string) ([]string, error) {
	postID, err := strconv.ParseUint(rawPostID, 10, 64)
	if err != nil {
		return nil, fmt.Errorf("%w: post %q", errUnsupportedSource, rawPostID)
	}
	body, err := v.get(ctx, fmt.Sprintf(StoryVnkingsPostURL, postID))
	if err != nil {
		return nil, err
	}
	var post struct {
		Content struct {
			Rendered string `json:"rendered"`
		} `json:"content"`
	}
	if err := json.Unmarshal(body, &post); err != nil {
		return nil, err
	}
	return fragmentParagraphs(post.Content.Rendered)
}

func (v *VnkingsSource) get(ctx context.Context, target string) ([]byte, error) {
	select {
	case v.slots <- struct{}{}:
		defer func() { <-v.slots }()
	case <-ctx.Done():
		return nil, ctx.Err()
	}
	req, err := http.NewRequestWithContext(ctx, http.MethodGet, target, nil)
	if err != nil {
		return nil, err
	}
	req.Header.Set("User-Agent", StoryFetchUserAgent)
	resp, err := v.client.Do(req)
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
