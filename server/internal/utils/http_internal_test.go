package utils

import (
	"context"
	"database/sql/driver"
	"errors"
	"fmt"
	"net"
	"net/http"
	"testing"

	"github.com/gocql/gocql"
	"github.com/jackc/pgx/v5/pgconn"
	"github.com/redis/go-redis/v9"
	"gorm.io/gorm"
)

func TestHTTPStatusFromErrorInfrastructure(t *testing.T) {
	cases := map[string]struct {
		err  error
		want int
	}{
		"pg error":           {&pgconn.PgError{Code: "22021"}, http.StatusInternalServerError},
		"deadline":           {fmt.Errorf("query: %w", context.DeadlineExceeded), http.StatusInternalServerError},
		"bad conn":           {driver.ErrBadConn, http.StatusInternalServerError},
		"net op error":       {&net.OpError{Op: "dial", Err: errors.New("refused")}, http.StatusInternalServerError},
		"redis pool":         {redis.ErrPoolTimeout, http.StatusInternalServerError},
		"scylla no hosts":    {gocql.ErrNoConnections, http.StatusInternalServerError},
		"scylla timeout":     {gocql.ErrTimeoutNoResponse, http.StatusInternalServerError},
		"record not found":   {gorm.ErrRecordNotFound, http.StatusNotFound},
		"client canceled":    {context.Canceled, http.StatusBadRequest},
		"validation":         {errors.New("amount must be positive"), http.StatusBadRequest},
		"known unauthorized": {errors.New("invalid username or password"), http.StatusUnauthorized},
	}
	for name, tc := range cases {
		if got := HTTPStatusFromError(tc.err); got != tc.want {
			t.Errorf("%s: status = %d, want %d", name, got, tc.want)
		}
	}
	var httpErr *HTTPError
	if err := ServiceError(driver.ErrBadConn); !errors.As(err, &httpErr) || httpErr.Message != "internal server error" {
		t.Errorf("ServiceError leaked infrastructure error: %v", err)
	}
}
