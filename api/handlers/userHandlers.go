package handlers

import (
	"encoding/json"
	"github.com/go-chi/chi/v5"
	"github.com/konstantinlevin77/solution-challenge/api/config"
	"github.com/konstantinlevin77/solution-challenge/api/helpers"
	"github.com/konstantinlevin77/solution-challenge/api/models"
	"net/http"
)

func GetUserByIdHandler(w http.ResponseWriter, r *http.Request) {

	id := chi.URLParam(r, "id")
	w.Header().Set("Content-Type", "application/json")

	u, err := config.App.Repository.GetUserById(id)
	if err != nil {
		w.WriteHeader(http.StatusNotFound)
		_, _ = w.Write(helpers.NewResultJSON(http.StatusNotFound, err.Error()))
		return
	}

	uJSON, err := json.MarshalIndent(u, "", "  ")
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		_, _ = w.Write(helpers.NewResultJSON(http.StatusBadRequest, err.Error()))
		return
	}

	_, _ = w.Write(uJSON)

}

func DeleteUserByIdHandler(w http.ResponseWriter, r *http.Request) {

	w.Header().Set("Content-Type", "application/json")
	id := chi.URLParam(r, "id")

	err := config.App.Repository.DeleteUserById(id)
	if err != nil {
		_, _ = w.Write(helpers.NewResultJSON(http.StatusBadRequest, err.Error()))
		return
	}
	_, _ = w.Write(helpers.NewResultJSON(http.StatusOK, "Deleted the user."))

}

func UpdateUserByIdHandler(w http.ResponseWriter, r *http.Request) {

	w.Header().Set("Content-Type", "application/json")
	id := chi.URLParam(r, "id")

	var u models.User
	err := json.NewDecoder(r.Body).Decode(&u)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		_, _ = w.Write(helpers.NewResultJSON(http.StatusBadRequest, err.Error()))
		return
	}

	err = config.App.Repository.UpdateUserById(id, u)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		_, _ = w.Write(helpers.NewResultJSON(http.StatusBadRequest, err.Error()))
		return
	}

	_, _ = w.Write(helpers.NewResultJSON(http.StatusOK, "Updated the user"))

}
