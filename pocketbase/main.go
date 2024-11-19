package main

import (
	"log"
	"net/http"
	"os"

	"github.com/labstack/echo/v5"

	"github.com/pocketbase/pocketbase"
	"github.com/pocketbase/pocketbase/apis"
	"github.com/pocketbase/pocketbase/core"
	"github.com/pocketbase/pocketbase/plugins/jsvm"

	"pocketbase/database"
)

func main() {
	// Extract environment variables
	HELLO_WORLD_RESPONSE := os.Getenv("HELLO_WORLD_RESPONSE")
	if HELLO_WORLD_RESPONSE == "" {
		log.Fatal("HELLO_WORLD_RESPONSE is not set")
	}

	// Create PocketBase
	app := pocketbase.New()

	// Activate js hooks
	jsvm.MustRegister(app, jsvm.Config{
		HooksWatch:    true,
		HooksPoolSize: 25,
	})

	// Serves static files from the provided public dir (if exists)
	app.OnBeforeServe().Add(func(e *core.ServeEvent) error {
		e.Router.GET("/*", apis.StaticDirectoryHandler(os.DirFS("./pb_public"), true))
		return nil
	})

	// Implements init database
	app.OnAfterBootstrap().Add(func(e *core.BootstrapEvent) error {
		db := database.New(app)
		err := db.Seed()
		if err != nil {
			log.Fatalf("Error during database seeding: %v", err)
		}
		return nil
	})

	// Create routes
	app.OnBeforeServe().Add(func(e *core.ServeEvent) error {
		e.Router.GET("/api/helloworld", func(c echo.Context) error {
			return c.JSON(http.StatusOK, HELLO_WORLD_RESPONSE)
		})

		e.Router.GET("/api/hello/:id", func(c echo.Context) error {
			id := c.PathParam("id")
			if id == "" {
				return apis.NewBadRequestError("id is required", nil)
			}

			user, err := app.Dao().FindRecordById("users", id)
			if err != nil {
				return apis.NewNotFoundError("User not found", err)
			}

			name, ok := user.Get("name").(string)
			if !ok {
				return apis.NewBadRequestError("response must be a string", nil)
			}

			return c.JSON(http.StatusOK, name+", "+HELLO_WORLD_RESPONSE)
		}, apis.RequireAdminAuth())

		return nil
	})

	// Start the app
	if err := app.Start(); err != nil {
		log.Fatal(err)
	}
}
