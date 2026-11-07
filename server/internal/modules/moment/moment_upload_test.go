package moment

import (
	"errors"
	"fmt"
	"mime/multipart"
	"sync"
	"testing"
	"time"

	"ola-chat-server/internal/media"
)

func headers(prefix string, count int) []*multipart.FileHeader {
	out := make([]*multipart.FileHeader, count)
	for i := range out {
		out[i] = &multipart.FileHeader{Filename: fmt.Sprintf("%s-%d", prefix, i)}
	}
	return out
}

func TestUploadImageSetRunsInParallelAndKeepsOrder(t *testing.T) {
	images := headers("image", 3)
	thumbs := headers("thumb", 3)
	var started sync.WaitGroup
	started.Add(len(images) + len(thumbs))
	allStarted := make(chan struct{})
	go func() {
		started.Wait()
		close(allStarted)
	}()

	gotImages, gotThumbs, err := uploadImageSet(images, thumbs, func(header *multipart.FileHeader, _ int64) (*uploadedMedia, error) {
		started.Done()
		select {
		case <-allStarted:
		case <-time.After(5 * time.Second):
			return nil, errors.New("uploads did not run in parallel")
		}
		return &uploadedMedia{URL: header.Filename}, nil
	})
	if err != nil {
		t.Fatalf("uploadImageSet: %v", err)
	}
	for i := range images {
		if gotImages[i].URL != images[i].Filename || gotThumbs[i].URL != thumbs[i].Filename {
			t.Fatalf("slot %d: got %s / %s", i, gotImages[i].URL, gotThumbs[i].URL)
		}
	}
}

func TestUploadImageSetAppliesSizeLimits(t *testing.T) {
	images := headers("image", 1)
	thumbs := headers("thumb", 1)
	var mu sync.Mutex
	limits := map[string]int64{}
	_, _, err := uploadImageSet(images, thumbs, func(header *multipart.FileHeader, maxSize int64) (*uploadedMedia, error) {
		mu.Lock()
		defer mu.Unlock()
		limits[header.Filename] = maxSize
		return &uploadedMedia{}, nil
	})
	if err != nil {
		t.Fatalf("uploadImageSet: %v", err)
	}
	if limits["image-0"] != media.MaxImageUploadSize || limits["thumb-0"] != MaxMomentThumbUploadSize {
		t.Fatalf("limits = %v", limits)
	}
}

func TestUploadImageSetWithoutThumbsLeavesThumbSlotsEmpty(t *testing.T) {
	images := headers("image", 2)
	gotImages, gotThumbs, err := uploadImageSet(images, nil, func(header *multipart.FileHeader, _ int64) (*uploadedMedia, error) {
		return &uploadedMedia{URL: header.Filename}, nil
	})
	if err != nil {
		t.Fatalf("uploadImageSet: %v", err)
	}
	if len(gotImages) != 2 || gotThumbs[0] != nil || gotThumbs[1] != nil {
		t.Fatalf("images = %v, thumbs = %v", gotImages, gotThumbs)
	}
}

func TestUploadImageSetFailureStillTracksFinishedUploads(t *testing.T) {
	images := headers("image", 3)
	failure := errors.New("upload failed")
	tracker := &uploadTracker{}
	_, _, err := uploadImageSet(images, nil, func(header *multipart.FileHeader, _ int64) (*uploadedMedia, error) {
		if header.Filename == "image-1" {
			return nil, failure
		}
		time.Sleep(20 * time.Millisecond)
		tracker.add(header.Filename)
		return &uploadedMedia{URL: header.Filename}, nil
	})
	if !errors.Is(err, failure) {
		t.Fatalf("err = %v", err)
	}
	if len(tracker.objects) != 2 {
		t.Fatalf("tracked objects = %v, want both finished uploads", tracker.objects)
	}
}
