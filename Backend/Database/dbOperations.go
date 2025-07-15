package Database

import (
	"fmt"

	"github.com/2wenty1ne/ToDo-App/Utils"
)


func (s *DBService) CreateTodo(req *Utils.CreateTodoRequest) (*Utils.Todo, error) {
	query := 
	`INSERT INTO "todo_items"
	("title", "description")
	VALUES ($1, $2)
	RETURNING id, title, description, completed, has_subtasks, created_at`

	var todo Utils.Todo

	err := s.db.QueryRow(query, req.Title, req.Description).Scan(
		&todo.ID,
		&todo.Title,
		&todo.Description,
		&todo.Completed,
		&todo.HasSubtasks,
		&todo.CreatedAt,
	)

	if err != nil {
		return nil, fmt.Errorf("failed to create todo: %w", err)
	}

	return &todo, nil
}

