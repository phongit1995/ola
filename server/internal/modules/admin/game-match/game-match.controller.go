package admingamematch

import (
	"net/http"
	"strconv"
	"time"

	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
	"go.uber.org/zap"
)

type Controller struct {
	service *Service
	logger  *zap.SugaredLogger
}

func NewController(service *Service, logger *zap.SugaredLogger) *Controller {
	return &Controller{service: service, logger: logger.Named("[admin_game_match_controller]")}
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

func parseUUIDQuery(c *gin.Context, key string) (*uuid.UUID, error) {
	raw := c.Query(key)
	if raw == "" {
		return nil, nil
	}
	id, err := uuid.Parse(raw)
	if err != nil {
		return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid "+key)
	}
	return &id, nil
}

func oneOf(value string, allowed ...string) string {
	for _, a := range allowed {
		if value == a {
			return value
		}
	}
	return ""
}

func parseFilter(c *gin.Context) (AdminMatchFilter, error) {
	var f AdminMatchFilter
	f.GameID = c.Query("gameId")
	f.Status = oneOf(c.Query("status"), "playing", "finished")
	f.Reason = oneOf(c.Query("reason"), "win", "forfeit", "timeout", "draw", "disconnect", "void")
	f.Mode = oneOf(c.Query("mode"), "queue", "room")
	f.MinBet = parseIntQuery(c, "minBet")
	f.MaxBet = parseIntQuery(c, "maxBet")

	userID, err := parseUUIDQuery(c, "userId")
	if err != nil {
		return f, err
	}
	f.UserID = userID

	winnerID, err := parseUUIDQuery(c, "winnerId")
	if err != nil {
		return f, err
	}
	f.WinnerID = winnerID

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

// ListMatches godoc
// @Summary      Danh sách trận PvP mini-game (admin)
// @Tags         admin-game-match
// @Produce      json
// @Security     BearerAuth
// @Param        gameId query string false "Lọc theo game (caro, war-god)"
// @Param        userId query string false "Lọc theo người chơi (một trong hai bên)"
// @Param        winnerId query string false "Lọc theo người thắng"
// @Param        status query string false "playing|finished"
// @Param        reason query string false "win|forfeit|timeout|draw|disconnect|void"
// @Param        mode query string false "queue|room"
// @Param        minBet query int false "Cược tối thiểu"
// @Param        maxBet query int false "Cược tối đa"
// @Param        from query string false "Từ thời gian (RFC3339)"
// @Param        to query string false "Đến thời gian (RFC3339)"
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  MatchListSuccessResponse
// @Router       /admin/game-matches [get]
func (ctrl *Controller) ListMatches(c *gin.Context) (interface{}, error) {
	f, err := parseFilter(c)
	if err != nil {
		return nil, err
	}
	limit := utils.ParseLimit(c, 50, 100)
	offset := utils.ParseOffset(c)
	resp, err := ctrl.service.ListMatches(f, limit, offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// GetStats godoc
// @Summary      Thống kê trận & cược mini-game (admin)
// @Tags         admin-game-match
// @Produce      json
// @Security     BearerAuth
// @Param        gameId query string false "Lọc theo game (caro, war-god)"
// @Param        mode query string false "queue|room"
// @Param        from query string false "Từ thời gian (RFC3339)"
// @Param        to query string false "Đến thời gian (RFC3339)"
// @Success      200  {object}  MatchStatsSuccessResponse
// @Router       /admin/game-matches/stats [get]
func (ctrl *Controller) GetStats(c *gin.Context) (interface{}, error) {
	var f AdminMatchFilter
	f.GameID = c.Query("gameId")
	f.Mode = oneOf(c.Query("mode"), "queue", "room")

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

func parseThreshold(c *gin.Context, key string, def, min int) int {
	value := def
	if n := parseIntQuery(c, key); n != nil && *n >= min {
		value = *n
	}
	return value
}

// GetSuspects godoc
// @Summary      Người chơi & cặp đấu thắng bất thường (admin)
// @Tags         admin-game-match
// @Produce      json
// @Security     BearerAuth
// @Param        gameId query string false "Lọc theo game (caro, war-god)"
// @Param        from query string false "Từ thời gian (RFC3339)"
// @Param        to query string false "Đến thời gian (RFC3339)"
// @Param        minMatches query int false "Số trận tối thiểu để xét user (mặc định 10)"
// @Param        minPairMatches query int false "Số trận tối thiểu để xét cặp (mặc định 5)"
// @Success      200  {object}  SuspectsSuccessResponse
// @Router       /admin/game-matches/suspects [get]
func (ctrl *Controller) GetSuspects(c *gin.Context) (interface{}, error) {
	var f AdminMatchFilter
	f.GameID = c.Query("gameId")

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

	minMatches := parseThreshold(c, "minMatches", 10, 1)
	minPairMatches := parseThreshold(c, "minPairMatches", 5, 1)

	resp, err := ctrl.service.Suspects(f, minMatches, minPairMatches)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}
