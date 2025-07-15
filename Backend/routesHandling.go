package main

import (
	"log"

	"github.com/2wenty1ne/ToDo-App/Utils"

	"github.com/lib/pq"
	"github.com/gofiber/fiber/v2"
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
