package adminstory

import (
	"ola-chat-server/internal/modules/story"
	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
)

type Controller struct {
	service *story.Service
	crawler *story.Crawler
}

func NewController(service *story.Service, crawler *story.Crawler) *Controller {
	return &Controller{service: service, crawler: crawler}
}

// List godoc
// @Summary      Danh sách truyện (admin), gồm cả truyện ẩn
// @Tags         admin-story
// @Produce      json
// @Security     BearerAuth
// @Param        q query string false "Tìm theo tên truyện hoặc tác giả"
// @Param        genre query string false "Tên thể loại"
// @Param        status query string false "ongoing | completed"
// @Param        kind query string false "short | long"
// @Param        visibility query string false "all | visible | hidden"
// @Param        source query string false "Nguồn truyện, ví dụ vnkings"
// @Param        sort query string false "updated | views | new"
// @Param        offset query int false "Vị trí bắt đầu"
// @Param        limit query int false "Số truyện mỗi trang"
// @Success      200  {object}  utils.BaseResponse[story.AdminStoryListResponse]
// @Router       /admin/stories [get]
func (ctrl *Controller) List(c *gin.Context) (interface{}, error) {
	resp, err := ctrl.service.AdminList(c.Request.Context(), story.ListQuery{
		Sort:       c.Query("sort"),
		Genre:      c.Query("genre"),
		Status:     c.Query("status"),
		Kind:       c.Query("kind"),
		Visibility: c.Query("visibility"),
		Source:     c.Query("source"),
		Query:      c.Query("q"),
		Offset:     utils.ParseOffset(c),
		Limit:      utils.ParseLimit(c, story.StoryAdminPageSize, story.StoryAdminPageMax),
	})
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Summary godoc
// @Summary      Số truyện, số chương và số chương đã có nội dung (admin)
// @Tags         admin-story
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  utils.BaseResponse[story.AdminSummaryResponse]
// @Router       /admin/stories/summary [get]
func (ctrl *Controller) Summary(c *gin.Context) (interface{}, error) {
	resp, err := ctrl.service.AdminSummary(c.Request.Context())
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Genres godoc
// @Summary      Thể loại truyện, gồm cả truyện ẩn (admin)
// @Tags         admin-story
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  utils.BaseResponse[story.GenreListResponse]
// @Router       /admin/stories/genres [get]
func (ctrl *Controller) Genres(c *gin.Context) (interface{}, error) {
	resp, err := ctrl.service.AdminGenres(c.Request.Context())
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Sources godoc
// @Summary      Các nguồn truyện và số truyện mỗi nguồn (admin)
// @Tags         admin-story
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  utils.BaseResponse[story.SourceListResponse]
// @Router       /admin/stories/sources [get]
func (ctrl *Controller) Sources(c *gin.Context) (interface{}, error) {
	resp, err := ctrl.service.AdminSources(c.Request.Context())
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// UpdateMany godoc
// @Summary      Ẩn hoặc hiện nhiều truyện theo danh sách ID hoặc theo bộ lọc (admin)
// @Tags         admin-story
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        request body story.BulkVisibilityRequest true "Trạng thái ẩn và truyện cần đổi"
// @Success      200  {object}  utils.BaseResponse[story.BulkVisibilityResponse]
// @Failure      400  {object}  utils.APIError
// @Router       /admin/stories [patch]
func (ctrl *Controller) UpdateMany(c *gin.Context) (interface{}, error) {
	req, err := utils.BindJSON[story.BulkVisibilityRequest](c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.SetHiddenMany(c.Request.Context(), *req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Detail godoc
// @Summary      Thông tin một truyện (admin)
// @Tags         admin-story
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "ID truyện"
// @Success      200  {object}  utils.BaseResponse[story.AdminStoryResponse]
// @Router       /admin/stories/{id} [get]
func (ctrl *Controller) Detail(c *gin.Context) (interface{}, error) {
	resp, err := ctrl.service.AdminDetail(c.Request.Context(), c.Param("id"))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Update godoc
// @Summary      Ẩn hoặc hiện truyện (admin)
// @Tags         admin-story
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "ID truyện"
// @Param        request body story.UpdateStoryRequest true "Trạng thái ẩn"
// @Success      200  {object}  utils.BaseResponse[story.AdminStoryResponse]
// @Router       /admin/stories/{id} [patch]
func (ctrl *Controller) Update(c *gin.Context) (interface{}, error) {
	req, err := utils.BindJSON[story.UpdateStoryRequest](c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.SetHidden(c.Request.Context(), c.Param("id"), *req.IsHidden)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Delete godoc
// @Summary      Xoá truyện và toàn bộ chương (admin)
// @Tags         admin-story
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "ID truyện"
// @Success      200  {object}  map[string]string
// @Router       /admin/stories/{id} [delete]
func (ctrl *Controller) Delete(c *gin.Context) (interface{}, error) {
	if err := ctrl.service.DeleteStory(c.Request.Context(), c.Param("id")); err != nil {
		return nil, utils.ServiceError(err)
	}
	return map[string]string{"message": "story deleted"}, nil
}

// Chapters godoc
// @Summary      Danh sách chương kèm trạng thái nội dung (admin)
// @Tags         admin-story
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "ID truyện"
// @Success      200  {object}  utils.BaseResponse[story.AdminChapterListResponse]
// @Router       /admin/stories/{id}/chapters [get]
func (ctrl *Controller) Chapters(c *gin.Context) (interface{}, error) {
	resp, err := ctrl.service.AdminChapters(c.Request.Context(), c.Param("id"))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// FetchContent godoc
// @Summary      Lấy nội dung mọi chương còn thiếu của truyện, chạy nền (admin)
// @Tags         admin-story
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "ID truyện"
// @Success      200  {object}  utils.BaseResponse[story.FetchMissingResponse]
// @Failure      409  {object}  utils.APIError
// @Router       /admin/stories/{id}/fetch-content [post]
func (ctrl *Controller) FetchContent(c *gin.Context) (interface{}, error) {
	resp, err := ctrl.service.FetchMissingContent(c.Request.Context(), c.Param("id"))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Chapter godoc
// @Summary      Xem nội dung chương đang lưu, không tự lấy từ nguồn (admin)
// @Tags         admin-story
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "ID truyện"
// @Param        position path int true "Thứ tự chương"
// @Success      200  {object}  utils.BaseResponse[story.AdminChapterDetailResponse]
// @Router       /admin/stories/{id}/chapters/{position} [get]
func (ctrl *Controller) Chapter(c *gin.Context) (interface{}, error) {
	resp, err := ctrl.service.AdminChapter(c.Request.Context(), c.Param("id"), c.Param("position"))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Refetch godoc
// @Summary      Lấy lại nội dung chương từ nguồn, ghi đè nội dung cũ (admin)
// @Tags         admin-story
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "ID truyện"
// @Param        position path int true "Thứ tự chương"
// @Success      200  {object}  utils.BaseResponse[story.AdminChapterDetailResponse]
// @Failure      502  {object}  utils.APIError
// @Router       /admin/stories/{id}/chapters/{position}/refetch [post]
func (ctrl *Controller) Refetch(c *gin.Context) (interface{}, error) {
	resp, err := ctrl.service.RefetchChapter(c.Request.Context(), c.Param("id"), c.Param("position"))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Crawler godoc
// @Summary      Cấu hình, trạng thái và log của tự động cập nhật truyện (admin)
// @Tags         admin-story
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  utils.BaseResponse[story.CrawlerStatusResponse]
// @Router       /admin/stories/crawler [get]
func (ctrl *Controller) Crawler(c *gin.Context) (interface{}, error) {
	resp, err := ctrl.crawler.Status(c.Request.Context())
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// RunCrawler godoc
// @Summary      Chạy ngay một lượt cập nhật truyện ở nền (admin)
// @Tags         admin-story
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  utils.BaseResponse[story.CrawlRunResponse]
// @Failure      409  {object}  utils.APIError
// @Router       /admin/stories/crawler/run [post]
func (ctrl *Controller) RunCrawler(c *gin.Context) (interface{}, error) {
	if err := ctrl.crawler.RunNow(); err != nil {
		return nil, utils.ServiceError(err)
	}
	return story.CrawlRunResponse{Started: true}, nil
}
