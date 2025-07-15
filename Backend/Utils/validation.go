package Utils

import (
	"fmt"
	"strings"
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
