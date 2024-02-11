package handlers

import (
	"encoding/json"
	"github.com/go-chi/chi/v5"
	"github.com/konstantinlevin77/solution-challenge/api/config"
	"github.com/konstantinlevin77/solution-challenge/api/helpers"
	"github.com/konstantinlevin77/solution-challenge/api/models"
	"net/http"
)

func GetBusinessAccountByUsernameHandler(w http.ResponseWriter, r *http.Request) {

	username := chi.URLParam(r, "username")

	ba, err := config.App.Repository.GetBusinessAccountByUsername(username)
	if err != nil {
		w.WriteHeader(http.StatusNotFound)
		_, _ = w.Write(helpers.NewResultJSON(http.StatusNotFound, err.Error()))
		return
	}

	baJSON, err := json.MarshalIndent(ba, "", "  ")
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		_, _ = w.Write(helpers.NewResultJSON(http.StatusBadRequest, err.Error()))
		return
	}

	w.Header().Set("Content-Type", "application/json")
	_, _ = w.Write(baJSON)

}

func DeleteBusinessAccountByUsernameHandler(w http.ResponseWriter, r *http.Request) {

	w.Header().Set("Content-Type", "application/json")
	username := chi.URLParam(r, "username")

	err := config.App.Repository.DeleteBusinessAccountByUsername(username)
	if err != nil {
		_, _ = w.Write(helpers.NewResultJSON(http.StatusBadRequest, err.Error()))
		return
	}
	_, _ = w.Write(helpers.NewResultJSON(http.StatusOK, "Deleted the business account."))

}

func UpdateBusinessAccountByUsernameHandler(w http.ResponseWriter, r *http.Request) {

	w.Header().Set("Content-Type", "application/json")
	username := chi.URLParam(r, "username")

	var ba models.BusinessAccount
	err := json.NewDecoder(r.Body).Decode(&ba)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		_, _ = w.Write(helpers.NewResultJSON(http.StatusBadRequest, err.Error()))
		return
	}

	err = config.App.Repository.UpdateBusinessAccountByUsername(username, ba)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		_, _ = w.Write(helpers.NewResultJSON(http.StatusBadRequest, err.Error()))
		return
	}

	_, _ = w.Write(helpers.NewResultJSON(http.StatusOK, "Updated the business account"))

}
