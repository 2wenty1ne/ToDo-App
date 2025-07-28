package Utils

import (
	"database/sql"
	"time"
)

//? Todo List
type TodoList struct {
	ID          string    `json:"id"`
	Title 		string	  `json:"title"`
	CreatedAt   time.Time `json:"created_at"`
	UpdatedAt   time.Time `json:"updated_at"`
}

type CreateTodoListRequest struct {
	Title 		string	  `json:"title" validate:"required"`
}

type UpdateTodoListRequest struct {
	ID          string    `json:"id" validate:"required,uuid"`
	Title 		string	  `json:"title" validate:"required"`
}

type DeleteTodoListRequest struct {
	ID          string    `json:"id" validate:"required,uuid"`
}



//? Todo Group
type TodoGroup struct {
	ID          string    `json:"id"`
	Name 		string 	  `json:"name"`
	TodoListID	string	  `json:"todo_list_id"`
	CreatedAt   time.Time `json:"created_at"`
	UpdatedAt   time.Time `json:"updated_at"`
}

type CreateTodoGroupRequest struct {
	Name 		string 	  `json:"name" validate:"required"`
	TodoListID	string	  `json:"todo_list_id" validate:"required,uuid"`
}

type ReadTodoGroupsRequest struct {
	TodoListID	string	  `json:"todo_list_id" validate:"required,uuid"`
}

type UpdateTodoGroupRequest struct {
	ID          string    `json:"id" validate:"required,uuid"`
	Name 		string 	  `json:"name" validate:"required"`
}

type DeleteTodoGroupRequest struct {
	ID          string    `json:"id" validate:"required,uuid"`
}



//? Todo
type Todo struct {
	ID          string    		`json:"id"`
	Title       string    		`json:"title"`
	Description string    		`json:"description"`
	Completed   bool      		`json:"completed"`
	TodoListID	string	  		`json:"todo_list_id"`
    TodoGroupID	sql.NullString	`json:"todo_group_id"`
	CreatedAt   time.Time 		`json:"created_at"`
	UpdatedAt   time.Time 		`json:"updated_at"`
}

type CreateTodoRequest struct {
	Title       string 	  		`json:"title" validate:"required"`
	Description string 	  		`json:"description" validate:"required"`
	TodoListID	string	  		`json:"todo_list_id" validate:"required,uuid"`
	TodoGroupID	sql.NullString 	`json:"todo_group_id"`
}

type ReadTodosRequest struct {
	TodoListID	string	  `json:"todo_list_id" validate:"required,uuid"`
}

type UpdateTodoRequest struct {
	ID          string    		`json:"id" validate:"required,uuid"`
	Title       string    		`json:"title" validate:"required"`
	Description string    		`json:"description" validate:"required"`
	Completed   bool      		`json:"completed" validate:"required"`
	TodoGroupID	sql.NullString	`json:"todo_group_id"`
}

type DeleteTodoRequest struct {
	ID			string 	   `json:"id" validate:"required,uuid"`
}



//? Sub Task
type SubTask struct {
	ID          string    `json:"id"`
	Name		string	  `json:"name"`
	Completed   bool      `json:"completed"`
	TodoID		string	  `json:"todo_id"`
	CreatedAt   time.Time `json:"created_at"`
	UpdatedAt   time.Time `json:"updated_at"`
}

type CreateSubTaskRequest struct {
	Name		string	  `json:"name" validate:"required"`
	TodoID		string	  `json:"todo_id" validate:"required,uuid"`
}

type ReadSubTasksRequest struct {
	TodoID		string	  `json:"todo_id" validate:"required,uuid"`
}

type UpdateSubTaskRequest struct {
	ID          string    `json:"id" validate:"required,uuid"`
	Name		string	  `json:"name" validate:"required"`
	Completed   bool      `json:"completed" validate:"required"`
}

type DeleteSubTaskRequest struct {
	ID          string    `json:"id" validate:"required,uuid"`
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
