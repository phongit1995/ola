package chatbot

type Message struct {
	Role    string `json:"role" binding:"required,oneof=user assistant system" example:"user"`
	Content string `json:"content" binding:"required" example:"Chào bạn"`
}

type CompletionRequest struct {
	Messages []Message `json:"messages" binding:"required,min=1,max=80,dive"`
	Stream   bool      `json:"stream" example:"false"`
}

type CompletionResponse struct {
	ID           string `json:"id" example:"chatbot-6f1c2a9d4e8b"`
	Content      string `json:"content" example:"Chào bạn, mình có thể giúp gì?"`
	FinishReason string `json:"finishReason" example:"stop"`
}

type StreamChunk struct {
	ID           string `json:"id" example:"chatbot-6f1c2a9d4e8b"`
	Delta        string `json:"delta,omitempty" example:"Chào "`
	FinishReason string `json:"finishReason,omitempty" example:"stop"`
	Error        string `json:"error,omitempty"`
}
