package main

import (
	"github.com/go-chi/chi/v5"
	"github.com/konstantinlevin77/solution-challenge/api/config"
	"github.com/konstantinlevin77/solution-challenge/api/repository"
	"log"
	"net/http"
)

const PORT = ":8080"

func main() {

	repo, err := repository.NewFirestoreRepository()
	if err != nil {
		log.Fatalln("Error while initializing firestore repo", err)
	}

	config.NewApp(repo)
	mux := chi.NewRouter()

	server := &http.Server{Handler: mux,
		Addr: PORT}

	log.Println("Listening and serving on", PORT)
	err = server.ListenAndServe()
	log.Fatalln(err)

}
