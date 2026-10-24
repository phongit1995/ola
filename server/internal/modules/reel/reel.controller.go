package reel

import (
	"encoding/json"
	"mime/multipart"
	"net/http"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

type Controller struct {
	service *Service
	logger  *zap.SugaredLogger
}

func NewController(service *Service, logger *zap.SugaredLogger) *Controller {
	return &Controller{service: service, logger: logger.Named("[reel_controller]")}
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
// @Summary      Post reels (24h): 1 text, up to 3 images, or 1 video ≤20s
// @Description  multipart: type (text|image|video), visibility (friend|public), items = JSON [{background?, overlays}], images[] + thumbs[] (image), video + thumb (video)
// @Tags         reel
// @Accept       multipart/form-data
// @Produce      json
// @Security     BearerAuth
// @Param        type       formData string true  "text, image or video"
// @Param        visibility formData string false "friend (default) or public"
// @Param        items      formData string true  "JSON array of {background, overlays}"
// @Param        images     formData file   false "Image files (≤3MB each, max 3)"
// @Param        thumbs     formData file   false "Small JPEG previews, same order as images"
// @Param        video      formData file   false "Video ≤20s, ≤45MB. Without FFMPEG_PATH only MP4 H.264 is accepted; with it MOV/WebM/MKV/AVI/WMV/FLV/3GP/TS/MPG/OGV are converted to MP4 in the background (status=processing)"
// @Param        thumb      formData file   false "Video cover JPEG (≤300KB)"
// @Success      200  {object}  utils.BaseResponse[CreateReelsResponse]
// @Router       /reels [post]
func (ctrl *Controller) Create(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	form, err := c.MultipartForm()
	if err != nil {
		return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid multipart form")
	}
	var items []CreateReelItem
	if err := json.Unmarshal([]byte(firstValue(form.Value["items"])), &items); err != nil {
		return nil, errInvalidItems
	}
	resp, err := ctrl.service.Create(c.Request.Context(), userID, &CreateReelInput{
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
// @Summary      Reel tray: my active reels (first page only) + unseen reels grouped by author, newest author first
// @Tags         reel
// @Produce      json
// @Security     BearerAuth
// @Param        cursor query string false "nextCursor from the previous page"
// @Success      200  {object}  utils.BaseResponse[ReelTrayResponse]
// @Router       /reels/tray [get]
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
// @Summary      My active reels with viewer counts (poll while a video is processing)
// @Tags         reel
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  utils.BaseResponse[MyReelsResponse]
// @Router       /reels/mine [get]
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

// MarkSeen godoc
// @Summary      Mark reels as seen (hidden from tray afterwards)
// @Tags         reel
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        request body MarkSeenRequest true "Reel ids (max 50)"
// @Success      200  {object}  utils.BaseResponse[MarkSeenResponse]
// @Router       /reels/seen [post]
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

// Viewers godoc
// @Summary      Who viewed my reel (author only)
// @Tags         reel
// @Produce      json
// @Security     BearerAuth
// @Param        id     path  string true  "Reel id"
// @Param        limit  query int    false "Page size (default 50, max 100)"
// @Param        offset query int    false "Offset"
// @Success      200  {object}  utils.BaseResponse[ReelViewersResponse]
// @Router       /reels/{id}/viewers [get]
func (ctrl *Controller) Viewers(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	reelID, err := utils.ParseUUIDParam(c, "id", "invalid reel id")
	if err != nil {
		return nil, err
	}
	limit := utils.ParseLimit(c, constants.ReelViewersDefaultPageSize, constants.ReelViewersMaxPageSize)
	resp, err := ctrl.service.Viewers(c.Request.Context(), userID, reelID, limit, utils.ParseOffset(c))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Delete godoc
// @Summary      Delete my reel (hidden now, files removed by the cleanup job)
// @Tags         reel
// @Produce      json
// @Security     BearerAuth
// @Param        id   path  string true "Reel id"
// @Success      200  {object}  utils.BaseResponse[map[string]string]
// @Router       /reels/{id} [delete]
func (ctrl *Controller) Delete(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	reelID, err := utils.ParseUUIDParam(c, "id", "invalid reel id")
	if err != nil {
		return nil, err
	}
	if err := ctrl.service.Delete(userID, reelID); err != nil {
		return nil, utils.ServiceError(err)
	}
	return map[string]string{"message": "reel deleted"}, nil
}
