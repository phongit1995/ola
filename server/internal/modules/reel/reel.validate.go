package reel

import (
	"math"
	"net/http"
	"regexp"
	"strings"
	"unicode/utf8"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
)

var (
	reelKeyPattern   = regexp.MustCompile(`^[a-z0-9_-]{1,32}$`)
	reelColorPattern = regexp.MustCompile(`^#[0-9a-fA-F]{6}$`)
)

var (
	errInvalidType       = utils.NewHTTPError(http.StatusBadRequest, "invalid reel type")
	errInvalidVisibility = utils.NewHTTPError(http.StatusBadRequest, "invalid reel visibility")
	errInvalidItems      = utils.NewHTTPError(http.StatusBadRequest, "invalid reel items")
	errInvalidBackground = utils.NewHTTPError(http.StatusBadRequest, "invalid reel background")
	errInvalidOverlay    = utils.NewHTTPError(http.StatusBadRequest, "invalid reel overlay")
	errTooManyOverlays   = utils.NewHTTPError(http.StatusBadRequest, "too many reel overlays")
	errEmptyTextReel     = utils.NewHTTPError(http.StatusBadRequest, "text reel needs text")
)

var reelOverlayStyles = map[string]bool{
	constants.ReelOverlayStylePlain: true,
	constants.ReelOverlayStyleSolid: true,
	constants.ReelOverlayStyleSoft:  true,
}

var reelAligns = map[string]bool{
	constants.ReelAlignLeft:   true,
	constants.ReelAlignCenter: true,
	constants.ReelAlignRight:  true,
}

func validType(value string) bool {
	return value == constants.ReelTypeImage || value == constants.ReelTypeVideo || value == constants.ReelTypeText
}

func normalizeVisibility(value string) (string, error) {
	switch strings.TrimSpace(value) {
	case "", constants.ReelVisibilityFriend:
		return constants.ReelVisibilityFriend, nil
	case constants.ReelVisibilityPublic:
		return constants.ReelVisibilityPublic, nil
	}
	return "", errInvalidVisibility
}

func normalizeBackground(reelType, value string) (string, error) {
	if reelType != constants.ReelTypeText {
		return "", nil
	}
	background := strings.TrimSpace(value)
	if !reelKeyPattern.MatchString(background) {
		return "", errInvalidBackground
	}
	return background, nil
}

func normalizeOverlays(inputs []models.ReelOverlay) (models.ReelOverlays, error) {
	if len(inputs) > constants.MaxReelOverlays {
		return nil, errTooManyOverlays
	}
	overlays := make(models.ReelOverlays, 0, len(inputs))
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

func normalizeOverlay(input models.ReelOverlay) (models.ReelOverlay, bool, error) {
	text := strings.TrimSpace(input.Text)
	if text == "" {
		return models.ReelOverlay{}, false, nil
	}
	if utf8.RuneCountInString(text) > constants.MaxReelOverlayRunes {
		return models.ReelOverlay{}, false, errInvalidOverlay
	}
	if !inRange(input.X, 0, 1) || !inRange(input.Y, 0, 1) ||
		!inRange(input.W, constants.ReelOverlayWidthMin, constants.ReelOverlayWidthMax) ||
		!inRange(input.Scale, constants.ReelOverlayScaleMin, constants.ReelOverlayScaleMax) ||
		!inRange(input.Rotation, -constants.ReelOverlayRotationMax, constants.ReelOverlayRotationMax) {
		return models.ReelOverlay{}, false, errInvalidOverlay
	}
	if !reelColorPattern.MatchString(input.Color) || !reelOverlayStyles[input.Style] ||
		!reelAligns[input.Align] || !reelKeyPattern.MatchString(input.Font) {
		return models.ReelOverlay{}, false, errInvalidOverlay
	}
	id := strings.TrimSpace(input.ID)
	if id == "" || len(id) > constants.MaxReelOverlayIDLen {
		id = uuid.NewString()
	}
	return models.ReelOverlay{
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
		Align:    input.Align,
	}, true, nil
}

func inRange(value, min, max float64) bool {
	return !math.IsNaN(value) && value >= min && value <= max
}

func validateItemCount(reelType string, items int) error {
	switch reelType {
	case constants.ReelTypeImage:
		if items < 1 || items > constants.MaxReelImages {
			return errInvalidItems
		}
	default:
		if items != 1 {
			return errInvalidItems
		}
	}
	return nil
}
