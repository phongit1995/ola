package message

import (
	"bytes"
	"encoding/json"
	"errors"
	"mime/multipart"
	"net/http"
	"net/http/httptest"
	"testing"

	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
)

func TestSendAudioMessageRejectsOversizedWaveform(t *testing.T) {
	gin.SetMode(gin.TestMode)

	var body bytes.Buffer
	writer := multipart.NewWriter(&body)
	if err := writer.WriteField("conversationId", uuid.NewString()); err != nil {
		t.Fatal(err)
	}
	if err := writer.WriteField("duration", "1"); err != nil {
		t.Fatal(err)
	}
	waveform, err := json.Marshal(make([]float64, maxAudioWaveformSamples+1))
	if err != nil {
		t.Fatal(err)
	}
	if err := writer.WriteField("waveform", string(waveform)); err != nil {
		t.Fatal(err)
	}
	file, err := writer.CreateFormFile("file", "voice.webm")
	if err != nil {
		t.Fatal(err)
	}
	if _, err := file.Write([]byte("audio")); err != nil {
		t.Fatal(err)
	}
	if err := writer.Close(); err != nil {
		t.Fatal(err)
	}

	request := httptest.NewRequest(http.MethodPost, "/messages/audio", &body)
	request.Header.Set("Content-Type", writer.FormDataContentType())
	context, _ := gin.CreateTestContext(httptest.NewRecorder())
	context.Request = request
	context.Set("user_id", uuid.New())

	controller := &Controller{}
	_, err = controller.SendAudioMessage(context)

	var httpError *utils.HTTPError
	if !errors.As(err, &httpError) {
		t.Fatalf("expected HTTP error, got %v", err)
	}
	if httpError.Status != http.StatusBadRequest {
		t.Fatalf("expected status %d, got %d", http.StatusBadRequest, httpError.Status)
	}
	if httpError.Message != "invalid waveform" {
		t.Fatalf("expected invalid waveform error, got %q", httpError.Message)
	}
}
