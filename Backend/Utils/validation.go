package Utils

import (
	"fmt"
	"strings"

	"github.com/google/uuid"
)

func (r *CreateTodoRequest) Validate() error {
	if strings.TrimSpace(r.Title) == "" {
		return fmt.Errorf("title is required")
	}

	if len(r.Title) > 255 {
		return fmt.Errorf("title must be less than 255 characters")
	}

	if len(r.Description) > 1000 {
		return fmt.Errorf("description must be less than 1000 characters")
	}

	return nil
}

func (r *DeleteTodoRequest) Validate() error {
	id := strings.TrimSpace(r.ID)

	if id == "" {
		return fmt.Errorf("ID is required")
	}
	
	_, err := uuid.Parse(id)
	if err != nil {
		return fmt.Errorf("id must be valid UUID")
	}

	return nil
}
