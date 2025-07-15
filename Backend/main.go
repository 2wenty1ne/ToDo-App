package main

import (
	"log"

	"github.com/2wenty1ne/ToDo-App/Database"
	"github.com/2wenty1ne/ToDo-App/Utils"

	"github.com/gofiber/fiber/v2"
	"github.com/gofiber/fiber/v2/middleware/logger"
	"github.com/gofiber/fiber/v2/middleware/recover"
)



func main() {
	dbService := Database.DBConn()
	defer dbService.CloseDB()


	app := fiber.New(fiber.Config{
		// Optional configurations
		ErrorHandler: func(c *fiber.Ctx, err error) error {
			// Custom error handler
			code := fiber.StatusInternalServerError
			if e, ok := err.(*fiber.Error); ok {
				code = e.Code
			}
			
			return c.Status(code).JSON(Utils.APIError{
				Success: false,
				Message: err.Error(),
			})
		},
		BodyLimit: 1024 * 1024, // 1MB limit
	})

	app.Use(logger.New())
	app.Use(recover.New())

	SetupRoutes(app, dbService)


	port := Utils.GetWebserverPort()

	log.Printf("Webserver listening on port %s", port)
	log.Fatal(app.Listen(":" + port))
}
