package story

import (
	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
)

type Controller struct {
	service *Service
}

func NewController(service *Service) *Controller {
	return &Controller{service: service}
}

// List godoc
// @Summary      Danh sách truyện
// @Tags         story
// @Produce      json
// @Security     BearerAuth
// @Param        sort query string false "updated | views | new"
// @Param        genre query string false "Tên thể loại"
// @Param        status query string false "all | ongoing | completed"
// @Param        q query string false "Tìm theo tên truyện hoặc tác giả, không phân biệt dấu"
// @Param        offset query int false "Vị trí bắt đầu"
// @Param        limit query int false "Số truyện mỗi trang"
// @Success      200  {object}  utils.BaseResponse[StoryListResponse]
// @Router       /stories [get]
func (ctrl *Controller) List(c *gin.Context) (interface{}, error) {
	resp, err := ctrl.service.List(c.Request.Context(), ListQuery{
		Sort:   c.Query("sort"),
		Genre:  c.Query("genre"),
		Status: c.Query("status"),
		Query:  c.Query("q"),
		Offset: utils.ParseOffset(c),
		Limit:  utils.ParseLimit(c, constants.StoryPageSize, constants.StoryPageMax),
	})
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Genres godoc
// @Summary      Thể loại truyện và số truyện mỗi thể loại
// @Tags         story
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  utils.BaseResponse[GenreListResponse]
// @Router       /stories/genres [get]
func (ctrl *Controller) Genres(c *gin.Context) (interface{}, error) {
	resp, err := ctrl.service.Genres(c.Request.Context())
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Detail godoc
// @Summary      Thông tin một truyện
// @Tags         story
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "ID truyện"
// @Success      200  {object}  utils.BaseResponse[StoryResponse]
// @Router       /stories/{id} [get]
func (ctrl *Controller) Detail(c *gin.Context) (interface{}, error) {
	resp, err := ctrl.service.Detail(c.Request.Context(), c.Param("id"))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Chapters godoc
// @Summary      Danh sách chương của truyện, theo thứ tự
// @Tags         story
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "ID truyện"
// @Success      200  {object}  utils.BaseResponse[ChapterListResponse]
// @Router       /stories/{id}/chapters [get]
func (ctrl *Controller) Chapters(c *gin.Context) (interface{}, error) {
	resp, err := ctrl.service.Chapters(c.Request.Context(), c.Param("id"))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Chapter godoc
// @Summary      Nội dung một chương
// @Tags         story
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "ID truyện"
// @Param        position path int true "Thứ tự chương, bắt đầu từ 1"
// @Success      200  {object}  utils.BaseResponse[ChapterResponse]
// @Router       /stories/{id}/chapters/{position} [get]
func (ctrl *Controller) Chapter(c *gin.Context) (interface{}, error) {
	resp, err := ctrl.service.Chapter(c.Request.Context(), c.Param("id"), c.Param("position"))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}
