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

	mux.Get("/users/getByUsername/{username}", handlers.GetUserByUsernameHandler)
	mux.Get("/businessAccounts/getByUsername/{username}", handlers.GetBusinessAccountByUsernameHandler)

	mux.Delete("/users/deleteByUsername/{username}", handlers.DeleteUserByUsernameHandler)
	mux.Delete("/businessAccounts/deleteByUsername/{username}", handlers.DeleteBusinessAccountByUsernameHandler)

	mux.Put("/users/updateByUsername/{username}", handlers.UpdateUserByUsernameHandler)
	mux.Put("/businessAccounts/updateByUsername/{username}", handlers.UpdateBusinessAccountByUsernameHandler)

	server := &http.Server{Handler: mux,
		Addr: PORT}

	log.Println("Listening and serving on", PORT)
	err = server.ListenAndServe()
	log.Fatalln(err)

}
