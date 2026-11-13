package media

import (
	"errors"
	"fmt"
	"io"
)

var (
	ErrFileTooLarge     = errors.New("file too large")
	ErrUploadRateLimit  = errors.New("upload rate limit exceeded")
	ErrUploadInProgress = errors.New("message upload already in progress")
)

func ReadAllLimited(r io.Reader, maxSize int64) ([]byte, error) {
	data, err := io.ReadAll(io.LimitReader(r, maxSize+1))
	if err != nil {
		return nil, fmt.Errorf("failed to read file: %w", err)
	}
	if int64(len(data)) > maxSize {
		return nil, ErrFileTooLarge
	}
	return data, nil
}
