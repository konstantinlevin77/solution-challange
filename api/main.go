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

	mux.Post("/menus/add", handlers.AddMenuHandler)
	mux.Post("/userReviews/add", handlers.AddUserReviewHandler)

	mux.Get("/users/getById/{id}", handlers.GetUserByIdHandler)
	mux.Get("/businessAccounts/getById/{id}", handlers.GetBusinessAccountByIdHandler)
	mux.Get("/menus/getById/{id}", handlers.GetMenuByIdHandler)
	mux.Get("/menus/getAllByBusinessId/{id}", handlers.GetAllMenusByBusinessIdHandler)
	mux.Get("/menus/getGlutenFreeByBusinessId/{id}", handlers.GetGlutenFreeMenusByBusinessIdHandler)
	mux.Get("/userReviews/getById/{id}", handlers.GetUserReviewByIdHandler)
	mux.Get("/userReviews/getAll", handlers.GetAllUserReviewsHandler)
	mux.Get("/userReviews/getByUserId/{id}", handlers.GetUserReviewsByUserIdHandler)
	mux.Get("/userReviews/getByMenuId/{id}", handlers.GetUserReviewsByMenuIdHandler)
	mux.Get("/userReviews/getByBusinessId/{id}", handlers.GetUserReviewsByBusinessIdHandler)

	mux.Delete("/users/deleteById/{id}", handlers.DeleteUserByIdHandler)
	mux.Delete("/businessAccounts/deleteById/{id}", handlers.DeleteBusinessAccountByIdHandler)
	mux.Delete("/menus/deleteById/{id}", handlers.DeleteMenuByIdHandler)
	mux.Delete("/userReviews/deleteById/{id}", handlers.DeleteUserReviewByIdHandler)

	mux.Put("/users/updateById/{id}", handlers.UpdateUserByIdHandler)
	mux.Put("/businessAccounts/updateById/{id}", handlers.UpdateBusinessAccountByIdHandler)
	mux.Put("/menus/updateById/{id}", handlers.UpdateMenuByIdHandler)
	mux.Put("/userReviews/updateById/{id}", handlers.UpdateUserReviewByIdHandler)

	server := &http.Server{Handler: mux,
		Addr: PORT}

	log.Println("Listening and serving on", PORT)
	err = server.ListenAndServe()
	log.Fatalln(err)

}
