package handlers

import (
	"encoding/json"
	"github.com/go-chi/chi/v5"
	"github.com/konstantinlevin77/solution-challenge/api/config"
	"github.com/konstantinlevin77/solution-challenge/api/helpers"
	"github.com/konstantinlevin77/solution-challenge/api/models"
	"net/http"
)

func AddUserReviewHandler(w http.ResponseWriter, r *http.Request) {

	w.Header().Set("Content-Type", "application/json")
	var ur models.UserReview

	err := json.NewDecoder(r.Body).Decode(&ur)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		_, _ = w.Write(helpers.NewResultJSON(http.StatusBadRequest, err.Error()))
		return
	}

	err = config.App.Repository.AddUserReview(ur)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		_, _ = w.Write(helpers.NewResultJSON(http.StatusBadRequest, err.Error()))
		return
	}

	_, _ = w.Write(helpers.NewResultJSON(http.StatusOK, "Added user review."))

}

func GetUserReviewByIdHandler(w http.ResponseWriter, r *http.Request) {

	id := chi.URLParam(r, "id")
	w.Header().Set("Content-Type", "application/json")

	ur, err := config.App.Repository.GetUserReviewById(id)
	if err != nil {
		w.WriteHeader(http.StatusNotFound)
		_, _ = w.Write(helpers.NewResultJSON(http.StatusNotFound, err.Error()))
		return
	}

	urJSON, err := json.MarshalIndent(ur, "", "  ")
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		_, _ = w.Write(helpers.NewResultJSON(http.StatusBadRequest, err.Error()))
		return
	}

	_, _ = w.Write(urJSON)

}

func GetAllUserReviewsHandler(w http.ResponseWriter, r *http.Request) {

	w.Header().Set("Content-Type", "application/json")
	urList, err := config.App.Repository.GetAllUserReviews()
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		_, _ = w.Write(helpers.NewResultJSON(http.StatusBadRequest, err.Error()))
		return
	}

	urListJSON, err := json.MarshalIndent(urList, "", "  ")
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		_, _ = w.Write(helpers.NewResultJSON(http.StatusBadRequest, err.Error()))
		return
	}

	_, _ = w.Write(urListJSON)

}

func GetUserReviewsByUserIdHandler(w http.ResponseWriter, r *http.Request) {

	id := chi.URLParam(r, "id")
	w.Header().Set("Content-Type", "application/json")
	urList, err := config.App.Repository.GetUserReviewsByUserId(id)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		_, _ = w.Write(helpers.NewResultJSON(http.StatusBadRequest, err.Error()))
		return
	}

	urListJSON, err := json.MarshalIndent(urList, "", "  ")
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		_, _ = w.Write(helpers.NewResultJSON(http.StatusBadRequest, err.Error()))
		return
	}

	_, _ = w.Write(urListJSON)

}

func GetUserReviewsByMenuIdHandler(w http.ResponseWriter, r *http.Request) {

	id := chi.URLParam(r, "id")
	w.Header().Set("Content-Type", "application/json")
	urList, err := config.App.Repository.GetUserReviewsByMenuId(id)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		_, _ = w.Write(helpers.NewResultJSON(http.StatusBadRequest, err.Error()))
		return
	}

	urListJSON, err := json.MarshalIndent(urList, "", "  ")
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		_, _ = w.Write(helpers.NewResultJSON(http.StatusBadRequest, err.Error()))
		return
	}

	_, _ = w.Write(urListJSON)

}

func GetUserReviewsByBusinessIdHandler(w http.ResponseWriter, r *http.Request) {

	id := chi.URLParam(r, "id")
	w.Header().Set("Content-Type", "application/json")
	urList, err := config.App.Repository.GetUserReviewsByBusinessId(id)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		_, _ = w.Write(helpers.NewResultJSON(http.StatusBadRequest, err.Error()))
		return
	}

	urListJSON, err := json.MarshalIndent(urList, "", "  ")
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		_, _ = w.Write(helpers.NewResultJSON(http.StatusBadRequest, err.Error()))
		return
	}

	_, _ = w.Write(urListJSON)

}

func UpdateUserReviewByIdHandler(w http.ResponseWriter, r *http.Request) {

	w.Header().Set("Content-Type", "application/json")
	id := chi.URLParam(r, "id")

	var ur models.UserReview
	err := json.NewDecoder(r.Body).Decode(&ur)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		_, _ = w.Write(helpers.NewResultJSON(http.StatusBadRequest, err.Error()))
		return
	}

	err = config.App.Repository.UpdateUserReviewById(id, ur)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		_, _ = w.Write(helpers.NewResultJSON(http.StatusBadRequest, err.Error()))
		return
	}

	_, _ = w.Write(helpers.NewResultJSON(http.StatusOK, "Updated the user review"))

}

func DeleteUserReviewByIdHandler(w http.ResponseWriter, r *http.Request) {

	w.Header().Set("Content-Type", "application/json")
	id := chi.URLParam(r, "id")

	err := config.App.Repository.DeleteUserReviewById(id)
	if err != nil {
		_, _ = w.Write(helpers.NewResultJSON(http.StatusBadRequest, err.Error()))
		return
	}
	_, _ = w.Write(helpers.NewResultJSON(http.StatusOK, "Deleted the user review."))

}
