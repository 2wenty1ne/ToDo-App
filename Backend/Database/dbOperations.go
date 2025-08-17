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

	todoLists := []Utils.TodoList{}

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



//? TODO
func (s *DBService) CreateTodo(req *Utils.CreateTodoRequest) (*Utils.Todo, error) {
	query :=
	`INSERT INTO "todos"
	("title", "todo_list_id", "todo_group_id")
	VALUES ($1, $2, $3)
	RETURNING id, title, description, completed, todo_list_id, todo_group_id, created_at, updated_at`

	var todo Utils.Todo

	err := s.db.QueryRow(query, req.Title, req.TodoListID, req.TodoGroupID).Scan(
		&todo.ID,
		&todo.Title,
		&todo.Description,
		&todo.Completed,
		&todo.TodoListID,
		&todo.TodoGroupID,
		&todo.CreatedAt,
		&todo.UpdatedAt,
	)

	if err != nil {
		return nil, fmt.Errorf("failed to create todo: %w", err)
	}

	return &todo, nil
}


func (s *DBService) ReadTodos(req *Utils.ReadTodosRequest) ([]Utils.Todo, error) {
	query := 
	`SELECT id, title, description, completed, todo_list_id, todo_group_id, created_at, updated_at
	FROM "todos"
	WHERE todo_list_id = $1
	ORDER BY created_at ASC`

	rows, err := s.db.Query(query, req.TodoListID)

	if err != nil {
		return nil, fmt.Errorf("failed to query todo: %w", err)
	}
	defer rows.Close()

	todos := []Utils.Todo{}

	for rows.Next() {
		var todo Utils.Todo

		err := rows.Scan(
			&todo.ID,
			&todo.Title,
			&todo.Description,
			&todo.Completed,
			&todo.TodoListID,
			&todo.TodoGroupID,
			&todo.CreatedAt,
			&todo.UpdatedAt,
		)

		if err != nil {
			return nil, fmt.Errorf("failed to scan todo: %w", err)
		}

		todos = append(todos, todo)
	}

	if err = rows.Err(); err != nil {
		return nil, fmt.Errorf("failed iterating over rows: %w", err)
	}

	return todos, nil
}


func (s *DBService) UpdateTodo(req *Utils.UpdateTodoRequest) (*Utils.Todo, error) {
	query :=
	`UPDATE "todos"
	SET "title" = $1, "description" = $2, "completed" = $3, "todo_group_id" = $4
	WHERE id = $5
	RETURNING id, title, description, completed, todo_list_id, todo_group_id, created_at, updated_at`

	var todo Utils.Todo

	err := s.db.QueryRow(query, req.Title, req.Description, req.Completed, req.TodoGroupID, req.ID).Scan(
		&todo.ID,
		&todo.Title,
		&todo.Description,
		&todo.Completed,
		&todo.TodoListID,
		&todo.TodoGroupID,
		&todo.CreatedAt,
		&todo.UpdatedAt,
	)
	if err != nil {
		return nil, fmt.Errorf("failed to update todo: %w", err)
	}

	return &todo, nil
}


func (s *DBService) DeleteTodo(req *Utils.DeleteTodoRequest) error {
	query :=
	`DELETE FROM "todos"
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

