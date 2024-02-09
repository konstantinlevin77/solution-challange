package main

import (
	"github.com/go-chi/chi/v5"
	"github.com/konstantinlevin77/solution-challange-dummyapi/handlers"
	"log"
	"net/http"
)

const PORT = ":8080"

func main() {

	router := chi.NewRouter()

	router.Get("/users/getAll", handlers.GetAllUsersHandler)
	router.Get("/users/getById/{id}", handlers.GetUserByIdHandler)
	router.Get("/users/getByUsername/{username}", handlers.GetUserByUsernameHandler)

	server := &http.Server{Handler: router, Addr: PORT}

	log.Println("Listening and serving on", PORT)
	err := server.ListenAndServe()
	log.Fatal("Couldn't start the server", err)

}
