package me

import (
	"fmt"
	"testing"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"

	"github.com/google/uuid"
)

func validAudioInput() MeAudioInput {
	return MeAudioInput{
		URL:      "http://localhost:9000/chat-uploads/posts/u/01012026/audio.m4a",
		MimeType: "audio/mp4",
		Size:     1024,
		Duration: 12,
		Waveform: []float64{0.1, 0.5, 0.9},
	}
}

func TestToModelAudiosAcceptsValidInput(t *testing.T) {
	audios, err := toModelAudios([]MeAudioInput{validAudioInput()}, nil)
	if err != nil {
		t.Fatalf("expected no error, got %v", err)
	}
	if len(audios) != 1 {
		t.Fatalf("expected 1 audio, got %d", len(audios))
	}
	if audios[0].Duration != 12 || audios[0].MimeType != "audio/mp4" || len(audios[0].Waveform) != 3 {
		t.Fatalf("unexpected audio %+v", audios[0])
	}
}

func TestToModelAudiosNormalizesMimeParameters(t *testing.T) {
	input := validAudioInput()
	input.MimeType = `audio/mp4;codecs="mp4a.40.2"`
	audios, err := toModelAudios([]MeAudioInput{input}, nil)
	if err != nil {
		t.Fatalf("expected no error, got %v", err)
	}
	if audios[0].MimeType != "audio/mp4" {
		t.Fatalf("expected base mime, got %q", audios[0].MimeType)
	}
}

func TestToModelAudiosRejectsInvalidInput(t *testing.T) {
	cases := map[string]func(*MeAudioInput){
		"non-audio mime": func(a *MeAudioInput) { a.MimeType = "video/mp4" },
		"empty mime":     func(a *MeAudioInput) { a.MimeType = "" },
		"zero duration":  func(a *MeAudioInput) { a.Duration = 0 },
		"too long":       func(a *MeAudioInput) { a.Duration = constants.MaxPostAudioDurationSeconds + 1 },
		"waveform > 1":   func(a *MeAudioInput) { a.Waveform = []float64{1.5} },
		"waveform < 0":   func(a *MeAudioInput) { a.Waveform = []float64{-0.1} },
		"too many samples": func(a *MeAudioInput) {
			a.Waveform = make([]float64, constants.MaxAudioWaveformSamples+1)
		},
	}
	for name, mutate := range cases {
		t.Run(name, func(t *testing.T) {
			input := validAudioInput()
			mutate(&input)
			if _, err := toModelAudios([]MeAudioInput{input}, nil); err != errInvalidAudio {
				t.Fatalf("expected errInvalidAudio, got %v", err)
			}
		})
	}
}

func TestToModelAudiosKeepsExistingRecordByURL(t *testing.T) {
	existing := models.MeAudios{{
		URL:      "http://localhost:9000/chat-uploads/posts/u/01012026/audio.m4a",
		MimeType: "audio/mp4",
		Size:     4096,
		Duration: 42,
		Waveform: []float64{0.3},
	}}
	input := MeAudioInput{URL: existing[0].URL + "?v=2", MimeType: "video/mp4", Duration: 0}
	audios, err := toModelAudios([]MeAudioInput{input}, existing)
	if err != nil {
		t.Fatalf("expected existing audio to be kept, got %v", err)
	}
	if audios[0].Duration != 42 || audios[0].Size != 4096 {
		t.Fatalf("expected stored metadata to win over client input, got %+v", audios[0])
	}
}

func TestValidPostUploadObjectNamesAllowsImagesPlusAudio(t *testing.T) {
	userID := uuid.New()
	names := make([]string, 0, constants.MaxPostUploadCleanup)
	for i := 0; i < constants.MaxPostUploadCleanup; i++ {
		names = append(names, fmt.Sprintf("%s01012026/file%d.bin", postUploadPrefix(userID), i))
	}
	cleaned, err := validPostUploadObjectNames(userID, names)
	if err != nil {
		t.Fatalf("expected %d object names to be accepted, got %v", len(names), err)
	}
	if len(cleaned) != len(names) {
		t.Fatalf("expected %d cleaned names, got %d", len(names), len(cleaned))
	}
	names = append(names, postUploadPrefix(userID)+"01012026/extra.bin")
	if _, err := validPostUploadObjectNames(userID, names); err != errInvalidImageCleanup {
		t.Fatalf("expected errInvalidImageCleanup beyond limit, got %v", err)
	}
}
