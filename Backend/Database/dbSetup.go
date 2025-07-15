package Database

import (
	"database/sql"
	"fmt"
	"log"

	"github.com/2wenty1ne/ToDo-App/Utils"

	_ "github.com/lib/pq"
)

type DBService struct {
	db *sql.DB
}

var (
    host     string
    port     int
    user     string
    password string
    dbname   string
)

func DBConn() *DBService {
	host     = Utils.GetDBHost()
    port     = Utils.GetDBPort()
    user     = Utils.GetDBUser()
    password = Utils.GetDBPassword()
    dbname   = Utils.GetDBName()

	psqlconn := fmt.Sprintf("host=%s port=%d user=%s password=%s dbname=%s sslmode=disable", host, port, user, password, dbname)

	db, err := sql.Open("postgres", psqlconn)
	Utils.CheckError(err)


	err = db.Ping()
	Utils.CheckError(err)


	log.Printf("Connection to Database established")
	
	return &DBService{db: db}
}

func (r *DBService) CloseDB() {
	log.Printf("Closing connection to Database")
	r.db.Close()
}
