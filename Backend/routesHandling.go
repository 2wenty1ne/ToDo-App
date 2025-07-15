package main

import (
	"log"
	"strings"

	"github.com/2wenty1ne/ToDo-App/Utils"

	"github.com/gofiber/fiber/v2"
	"github.com/lib/pq"
)



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
