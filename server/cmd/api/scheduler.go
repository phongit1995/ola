package main

import (
	"context"

	"ola-chat-server/internal/modules/kenchest"
	"ola-chat-server/internal/modules/moment"
	"ola-chat-server/internal/modules/story"

	"go.uber.org/dig"
)

type Schedulers struct {
	dig.In

	KenChest        *kenchest.Scheduler
	StoryCrawler    *story.Crawler
	RookiesCrawler  *story.RookiesCrawler
	MomentCleaner   *moment.Cleaner
	MomentProcessor *moment.Processor
}

func (s Schedulers) Start(ctx context.Context) {
	s.KenChest.Start(ctx)
	s.StoryCrawler.Start(ctx)
	s.RookiesCrawler.Start(ctx)
	s.MomentCleaner.Start(ctx)
	s.MomentProcessor.Start(ctx)
}

func (s Schedulers) Wait(ctx context.Context) {
	s.MomentProcessor.Wait(ctx)
}
