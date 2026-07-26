package adminpen

import (
	"net/http"
	"strconv"
	"time"

	"ola-chat-server/internal/modules/pen"
	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
	"go.uber.org/zap"
)

type Controller struct {
	service *pen.Service
	repo    *Repository
	logger  *zap.SugaredLogger
}

func NewController(service *pen.Service, repo *Repository, logger *zap.SugaredLogger) *Controller {
	return &Controller{service: service, repo: repo, logger: logger.Named("[admin_pen_controller]")}
}

func parseIntQuery(c *gin.Context, key string) *int {
	s := c.Query(key)
	if s == "" {
		return nil
	}
	n, err := strconv.Atoi(s)
	if err != nil {
		return nil
	}
	return &n
}

func parseTimeQuery(c *gin.Context, key string) (*time.Time, error) {
	raw := c.Query(key)
	if raw == "" {
		return nil, nil
	}
	t, err := time.Parse(time.RFC3339, raw)
	if err != nil {
		return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid "+key+" time")
	}
	return &t, nil
}

// ListShots godoc
// @Summary      Danh sách lượt PEN toàn hệ thống (admin)
// @Tags         admin-pen
// @Produce      json
// @Security     BearerAuth
// @Param        shooterId query string false "Lọc người sút"
// @Param        keeperId query string false "Lọc người chụp"
// @Param        status query string false "open|settled|cancelled"
// @Param        result query string false "saved|goal"
// @Param        minBet query int false "Cược tối thiểu"
// @Param        maxBet query int false "Cược tối đa"
// @Param        from query string false "Từ thời gian (RFC3339)"
// @Param        to query string false "Đến thời gian (RFC3339)"
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  pen.AdminShotListSuccessResponse
// @Router       /admin/pen/shots [get]
func (ctrl *Controller) ListShots(c *gin.Context) (interface{}, error) {
	var f pen.AdminShotFilter
	if raw := c.Query("shooterId"); raw != "" {
		id, err := uuid.Parse(raw)
		if err != nil {
			return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid shooter id")
		}
		f.ShooterID = &id
	}
	if raw := c.Query("keeperId"); raw != "" {
		id, err := uuid.Parse(raw)
		if err != nil {
			return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid keeper id")
		}
		f.KeeperID = &id
	}
	if raw := c.Query("status"); raw == "open" || raw == "settled" || raw == "cancelled" {
		f.Status = raw
	}
	if raw := c.Query("result"); raw == "saved" || raw == "goal" {
		f.Result = raw
	}
	f.MinBet = parseIntQuery(c, "minBet")
	f.MaxBet = parseIntQuery(c, "maxBet")

	from, err := parseTimeQuery(c, "from")
	if err != nil {
		return nil, err
	}
	f.From = from
	to, err := parseTimeQuery(c, "to")
	if err != nil {
		return nil, err
	}
	f.To = to

	limit := utils.ParseLimit(c, 50, 100)
	offset := utils.ParseOffset(c)
	resp, err := ctrl.service.ListAllShots(f, limit, offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// GetStats godoc
// @Summary      Thống kê PEN (admin)
// @Tags         admin-pen
// @Produce      json
// @Security     BearerAuth
// @Param        from query string false "Từ thời gian (RFC3339)"
// @Param        to query string false "Đến thời gian (RFC3339)"
// @Success      200  {object}  pen.PenStatsSuccessResponse
// @Router       /admin/pen/stats [get]
func (ctrl *Controller) GetStats(c *gin.Context) (interface{}, error) {
	var f pen.AdminShotFilter
	from, err := parseTimeQuery(c, "from")
	if err != nil {
		return nil, err
	}
	f.From = from
	to, err := parseTimeQuery(c, "to")
	if err != nil {
		return nil, err
	}
	f.To = to

	resp, err := ctrl.service.Stats(f)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

func parseStatsFilter(c *gin.Context) (StatsFilter, error) {
	var f StatsFilter
	if raw := c.Query("userId"); raw != "" {
		parsed, err := uuid.Parse(raw)
		if err != nil {
			return f, utils.NewHTTPError(http.StatusBadRequest, "invalid user id")
		}
		f.UserID = &parsed
	}
	from, err := parseTimeQuery(c, "from")
	if err != nil {
		return f, err
	}
	f.From = from
	to, err := parseTimeQuery(c, "to")
	if err != nil {
		return f, err
	}
	f.To = to
	return f, nil
}

func userBriefFromRow(row userStatsRow) UserBrief {
	if row.Username == "" {
		return UserBrief{ID: row.UserID.String(), Username: row.UserID.String()[:8]}
	}
	return UserBrief{
		ID:       row.UserID.String(),
		Username: row.Username,
		FullName: row.FullName,
		Avatar:   row.Avatar,
	}
}

// GetUserStats godoc
// @Summary      Thống kê PEN theo từng user, gộp cả vai sút và chụp (admin)
// @Tags         admin-pen
// @Produce      json
// @Security     BearerAuth
// @Param        userId query string false "Lọc theo user"
// @Param        from query string false "Từ thời gian (RFC3339)"
// @Param        to query string false "Đến thời gian (RFC3339)"
// @Param        sortBy query string false "staked|netKen|shots|catches (mặc định staked)"
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  UserStatsSuccessResponse
// @Router       /admin/pen/stats/users [get]
func (ctrl *Controller) GetUserStats(c *gin.Context) (interface{}, error) {
	filter, err := parseStatsFilter(c)
	if err != nil {
		return nil, err
	}
	limit := utils.ParseLimit(c, 20, 100)
	offset := utils.ParseOffset(c)

	rows, total, err := ctrl.repo.UserStats(filter, c.Query("sortBy"), limit, offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}

	items := make([]UserStatsItem, len(rows))
	for i, row := range rows {
		item := UserStatsItem{
			User:           userBriefFromRow(row),
			Shots:          row.Shots,
			ShooterSettled: row.ShooterSettled,
			ShooterWins:    row.ShooterWins,
			Catches:        row.Catches,
			KeeperWins:     row.KeeperWins,
			Cancelled:      row.Cancelled,
			Staked:         row.Staked,
			NetKen:         row.NetKen,
			LastPlayAt:     row.LastPlayAt.UTC().Format(time.RFC3339),
		}
		if row.ShooterSettled > 0 {
			item.ShooterWinRate = float64(row.ShooterWins) / float64(row.ShooterSettled) * 100
		}
		if row.Catches > 0 {
			item.KeeperSaveRate = float64(row.KeeperWins) / float64(row.Catches) * 100
		}
		if row.Shots > 0 {
			item.CancelRate = float64(row.Cancelled) / float64(row.Shots) * 100
		}
		items[i] = item
	}
	return &UserStatsResponse{Total: total, Limit: limit, Offset: offset, Items: items}, nil
}

// GetSideStats godoc
// @Summary      Phân bố hướng sút/chụp trái-phải (admin)
// @Tags         admin-pen
// @Produce      json
// @Security     BearerAuth
// @Param        userId query string false "Lọc theo user"
// @Param        from query string false "Từ thời gian (RFC3339)"
// @Param        to query string false "Đến thời gian (RFC3339)"
// @Success      200  {object}  SideStatsSuccessResponse
// @Router       /admin/pen/stats/sides [get]
func (ctrl *Controller) GetSideStats(c *gin.Context) (interface{}, error) {
	filter, err := parseStatsFilter(c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.repo.SideStats(filter)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return &resp, nil
}
