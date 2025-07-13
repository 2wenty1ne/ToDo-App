package main

import (
	"log"

	"github.com/2wenty1ne/ToDo-App/Config"

	"github.com/gofiber/fiber/v2"
)

func main() {
	//? SETUP
	db := Config.DBConn()
	defer Config.CloseDB(db)
	

	port := Config.GetWebserverPort()

	app := fiber.New()


	// //? ROUTES
	app.Get("/", func(c *fiber.Ctx) error {
		return c.SendString("Hello, World!")
	})

	log.Printf("Webserver listening on port %s", port)
	app.Listen(":" + port)
}
