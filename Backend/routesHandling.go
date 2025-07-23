package main

import (
	"fmt"
	"log"
	"strings"

	"github.com/2wenty1ne/ToDo-App/Utils"

	"github.com/gofiber/fiber/v2"
	"github.com/lib/pq"
)


func (h *RequestHandler) CreateTodoListHandler(c *fiber.Ctx) error {
	var req Utils.CreateTodoListRequest

	if err := c.BodyParser(&req); err != nil {
		return h.sendErrorResponse(c, fiber.StatusBadRequest, "Inavlid JSON format", err)
	}

	if err := req.Validate(); err != nil {
		return h.sendErrorResponse(c, fiber.StatusBadRequest, "Validation failed", err)
	}

	todoList, err := h.dbService.CreateTodoList(&req)
	if err != nil {
		if pqErr, ok := err.(*pq.Error); ok {
			switch pqErr.Code {
				case "23505": // unique_violation
					return h.sendErrorResponse(c, fiber.StatusConflict, "todoList already exists", err)
				case "23502": // not_null_violation
					return h.sendErrorResponse(c, fiber.StatusBadRequest, "Required field missing", err)
			}
		}

		//? Other Errors
		log.Printf("Database error creating todoList: %v", err)
		return h.sendErrorResponse(c, fiber.StatusInternalServerError, "Failed to create todoList", nil)
	}


	response := Utils.APIResponse{
		Success: true,
		Message: "TodoList created successfully",
		Data: todoList,
	}

	return c.Status(fiber.StatusCreated).JSON(response)
}


func (h *RequestHandler) ReadTodoListsHandler(c *fiber.Ctx) error {
	todoLists, err := h.dbService.ReadTodoLists()
	if err != nil {
		log.Printf("Database error reading todoList: %v", err)
		return h.sendErrorResponse(c, fiber.StatusInternalServerError, "Failed to create todoList", nil)
	}

	response := Utils.APIResponse{
		Success: true,
		Message: fmt.Sprintf("Retrieved %d todoLists", len(todoLists)),
		Data: todoLists,
	}

	return c.Status(fiber.StatusOK).JSON(response)
}


func (h *RequestHandler) UpdateTodoListHandler(c *fiber.Ctx) error {
	var req Utils.UpdateTodoListRequest

	if err := c.BodyParser(&req); err != nil {
		return h.sendErrorResponse(c, fiber.StatusBadRequest, "Inavlid JSON format", err)
	}

	if err := req.Validate(); err != nil {
		return h.sendErrorResponse(c, fiber.StatusBadRequest, "Validation failed", err)
	}


	todoList, err := h.dbService.UpdateTodoList(&req)
	if err != nil {
		//? DB Errors
		switch err.(*pq.Error).Code {
			case "23502": // not_null_violation
				return h.sendErrorResponse(c, fiber.StatusBadRequest, "Required field cannot be null", err)
			
			case "23505": // unique_violation
				return h.sendErrorResponse(c, fiber.StatusConflict, "Todo with this id already exists", err)
			
			case "22001": // string_data_right_truncation
				return h.sendErrorResponse(c, fiber.StatusBadRequest, "Title too long for database field", err)
			
			case "42703": // undefined_column (rare, but if column names are dynamic)
				return h.sendErrorResponse(c, fiber.StatusInternalServerError, "Database schema error", err)
			}
		
		//? Other Errors
		log.Printf("Database error creating todoList: %v", err)
		return h.sendErrorResponse(c, fiber.StatusInternalServerError, "Failed to create todoList", nil)
	}


	response := Utils.APIResponse{
		Success: true,
		Message: "Updated todoList successfully",
		Data: todoList,
	}

	return c.Status(fiber.StatusOK).JSON(response)
}


func (h* RequestHandler) DeleteTodoListHandler(c *fiber.Ctx) error {
	var req Utils.DeleteTodoListRequest

	if err := c.BodyParser(&req); err != nil {
		return h.sendErrorResponse(c, fiber.StatusBadRequest, "Inavlid JSON format", err)
	}

	if err := req.Validate(); err != nil {
		return h.sendErrorResponse(c, fiber.StatusBadRequest, "Validation failed", err)
	}


	err := h.dbService.DeleteTodoList(&req)
	if err != nil {
		if strings.Contains(err.Error(), "not found") {
			return h.sendErrorResponse(c, fiber.StatusNotFound, "TodoList not found", err)
		}

		log.Printf("Database error deleting todo: %v", err)
		return h.sendErrorResponse(c, fiber.StatusInternalServerError, "Failed to delete todoList", nil)
	}

	response := Utils.APIResponse{
		Success: true,
		Message: "Deleted todoList successfully",
	}

	return c.Status(fiber.StatusOK).JSON(response)
}





func (h *RequestHandler) CreateTodoHandler(c *fiber.Ctx) error {
	var req Utils.CreateTodoRequest

	if err := c.BodyParser(&req); err != nil {
		return h.sendErrorResponse(c, fiber.StatusBadRequest, "Invalid JSON format", err)
	}

	if err := req.Validate(); err != nil {
		return h.sendErrorResponse(c, fiber.StatusBadRequest, "Validation failed", err)
	}


	todo, err := h.dbService.CreateTodo(&req)
	if err != nil {
		//? DB Errors
		if pqErr, ok := err.(*pq.Error); ok {
			switch pqErr.Code {
				case "23505": // unique_violation
					return h.sendErrorResponse(c, fiber.StatusConflict, "Todo already exists", err)
				case "23502": // not_null_violation
					return h.sendErrorResponse(c, fiber.StatusBadRequest, "Required field missing", err)
			}
		}

		//? Other Errors
		log.Printf("Database error creating todo: %v", err)
		return h.sendErrorResponse(c, fiber.StatusInternalServerError, "Failed to create todo", nil)
	}


	response := Utils.APIResponse{
		Success: true,
		Message: "Todo created successfully",
		Data: todo,
	}

	return c.Status(fiber.StatusCreated).JSON(response)
}


func (h *RequestHandler) DeleteTodoHandler(c *fiber.Ctx) error {
	var req Utils.DeleteTodoRequest

	if err := c.BodyParser(&req); err != nil {
		return h.sendErrorResponse(c, fiber.StatusBadRequest, "Invalid JSON format", err)
	}

	if err := req.Validate(); err != nil {
		return h.sendErrorResponse(c, fiber.StatusBadRequest, "Validation failed", err)
	}

	err := h.dbService.DeleteTodo(&req)
	if err != nil {
		if strings.Contains(err.Error(), "not found") {
			return h.sendErrorResponse(c, fiber.StatusNotFound, "Todo not found", err)
		}

		log.Printf("Database error deleting todo: %v", err)
		return h.sendErrorResponse(c, fiber.StatusInternalServerError, "Failed to delete todo", nil)
	}

	response := Utils.APIResponse{
		Success: true,
		Message: "Todo deleted successfully",
	}

	return c.Status(fiber.StatusOK).JSON(response)
}
