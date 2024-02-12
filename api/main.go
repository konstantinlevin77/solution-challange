package main

import (
	"github.com/go-chi/chi/v5"
	"github.com/konstantinlevin77/solution-challenge/api/config"
	"github.com/konstantinlevin77/solution-challenge/api/handlers"
	"github.com/konstantinlevin77/solution-challenge/api/repository/firestoreRepo"
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

	mux := chi.NewRouter()

	mux.Get("/users/getById/{id}", handlers.GetUserByIdHandler)
	mux.Get("/businessAccounts/getById/{id}", handlers.GetBusinessAccountByIdHandler)

	mux.Delete("/users/deleteById/{id}", handlers.DeleteUserByIdHandler)
	mux.Delete("/businessAccounts/deleteById/{id}", handlers.DeleteBusinessAccountByIdHandler)

	mux.Put("/users/updateById/{id}", handlers.UpdateUserByIdHandler)
	mux.Put("/businessAccounts/updateById/{id}", handlers.UpdateBusinessAccountByIdHandler)

	server := &http.Server{Handler: mux,
		Addr: PORT}

	log.Println("Listening and serving on", PORT)
	err = server.ListenAndServe()
	log.Fatalln(err)

}
