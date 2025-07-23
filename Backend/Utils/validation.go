package Utils

import (
	"fmt"
)


const (
	maxTitleLength = 255
	maxDescriptionLength = 1000
)

//? TODO LIST
func (r *CreateTodoListRequest) Validate() error {
	return CheckTitle(r.Title, maxTitleLength)
}

func (r *UpdateTodoListRequest) Validate() error {
	err := CheckID(r.ID)
	if err != nil {
		return err
	}

	return CheckTitle(r.Title, maxTitleLength)
}

func (r *DeleteTodoListRequest) Validate() error {
	return CheckID(r.ID)
}


//? TODO GROUP
func (r *CreateTodoGroupRequest) Validate() error {
	err := CheckID(r.TodoListID)
	if err != nil {
		return err
	}

	return CheckTitle(r.Name, maxTitleLength)
}

func (r *ReadTodoGroupsRequest) Validate() error {
	return CheckID(r.TodoListID)
}

func (r * UpdateTodoGroupRequest) Validate() error {
	err := CheckID(r.ID)
	if err != nil {
		return err
	}

	return CheckTitle(r.Name, maxTitleLength)
}

func (r *DeleteTodoGroupRequest) Validate() error {
	return CheckID(r.ID)
}


//? TODO
func (r *CreateTodoRequest) Validate() error {
	titleErr := CheckTitle(r.Title, maxTitleLength)
	if titleErr != nil {
		return titleErr
	}

	if len(r.Description) > maxDescriptionLength {
		return fmt.Errorf("description must be less than 1000 characters")
	}

	todoListIDErr := CheckID(r.TodoListID)
	if todoListIDErr != nil {
		return todoListIDErr
	}

	return CheckID(r.TodoGroupID)
}

func (r *ReadTodosRequest) Validate() error {
	return CheckID(r.TodoListID)
}

func (r *UpdateTodoRequest) Validate() error {
	idError := CheckID(r.ID)
	if idError != nil {
		return idError
	}

	titleErr := CheckTitle(r.Title, maxTitleLength)
	if titleErr != nil {
		return titleErr
	}

	if len(r.Description) > maxDescriptionLength {
		return fmt.Errorf("description must be less than 1000 characters")
	}

	return CheckID(r.TodoGroupID)
}

func (r *DeleteTodoRequest) Validate() error {
	return CheckID(r.ID)
}



//? SUB TASKS
func (r *CreateSubTaskRequest) Validate() error {
	nameError := CheckTitle(r.Name, maxTitleLength)
	if nameError != nil {
		return nameError
	}
	
	return CheckID(r.TodoID) 
}

func (r *ReadSubTasksRequest) Validate() error {
	return CheckID(r.TodoID)
}

func (r *UpdateSubTaskRequest) Validate() error {
	idError := CheckID(r.ID)
	if idError != nil {
		return idError
	}

	return CheckTitle(r.Name, maxTitleLength)
}

func (r *DeleteSubTaskRequest) Validate() error {
	return CheckID(r.ID)
}