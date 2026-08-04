package chatbot

type Message struct {
	Role    string `json:"role" binding:"required,oneof=user assistant system" example:"user"`
	Content string `json:"content" binding:"required" example:"Chào bạn"`
}

type CompletionRequest struct {
	Messages []Message `json:"messages" binding:"required,min=1,dive"`
	Stream   bool      `json:"stream" example:"false"`
}

type Usage struct {
	PromptTokens     int `json:"promptTokens" example:"120"`
	CompletionTokens int `json:"completionTokens" example:"340"`
	TotalTokens      int `json:"totalTokens" example:"460"`
}

type CompletionResponse struct {
	ID           string `json:"id" example:"chatbot-6f1c2a9d4e8b"`
	Model        string `json:"model" example:"gemini-3.6-flash"`
	Created      int64  `json:"created" example:"1764844800"`
	Content      string `json:"content" example:"Chào bạn, mình có thể giúp gì?"`
	FinishReason string `json:"finishReason" example:"stop"`
	Usage        Usage  `json:"usage"`
}

type StreamChunk struct {
	ID           string `json:"id" example:"chatbot-6f1c2a9d4e8b"`
	Model        string `json:"model" example:"gemini-3.6-flash"`
	Created      int64  `json:"created" example:"1764844800"`
	Delta        string `json:"delta,omitempty" example:"Chào "`
	FinishReason string `json:"finishReason,omitempty" example:"stop"`
	Usage        *Usage `json:"usage,omitempty"`
	Error        string `json:"error,omitempty"`
}
