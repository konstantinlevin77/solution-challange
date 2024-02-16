package main

import (
	"github.com/joho/godotenv"
	"github.com/konstantinlevin77/solution-challenge/api/config"
	"github.com/konstantinlevin77/solution-challenge/api/repository/firestoreRepo"
	"github.com/konstantinlevin77/solution-challenge/api/routes"
	"log"
	"net/http"
)

const PORT = ":8080"

func main() {

	repo, err := firestoreRepo.NewFirestoreRepository()
	if err != nil {
		log.Fatalln("Error while initializing firestore repo", err)
	}

	config.NewApp(repo)
	err = godotenv.Load()
	if err != nil {
		log.Fatalln(err.Error())
	}

	mux := routes.NewRoutes()

	server := &http.Server{Handler: mux,
		Addr: PORT}

	log.Println("Listening and serving on", PORT)
	err = server.ListenAndServe()
	log.Fatalln(err)

}
