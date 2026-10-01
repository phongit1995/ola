package wordchain

import (
	"context"

	"github.com/google/uuid"
)

func (s *Service) AdminOverview(ctx context.Context) (*AdminOverviewResponse, error) {
	state, err := s.store.LoadState(ctx)
	if err != nil {
		return nil, err
	}
	players, err := s.store.Count(ctx, CacheKeyPoints)
	if err != nil {
		return nil, err
	}
	winners, err := s.store.Count(ctx, CacheKeyWins)
	if err != nil {
		return nil, err
	}
	resp := &AdminOverviewResponse{History: []string{}, Players: players, Winners: winners}
	if !state.Active() {
		return resp, nil
	}
	resp.State = toStateView(state)
	resp.History = append(resp.History, state.History...)
	if ownerID, err := uuid.Parse(state.WordOwnerID); err == nil {
		if u := s.sender(ownerID); u != nil {
			resp.WordOwner = &AdminPlayer{ID: ownerID.String(), Username: u.Username, FullName: u.FullName, Avatar: u.Avatar}
		}
	}
	return resp, nil
}

func (s *Service) AdminMessages(ctx context.Context, limit int, before string) (*MessageListResponse, error) {
	return s.messagePage(ctx, limit, before)
}

func (s *Service) AdminWins(ctx context.Context, userID *uuid.UUID, before string, limit int) (*WinListResponse, error) {
	return s.winList(ctx, userID, before, limit)
}
