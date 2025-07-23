package Database

import (
	"fmt"

	"github.com/2wenty1ne/ToDo-App/Utils"
)


//? TODO LISTS
func (s* DBService) CreateTodoList(req *Utils.CreateTodoListRequest) (*Utils.TodoList, error) {
	query := 
	`INSERT INTO "todo_lists"
	("title")
	VALUES ($1)
	RETURNING id, title, created_at, updated_at`

	var todoList Utils.TodoList

	err := s.db.QueryRow(query, req.Title).Scan(
		&todoList.ID,
		&todoList.Title,
		&todoList.CreatedAt,
		&todoList.UpdatedAt,
	)

	if err != nil {
		return nil, fmt.Errorf("failed to create todolist: %w", err)
	}

	return &todoList, nil
}


func (s *DBService) ReadTodoLists() ([]Utils.TodoList, error) {
	query := 
	`SELECT id, title, created_at, updated_at
	FROM "todo_lists"
	ORDER BY created_at DESC`

	rows, err := s.db.Query(query)
	if err != nil {
		return nil, fmt.Errorf("failed to query todo lists: %w", err)
	}
	defer rows.Close()

	var todoLists []Utils.TodoList

	for rows.Next() {
		var todoList Utils.TodoList

		err := rows.Scan(
			&todoList.ID,
			&todoList.Title,
			&todoList.CreatedAt,
			&todoList.UpdatedAt,
		)
		if err != nil {
			return nil, fmt.Errorf("failed to scan todo list: %w", err)
		}

		todoLists = append(todoLists, todoList)
	}

	if err = rows.Err(); err != nil {
		return nil, fmt.Errorf("failed iterating over rows: %w", err)
	}

	return todoLists, nil
}


func (s *DBService) UpdateTodoList(req *Utils.UpdateTodoListRequest) (*Utils.TodoList, error) {
	query := 
	`UPDATE "todo_lists"
	SET "title" = $1
	WHERE id = $2
	RETURNING id, title, created_at, updated_at`

	var todoList Utils.TodoList

	err := s.db.QueryRow(query, req.Title, req.ID).Scan(
		&todoList.ID,
		&todoList.Title,
		&todoList.CreatedAt,
		&todoList.UpdatedAt,
	)

	if err != nil {
		return nil, fmt.Errorf("failed to update todolist: %w", err)
	}

	return &todoList, nil
}


func (s *DBService) DeleteTodoList(req *Utils.DeleteTodoListRequest) error {
	query :=
	`DELETE FROM "todo_lists"
	WHERE id = $1`

	result, err := s.db.Exec(query, req.ID)
	if err != nil {
		return fmt.Errorf("failed to delete todo: %w", err)
	}

	rowsAffected, err := result.RowsAffected()
	if err != nil {
		return fmt.Errorf("failed to check result: %w", err)
	}

	if rowsAffected == 0 {
		return fmt.Errorf("todo with id %s not found", req.ID)
	}

	return nil
}




//TODO Maybe anpassen an neues DB Schema
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
		&todo.CreatedAt,
	)

	if err != nil {
		return nil, fmt.Errorf("failed to create todo: %w", err)
	}

	return &todo, nil
}


//TODO Maybe anpassen an neues DB Schema
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
