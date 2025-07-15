package Utils

import (
	"time"
)



type Todo struct {
	ID          string    `json:"id"`
	Title       string    `json:"title"`
	Description string    `json:"description"`
	Completed   bool      `json:"completed"`
	HasSubtasks bool      `json:"has_subtasks"`
	CreatedAt   time.Time `json:"created_at"`
}


type CreateTodoRequest struct {
	Title       string `json:"title"`
	Description string `json:"description"`
}

type DeleteTodoRequest struct {
	ID			string `json:"id"`
}


//? Response types
type APIResponse struct {
	Success bool        `json:"success"`
	Message string      `json:"message"`
	Data    interface{} `json:"data,omitempty"`
}


type APIError struct {
	Success bool   `json:"success"`
	Message string `json:"message"`
	Error   string `json:"error,omitempty"`
}
