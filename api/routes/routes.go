package routes

import (
	"github.com/go-chi/chi/v5"
	"github.com/konstantinlevin77/solution-challenge/api/handlers"
	"github.com/konstantinlevin77/solution-challenge/api/middlewares"
)

func NewRoutes() *chi.Mux {
	mux := chi.NewRouter()

	mux.Route("/protected", func(r chi.Router) {
		r.Use(middlewares.AuthMiddleware)
		r.Post("/menus/add", handlers.AddMenuHandler)
		r.Post("/userReviews/add", handlers.AddUserReviewHandler)

		r.Get("/users/getById/{id}", handlers.GetUserByIdHandler)
		r.Get("/businessAccounts/getById/{id}", handlers.GetBusinessAccountByIdHandler)
		r.Get("/menus/getById/{id}", handlers.GetMenuByIdHandler)
		r.Get("/menus/getAllByBusinessId/{id}", handlers.GetAllMenusByBusinessIdHandler)
		r.Get("/menus/getGlutenFreeByBusinessId/{id}", handlers.GetGlutenFreeMenusByBusinessIdHandler)
		r.Get("/userReviews/getById/{id}", handlers.GetUserReviewByIdHandler)
		r.Get("/userReviews/getAll", handlers.GetAllUserReviewsHandler)
		r.Get("/userReviews/getByUserId/{id}", handlers.GetUserReviewsByUserIdHandler)
		r.Get("/userReviews/getByMenuId/{id}", handlers.GetUserReviewsByMenuIdHandler)
		r.Get("/userReviews/getByBusinessId/{id}", handlers.GetUserReviewsByBusinessIdHandler)

		r.Delete("/users/deleteById/{id}", handlers.DeleteUserByIdHandler)
		r.Delete("/businessAccounts/deleteById/{id}", handlers.DeleteBusinessAccountByIdHandler)
		r.Delete("/menus/deleteById/{id}", handlers.DeleteMenuByIdHandler)
		r.Delete("/userReviews/deleteById/{id}", handlers.DeleteUserReviewByIdHandler)

		r.Put("/users/updateById/{id}", handlers.UpdateUserByIdHandler)
		r.Put("/businessAccounts/updateById/{id}", handlers.UpdateBusinessAccountByIdHandler)
		r.Put("/menus/updateById/{id}", handlers.UpdateMenuByIdHandler)
		r.Put("/userReviews/updateById/{id}", handlers.UpdateUserReviewByIdHandler)
	})

	mux.Route("/auth", func(r chi.Router) {
		r.Post("/registerUser", handlers.UserRegisterHandler)
		r.Post("/loginUser", handlers.UserLoginHandler)
		r.Post("/registerBusinessAccount", handlers.BusinessAccountRegisterHandler)
		r.Post("/loginBusinessAccount", handlers.BusinessAccountLoginHandler)
	})

	return mux
}
