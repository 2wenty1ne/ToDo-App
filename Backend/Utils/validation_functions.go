package Utils

import (
	"fmt"
	"strings"

	"github.com/google/uuid"
)


func CheckID(reqID string) error {
	id := strings.TrimSpace(reqID)

	if id == "" {
		return fmt.Errorf("ID is required")
	}
	
	_, err := uuid.Parse(id)
	if err != nil {
		return fmt.Errorf("ID must be valid UUID")
	}

	return nil
}


func CheckTitle(reqTitle string, maxTitleLength int) error {
	if strings.TrimSpace(reqTitle) == "" {
		return fmt.Errorf("title is required")
	}

	if len(reqTitle) > maxTitleLength {
		return fmt.Errorf("title must be less than %d characters", maxTitleLength)
	}

	return nil
}
