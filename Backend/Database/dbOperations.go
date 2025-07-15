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


func (s *DBService) DeleteTodo(req *Utils.DeleteTodoRequest) error {
	query :=
	`DELETE FROM "todo_items"
	WHERE id = $1
	`
	
	result, err := s.db.Exec(query, req.ID)
	if err != nil {
		return fmt.Errorf("failed to delete todo: %w", err)
	}

	rowsAffected, err := result.RowsAffected()
	if err != nil {
		return fmt.Errorf("failed to check delete result: %w", err)
	}

	if rowsAffected == 0 {
		return fmt.Errorf("todo with id %s not found", req.ID)
	}

	return nil
}
