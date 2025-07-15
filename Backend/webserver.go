package main

import (
	"time"

	"github.com/2wenty1ne/ToDo-App/Database"
	"github.com/2wenty1ne/ToDo-App/Utils"

	"github.com/gofiber/fiber/v2"
)



type RequestHandler struct {
	dbService *Database.DBService
}

func newRequestHandler(dbService *Database.DBService) *RequestHandler {
	return &RequestHandler{dbService: dbService}
}


func SetupRoutes(app *fiber.App, dbService *Database.DBService) {	
	requestHandler := newRequestHandler(dbService)

	api := app.Group("/api/v1")

	api.Post("/todos", requestHandler.CreateTodoHandler)
	api.Delete("/todos", requestHandler.DeleteTodoHandler)


	api.Get("/health", func(c *fiber.Ctx) error {
		return c.JSON(fiber.Map{
			"status": "ok",
			"timestamp": time.Now().Unix(),
		})
	})
}


func (h *RequestHandler) sendErrorResponse(c *fiber.Ctx, statusCode int, message string, err error) error {
	response := Utils.APIError{
		Success: false,
		Message: message,
	}

	if err != nil && Utils.GetDevMode() {
		response.Error = err.Error()
	}

	return c.Status(statusCode).JSON(response)
}
