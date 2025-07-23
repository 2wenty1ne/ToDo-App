package Utils

import (
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
	Title 		string	  `json:"title"`
}

type UpdateTodoListRequest struct {
	ID          string    `json:"id"`
	Title 		string	  `json:"title"`
}

type DeleteTodoListRequest struct {
	ID          string    `json:"id"`
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
	Name 		string 	  `json:"name"`
	TodoListID	string	  `json:"todo_list_id"`
}

type ReadTodoGroupsRequest struct {
	TodoListID	string	  `json:"todo_list_id"`
}

type UpdateTodoGroupRequest struct {
	ID          string    `json:"id"`
	Name 		string 	  `json:"name"`
}

type DeleteTodoGroupRequest struct {
	ID          string    `json:"id"`
}



//? Todo
type Todo struct {
	ID          string    `json:"id"`
	Title       string    `json:"title"`
	Description string    `json:"description"`
	Completed   bool      `json:"completed"`
	TodoListID	string	  `json:"todo_list_id"`
	TodoGroupID	string	  `json:"todo_group_id"`
	CreatedAt   time.Time `json:"created_at"`
	UpdatedAt   time.Time `json:"updated_at"`
}

type CreateTodoRequest struct {
	Title       string 	  `json:"title"`
	Description string 	  `json:"description"`
	TodoListID	string	  `json:"todo_list_id"`
	TodoGroupID	string	  `json:"todo_group_id"`
}

type ReadTodosRequest struct {
	TodoListID	string	  `json:"todo_list_id"`
}

type UpdateTodoRequest struct {
	ID          string    `json:"id"`
	Title       string    `json:"title"`
	Description string    `json:"description"`
	Completed   bool      `json:"completed"`
	TodoGroupID	string	  `json:"todo_group_id"`
}

type DeleteTodoRequest struct {
	ID			string 	   `json:"id"`
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
	Name		string	  `json:"name"`
	TodoID		string	  `json:"todo_id"`
}

type ReadSubTasksRequest struct {
	TodoID		string	  `json:"todo_id"`
}

type UpdateSubTaskRequest struct {
	ID          string    `json:"id"`
	Name		string	  `json:"name"`
	Completed   bool      `json:"completed"`
}

type DeleteSubTaskRequest struct {
	ID          string    `json:"id"`
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
