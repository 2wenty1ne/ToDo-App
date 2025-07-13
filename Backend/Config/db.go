package Config

import (
	"database/sql"
	"fmt"
	"log"

	_ "github.com/lib/pq"
)

var (
    host     string
    port     int
    user     string
    password string
    dbname   string
)

func DBConn() *sql.DB {
	host     = GetDBHost()
    port     = GetDBPort()
    user     = GetDBUser()
    password = GetDBPassword()
    dbname   = GetDBName()

	psqlconn := fmt.Sprintf("host=%s port=%d user=%s password=%s dbname=%s sslmode=disable", host, port, user, password, dbname)

	db, err := sql.Open("postgres", psqlconn)
	CheckError(err)


	err = db.Ping()
	CheckError(err)


	log.Printf("Connection to Database established")
	
	return db
}

func CloseDB(db *sql.DB) {
	log.Printf("Closing connection to Database")
	db.Close()
}
