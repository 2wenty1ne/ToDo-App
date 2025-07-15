package Utils

import (
	"fmt"
	"log"
	"os"
	"strconv"

	"github.com/joho/godotenv"
)

func init() {
	err := godotenv.Load("./../.env")
	if err != nil {
		log.Fatal(err)
	}
}


func GetWebserverPort() string {
	key := "WEBSERVER_PORT"
	return readEnvValue(key, "8080")
}

func GetDBPort() int {
	key := "DB_PORT"
	dbPortString := readEnvValue(key, "5432")
	
	dbPort, err := strconv.Atoi(dbPortString)

	if err != nil {
		log.Fatal(err)
	}

	return dbPort
}

func GetDBHost() string {
	key := "DB_HOST"
    return readEnvValue(key, "localhost")
}

func GetDBUser() string {
	key := "DB_USER"
    return readEnvValue(key, "postgres")
}

func GetDBPassword() string {
	key := "DB_PASSWORD"
    return readEnvValue(key, "", true)
}

func GetDBName() string {
	key := "DB_NAME"
    return readEnvValue(key, "", true)
}

func GetDevMode() bool {
	key := "DEV_MODE"
	devModeString := readEnvValue(key, "false")

	devMode, err := strconv.ParseBool(devModeString)

	if err != nil {
		log.Fatal(err)
	}

	return devMode
}



func readEnvValue(key string, defaultString string, causeCrashPar ...bool) string {
	causeCrash := false
	if len(causeCrashPar) > 0 {
		causeCrash = causeCrashPar[0]
	}

	value := os.Getenv(key)

	if value != "" {
		return value
	}

	if (causeCrash) {
		errorMsg := fmt.Sprintf("Fatal Parameter %s missing", key)
		log.Fatal(errorMsg)
	}

	log.Printf("%s missing, defaulting to %s", key, defaultString)
	return defaultString
}
