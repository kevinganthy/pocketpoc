package database

import (
	"log"
	"os"
	
	"github.com/pocketbase/pocketbase"
)


type DB struct {
	Pocketbase *pocketbase.PocketBase
}

func New(app *pocketbase.PocketBase) (*DB) {
	return &DB{
		Pocketbase: app,
	}
}

func (db *DB) Seed() error {
	res := db.isEmptyDatabase()
	if !res {
		return nil
	}
	log.Println("Database is empty, seeding...")

	// Read the init.sql file
	file, err := os.ReadFile("./init.sql")
	if err != nil {
		log.Println("Bypass init sql, no file not found")
		return nil
	}

	err = db.dropSystemTables()
	if err != nil {
		log.Fatalf("Error while dropping system tables : %v", err)
	}

	// Seed the database
	err = db.executeSeed(string(file))
	if err != nil {
		log.Fatalf("Error while seeding the database : %v", err)
	} else {
		log.Println("Database seeded")
	}
	
	return nil
}

func (db *DB) isEmptyDatabase() bool {
	// Check if system table  _admins exists
	tables := []struct {
		Name string `json:"name"`
	}{}

	err := db.Pocketbase.Dao().DB().
		NewQuery("SELECT name FROM sqlite_schema WHERE type ='table' AND name = '_admins';").
		All(&tables)
	if err != nil {
		log.Fatalf("Error while checking if database is empty : %v", err)
	}
	if (len(tables) == 0) {
		return true
	}
		
	// Check if table _admins is empty
	admins := []struct {
		Email string `json:"email"`
	}{}
	
	err = db.Pocketbase.Dao().DB().
		NewQuery("SELECT email FROM _admins").
		All(&admins)
	if err != nil {
		log.Fatalf("Error while checking if database is empty : %v", err)
	}

	if len(admins) > 0 {
		return false
	}
	return true
}

func (db *DB) dropSystemTables() error {
	_, err := db.Pocketbase.Dao().DB().
		NewQuery("DROP TABLE IF EXISTS _admins; DROP TABLE IF EXISTS _migration; DROP TABLE IF EXISTS _collection; DROP TABLE IF EXISTS _params").
		Execute()
	return err
}

func (db *DB) executeSeed(query string) error {
	_, err := db.Pocketbase.Dao().DB().
		NewQuery(query).
		Execute()
		
	return err
}