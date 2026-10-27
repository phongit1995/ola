package moment

import (
	"math"
	"net/http"
	"regexp"
	"strings"
	"unicode/utf8"

	"ola-chat-server/internal/models"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
)

var (
	momentKeyPattern   = regexp.MustCompile(`^[a-z0-9_-]{1,32}$`)
	momentColorPattern = regexp.MustCompile(`^#[0-9a-fA-F]{6}$`)
)

var (
	errInvalidType       = utils.NewHTTPError(http.StatusBadRequest, "invalid moment type")
	errInvalidVisibility = utils.NewHTTPError(http.StatusBadRequest, "invalid moment visibility")
	errInvalidItems      = utils.NewHTTPError(http.StatusBadRequest, "invalid moment items")
	errInvalidBackground = utils.NewHTTPError(http.StatusBadRequest, "invalid moment background")
	errInvalidOverlay    = utils.NewHTTPError(http.StatusBadRequest, "invalid moment overlay")
	errTooManyOverlays   = utils.NewHTTPError(http.StatusBadRequest, "too many moment overlays")
	errEmptyTextMoment   = utils.NewHTTPError(http.StatusBadRequest, "text moment needs text")
)

var momentOverlayStyles = map[string]bool{
	MomentOverlayStylePlain: true,
	MomentOverlayStyleSolid: true,
	MomentOverlayStyleSoft:  true,
}

var momentAligns = map[string]bool{
	MomentAlignLeft:   true,
	MomentAlignCenter: true,
	MomentAlignRight:  true,
}

func validType(value string) bool {
	return value == MomentTypeImage || value == MomentTypeVideo || value == MomentTypeText
}

func slideType(postType, value string) (string, error) {
	itemType := strings.TrimSpace(value)
	if itemType == "" || itemType == postType {
		return postType, nil
	}
	if postType == MomentTypeVideo || itemType == MomentTypeVideo || !validType(itemType) {
		return "", errInvalidType
	}
	return itemType, nil
}

func normalizeVisibility(value string) (string, error) {
	switch strings.TrimSpace(value) {
	case "", MomentVisibilityFriend:
		return MomentVisibilityFriend, nil
	case MomentVisibilityPublic:
		return MomentVisibilityPublic, nil
	}
	return "", errInvalidVisibility
}

func normalizeBackground(momentType, value string) (string, error) {
	if momentType != MomentTypeText {
		return "", nil
	}
	background := strings.TrimSpace(value)
	if !momentKeyPattern.MatchString(background) {
		return "", errInvalidBackground
	}
	return background, nil
}

func normalizeOverlays(inputs []models.MomentOverlay) (models.MomentOverlays, error) {
	if len(inputs) > MaxMomentOverlays {
		return nil, errTooManyOverlays
	}
	overlays := make(models.MomentOverlays, 0, len(inputs))
	for _, input := range inputs {
		overlay, keep, err := normalizeOverlay(input)
		if err != nil {
			return nil, err
		}
		if keep {
			overlays = append(overlays, overlay)
		}
	}
	return overlays, nil
}

func normalizeOverlay(input models.MomentOverlay) (models.MomentOverlay, bool, error) {
	text := strings.TrimSpace(input.Text)
	if text == "" {
		return models.MomentOverlay{}, false, nil
	}
	if utf8.RuneCountInString(text) > MaxMomentOverlayRunes {
		return models.MomentOverlay{}, false, errInvalidOverlay
	}
	if !inRange(input.X, 0, 1) || !inRange(input.Y, 0, 1) ||
		!inRange(input.W, MomentOverlayWidthMin, MomentOverlayWidthMax) ||
		!inRange(input.Scale, MomentOverlayScaleMin, MomentOverlayScaleMax) ||
		!inRange(input.Rotation, -MomentOverlayRotationMax, MomentOverlayRotationMax) {
		return models.MomentOverlay{}, false, errInvalidOverlay
	}
	if !momentColorPattern.MatchString(input.Color) || !momentOverlayStyles[input.Style] ||
		!momentAligns[input.Align] || !momentKeyPattern.MatchString(input.Font) {
		return models.MomentOverlay{}, false, errInvalidOverlay
	}
	id := strings.TrimSpace(input.ID)
	if id == "" || len(id) > MaxMomentOverlayIDLen {
		id = uuid.NewString()
	}
	return models.MomentOverlay{
		ID:       id,
		Text:     text,
		X:        input.X,
		Y:        input.Y,
		W:        input.W,
		Scale:    input.Scale,
		Rotation: input.Rotation,
		Color:    strings.ToLower(input.Color),
		Style:    input.Style,
		Font:     input.Font,
		Bold:     input.Bold,
		Italic:   input.Italic,
		Align:    input.Align,
	}, true, nil
}

func inRange(value, min, max float64) bool {
	return !math.IsNaN(value) && value >= min && value <= max
}

func validateItemCount(momentType string, items int) error {
	limit := MaxMomentSlides
	if momentType == MomentTypeVideo {
		limit = 1
	}
	if items < 1 || items > limit {
		return errInvalidItems
	}
	return nil
}
