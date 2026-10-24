package report

import (
	"testing"

	"ola-chat-server/internal/constants"
)

func TestCanonicalTargetIDLowercasesUUIDTargets(t *testing.T) {
	upper := "7C9E6679-7425-40DE-944B-E07FC1F90AE7"
	want := "7c9e6679-7425-40de-944b-e07fc1f90ae7"
	for _, targetType := range []string{constants.ReportTargetReel, constants.ReportTargetPost, constants.ReportTargetMessage} {
		if got := canonicalTargetID(targetType, upper); got != want {
			t.Fatalf("%s: expected %s, got %s", targetType, want, got)
		}
	}
	if got := canonicalTargetID(constants.ReportTargetReel, "{"+upper+"}"); got != want {
		t.Fatalf("expected braces form to be canonical, got %s", got)
	}
}

func TestCanonicalTargetIDKeepsOtherTargets(t *testing.T) {
	if got := canonicalTargetID(constants.ReportTargetRoomMessage, "MSG-ABC"); got != "MSG-ABC" {
		t.Fatalf("expected room message id untouched, got %s", got)
	}
	if got := canonicalTargetID(constants.ReportTargetReel, "not-a-uuid"); got != "not-a-uuid" {
		t.Fatalf("expected invalid id untouched, got %s", got)
	}
}
