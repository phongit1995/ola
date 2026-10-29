package adminanalytics

import (
	"context"
	"crypto/sha256"
	"encoding/hex"
	"errors"
	"net/http"
	"strings"
	"sync"

	analyticsdata "google.golang.org/api/analyticsdata/v1beta"
	"google.golang.org/api/googleapi"
	"google.golang.org/api/option"
)

type gaClient struct {
	mu      sync.Mutex
	credKey string
	svc     *analyticsdata.Service
}

func (c *gaClient) service(creds []byte) (*analyticsdata.Service, error) {
	sum := sha256.Sum256(creds)
	key := hex.EncodeToString(sum[:])
	c.mu.Lock()
	defer c.mu.Unlock()
	if c.svc != nil && c.credKey == key {
		return c.svc, nil
	}
	svc, err := analyticsdata.NewService(
		context.Background(),
		option.WithAuthCredentialsJSON(option.ServiceAccount, creds),
		option.WithScopes(analyticsdata.AnalyticsReadonlyScope),
	)
	if err != nil {
		return nil, err
	}
	c.svc = svc
	c.credKey = key
	return svc, nil
}

func propertyName(id string) string {
	return "properties/" + id
}

func friendlyError(err error) string {
	if errors.Is(err, context.DeadlineExceeded) {
		return "Google Analytics phản hồi quá lâu, thử lại sau"
	}
	var gerr *googleapi.Error
	if !errors.As(err, &gerr) {
		return "Không kết nối được Google Analytics: " + err.Error()
	}
	switch gerr.Code {
	case http.StatusForbidden:
		if strings.Contains(gerr.Message, "has not been used") || strings.Contains(gerr.Message, "is disabled") {
			return "Chưa bật Google Analytics Data API trong Google Cloud của tài khoản dịch vụ"
		}
		return "Tài khoản dịch vụ chưa được cấp quyền Viewer trên property này"
	case http.StatusNotFound, http.StatusBadRequest:
		return "Không tìm thấy property, kiểm tra lại Property ID: " + gerr.Message
	case http.StatusTooManyRequests:
		return "Đã vượt giới hạn lượt gọi Google Analytics, thử lại sau"
	case http.StatusUnauthorized:
		return "Tài khoản dịch vụ không xác thực được với Google: " + gerr.Message
	}
	return "Google Analytics báo lỗi: " + gerr.Message
}
