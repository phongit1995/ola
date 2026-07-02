package adminupload

import (
	"net/http"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/services"
	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

type Controller struct {
	minio  *services.MinIOService
	logger *zap.SugaredLogger
}

func NewController(minio *services.MinIOService, logger *zap.SugaredLogger) *Controller {
	return &Controller{minio: minio, logger: logger.Named("[admin_upload_controller]")}
}

type UploadResponse struct {
	URL string `json:"url"`
}

// Upload godoc
// @Summary      Upload an image (admin)
// @Description  Upload an image to storage and get its URL (jpg, png, gif, webp, ≤5MB)
// @Tags         admin-upload
// @Accept       multipart/form-data
// @Produce      json
// @Security     BearerAuth
// @Param        file formData file true "Image file"
// @Success      200  {object}  utils.BaseResponse[UploadResponse]
// @Router       /admin/upload [post]
func (ctrl *Controller) Upload(c *gin.Context) (interface{}, error) {
	file, header, err := c.Request.FormFile("file")
	if err != nil {
		return nil, utils.NewHTTPError(http.StatusBadRequest, "file is required")
	}
	defer file.Close()

	if header.Size > constants.MaxAdminImageUploadSize {
		return nil, utils.NewHTTPError(http.StatusRequestEntityTooLarge, "file size must not exceed 5MB")
	}

	result, err := ctrl.minio.UploadFile(c.Request.Context(), file, header.Filename, constants.UploadFolderAdmin)
	if err != nil {
		ctrl.logger.Errorw("Admin upload failed", "filename", header.Filename, "error", err)
		return nil, utils.ServiceError(err)
	}
	return UploadResponse{URL: result.URL}, nil
}
