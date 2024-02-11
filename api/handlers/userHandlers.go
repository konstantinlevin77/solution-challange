package handlers

import (
	"encoding/json"
	"github.com/go-chi/chi/v5"
	"github.com/konstantinlevin77/solution-challenge/api/config"
	"github.com/konstantinlevin77/solution-challenge/api/helpers"
	"github.com/konstantinlevin77/solution-challenge/api/models"
	"net/http"
)

func GetUserByUsernameHandler(w http.ResponseWriter, r *http.Request) {

	username := chi.URLParam(r, "username")
	w.Header().Set("Content-Type", "application/json")

	u, err := config.App.Repository.GetUserByUsername(username)
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

func DeleteUserByUsernameHandler(w http.ResponseWriter, r *http.Request) {

	w.Header().Set("Content-Type", "application/json")
	username := chi.URLParam(r, "username")

	err := config.App.Repository.DeleteUserByUsername(username)
	if err != nil {
		_, _ = w.Write(helpers.NewResultJSON(http.StatusBadRequest, err.Error()))
		return
	}
	_, _ = w.Write(helpers.NewResultJSON(http.StatusOK, "Deleted the user."))

}

func UpdateUserByUsernameHandler(w http.ResponseWriter, r *http.Request) {

	w.Header().Set("Content-Type", "application/json")
	username := chi.URLParam(r, "username")

	var u models.User
	err := json.NewDecoder(r.Body).Decode(&u)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		_, _ = w.Write(helpers.NewResultJSON(http.StatusBadRequest, err.Error()))
		return
	}

	err = config.App.Repository.UpdateUserByUsername(username, u)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		_, _ = w.Write(helpers.NewResultJSON(http.StatusBadRequest, err.Error()))
		return
	}

	_, _ = w.Write(helpers.NewResultJSON(http.StatusOK, "Updated the user"))

}
