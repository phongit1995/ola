package moment

import (
	"encoding/json"
	"mime/multipart"
	"net/http"

	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

type Controller struct {
	service *Service
	logger  *zap.SugaredLogger
}

func NewController(service *Service, logger *zap.SugaredLogger) *Controller {
	return &Controller{service: service, logger: logger.Named("[moment_controller]")}
}

func firstValue(values []string) string {
	if len(values) == 0 {
		return ""
	}
	return values[0]
}

func firstFile(files []*multipart.FileHeader) *multipart.FileHeader {
	if len(files) == 0 {
		return nil
	}
	return files[0]
}

// Create godoc
// @Summary      Post moments (24h): up to 3 slides (color or image background), or 1 video ≤20s
// @Description  multipart: type (text|image|video), visibility (friend|public), items = JSON [{type?, background?, overlays}] where type (text|image) defaults to the post type, images[] + thumbs[] in the order of image items, video + thumb (video)
// @Tags         moment
// @Accept       multipart/form-data
// @Produce      json
// @Security     BearerAuth
// @Param        type       formData string true  "text, image or video"
// @Param        visibility formData string false "friend (default) or public"
// @Param        items      formData string true  "JSON array of {type, background, overlays}"
// @Param        images     formData file   false "Image files (≤3MB each, max 3)"
// @Param        thumbs     formData file   false "Small JPEG previews, same order as images"
// @Param        video      formData file   false "Video ≤20s, ≤45MB. Without FFMPEG_PATH only MP4 H.264 is accepted; with it MOV/WebM/MKV/AVI/WMV/FLV/3GP/TS/MPG/OGV are converted to MP4 in the background (status=processing)"
// @Param        thumb      formData file   false "Video cover JPEG (≤300KB)"
// @Success      200  {object}  utils.BaseResponse[CreateMomentsResponse]
// @Router       /moments [post]
func (ctrl *Controller) Create(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	form, err := c.MultipartForm()
	if err != nil {
		return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid multipart form")
	}
	var items []CreateMomentItem
	if err := json.Unmarshal([]byte(firstValue(form.Value["items"])), &items); err != nil {
		return nil, errInvalidItems
	}
	resp, err := ctrl.service.Create(c.Request.Context(), userID, &CreateMomentInput{
		Type:       firstValue(form.Value["type"]),
		Visibility: firstValue(form.Value["visibility"]),
		Items:      items,
		Images:     form.File["images"],
		Thumbs:     form.File["thumbs"],
		Video:      firstFile(form.File["video"]),
		Thumb:      firstFile(form.File["thumb"]),
	})
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Tray godoc
// @Summary      Moment tray: my active moments (first page only) + unseen moments grouped by author, newest author first
// @Tags         moment
// @Produce      json
// @Security     BearerAuth
// @Param        cursor query string false "nextCursor from the previous page"
// @Success      200  {object}  utils.BaseResponse[MomentTrayResponse]
// @Router       /moments/tray [get]
func (ctrl *Controller) Tray(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.Tray(c.Request.Context(), userID, c.Query("cursor"))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Mine godoc
// @Summary      My active moments with viewer counts (poll while a video is processing)
// @Tags         moment
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  utils.BaseResponse[MyMomentsResponse]
// @Router       /moments/mine [get]
func (ctrl *Controller) Mine(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.Mine(c.Request.Context(), userID)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// History godoc
// @Summary      All my moments including expired ones, newest first
// @Tags         moment
// @Produce      json
// @Security     BearerAuth
// @Param        limit  query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  utils.BaseResponse[MomentHistoryResponse]
// @Router       /moments/history [get]
func (ctrl *Controller) History(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	limit := utils.ParseLimit(c, MomentHistoryDefaultPageSize, MomentHistoryMaxPageSize)
	offset := utils.ParseOffset(c)
	resp, err := ctrl.service.History(c.Request.Context(), userID, limit, offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// MarkSeen godoc
// @Summary      Mark moments as seen (hidden from tray afterwards)
// @Tags         moment
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        request body MarkSeenRequest true "Moment ids (max 50)"
// @Success      200  {object}  utils.BaseResponse[MarkSeenResponse]
// @Router       /moments/seen [post]
func (ctrl *Controller) MarkSeen(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[MarkSeenRequest](c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.MarkSeen(c.Request.Context(), userID, req.IDs)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// React godoc
// @Summary      React to a moment of a friend or followee, taps add up per reaction type (max 99 each)
// @Tags         moment
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        id      path string             true "Moment id"
// @Param        request body ReactMomentRequest true "Reaction type and how many taps"
// @Success      200  {object}  utils.BaseResponse[ReactMomentResponse]
// @Router       /moments/{id}/reactions [post]
func (ctrl *Controller) React(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	momentID, err := utils.ParseUUIDParam(c, "id", "invalid moment id")
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[ReactMomentRequest](c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.React(c.Request.Context(), userID, momentID, req.Type, req.Count)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Viewers godoc
// @Summary      Who viewed my moment (author only)
// @Tags         moment
// @Produce      json
// @Security     BearerAuth
// @Param        id     path  string true  "Moment id"
// @Param        limit  query int    false "Page size (default 50, max 100)"
// @Param        offset query int    false "Offset"
// @Success      200  {object}  utils.BaseResponse[MomentViewersResponse]
// @Router       /moments/{id}/viewers [get]
func (ctrl *Controller) Viewers(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	momentID, err := utils.ParseUUIDParam(c, "id", "invalid moment id")
	if err != nil {
		return nil, err
	}
	limit := utils.ParseLimit(c, MomentViewersDefaultPageSize, MomentViewersMaxPageSize)
	resp, err := ctrl.service.Viewers(c.Request.Context(), userID, momentID, limit, utils.ParseOffset(c))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Reactors godoc
// @Summary      Who reacted to my moment and how many times per reaction (author only)
// @Tags         moment
// @Produce      json
// @Security     BearerAuth
// @Param        id     path  string true  "Moment id"
// @Param        limit  query int    false "Page size (default 50, max 100)"
// @Param        offset query int    false "Offset"
// @Success      200  {object}  utils.BaseResponse[MomentReactorsResponse]
// @Router       /moments/{id}/reactions [get]
func (ctrl *Controller) Reactors(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	momentID, err := utils.ParseUUIDParam(c, "id", "invalid moment id")
	if err != nil {
		return nil, err
	}
	limit := utils.ParseLimit(c, MomentViewersDefaultPageSize, MomentViewersMaxPageSize)
	resp, err := ctrl.service.Reactors(c.Request.Context(), userID, momentID, limit, utils.ParseOffset(c))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// SetHidden godoc
// @Summary      Hide or show my active moment (hidden moments leave friends' trays)
// @Tags         moment
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        id      path  string           true "Moment id"
// @Param        request body  SetHiddenRequest true "Hidden flag"
// @Success      200  {object}  utils.BaseResponse[MomentResponse]
// @Router       /moments/{id}/hidden [patch]
func (ctrl *Controller) SetHidden(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	momentID, err := utils.ParseUUIDParam(c, "id", "invalid moment id")
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[SetHiddenRequest](c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.SetHidden(c.Request.Context(), userID, momentID, *req.Hidden)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Delete godoc
// @Summary      Delete my moment (hidden now, files removed by the cleanup job)
// @Tags         moment
// @Produce      json
// @Security     BearerAuth
// @Param        id   path  string true "Moment id"
// @Success      200  {object}  utils.BaseResponse[map[string]string]
// @Router       /moments/{id} [delete]
func (ctrl *Controller) Delete(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	momentID, err := utils.ParseUUIDParam(c, "id", "invalid moment id")
	if err != nil {
		return nil, err
	}
	if err := ctrl.service.Delete(userID, momentID); err != nil {
		return nil, utils.ServiceError(err)
	}
	return map[string]string{"message": "moment deleted"}, nil
}
