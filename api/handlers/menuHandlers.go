package handlers

import (
	"encoding/json"
	"github.com/go-chi/chi/v5"
	"github.com/konstantinlevin77/solution-challenge/api/config"
	"github.com/konstantinlevin77/solution-challenge/api/helpers"
	"github.com/konstantinlevin77/solution-challenge/api/models"
	"net/http"
)

func AddMenuHandler(w http.ResponseWriter, r *http.Request) {

	w.Header().Set("Content-Type", "application/json")
	var m models.Menu

	err := json.NewDecoder(r.Body).Decode(&m)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		_, _ = w.Write(helpers.NewResultJSON(http.StatusBadRequest, err.Error()))
		return
	}

	err = config.App.Repository.AddMenu(m)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		_, _ = w.Write(helpers.NewResultJSON(http.StatusBadRequest, err.Error()))
		return
	}

	_, _ = w.Write(helpers.NewResultJSON(http.StatusOK, "Added menu."))

}

func GetMenuByIdHandler(w http.ResponseWriter, r *http.Request) {

	w.Header().Set("Content-Type", "application/json")
	id := chi.URLParam(r, "id")
	m, err := config.App.Repository.GetMenuById(id)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		_, _ = w.Write(helpers.NewResultJSON(http.StatusBadRequest, err.Error()))
		return
	}
	mJSON, err := json.MarshalIndent(m, "", "  ")
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		_, _ = w.Write(helpers.NewResultJSON(http.StatusBadRequest, err.Error()))
		return
	}
	_, _ = w.Write(mJSON)
}

func GetAllMenusByBusinessIdHandler(w http.ResponseWriter, r *http.Request) {

	w.Header().Set("Content-Type", "application/json")
	id := chi.URLParam(r, "id")
	m, err := config.App.Repository.GetAllMenusByBusinessId(id)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		_, _ = w.Write(helpers.NewResultJSON(http.StatusBadRequest, err.Error()))
		return
	}
	mJSON, err := json.MarshalIndent(m, "", "  ")
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		_, _ = w.Write(helpers.NewResultJSON(http.StatusBadRequest, err.Error()))
		return
	}
	_, _ = w.Write(mJSON)

}

func GetGlutenFreeMenusByBusinessIdHandler(w http.ResponseWriter, r *http.Request) {

	w.Header().Set("Content-Type", "application/json")
	id := chi.URLParam(r, "id")
	m, err := config.App.Repository.GetGlutenFreeMenusByBusinessId(id)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		_, _ = w.Write(helpers.NewResultJSON(http.StatusBadRequest, err.Error()))
		return
	}
	mJSON, err := json.MarshalIndent(m, "", "  ")
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		_, _ = w.Write(helpers.NewResultJSON(http.StatusBadRequest, err.Error()))
		return
	}
	_, _ = w.Write(mJSON)

}

func UpdateMenuByIdHandler(w http.ResponseWriter, r *http.Request) {

	w.Header().Set("Content-Type", "application/json")
	id := chi.URLParam(r, "id")
	var m models.Menu

	err := json.NewDecoder(r.Body).Decode(&m)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		_, _ = w.Write(helpers.NewResultJSON(http.StatusBadRequest, err.Error()))
		return
	}

	err = config.App.Repository.UpdateMenuById(id, m)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		_, _ = w.Write(helpers.NewResultJSON(http.StatusBadRequest, err.Error()))
		return
	}

	_, _ = w.Write(helpers.NewResultJSON(http.StatusOK, "Updated menu."))

}

func DeleteMenuByIdHandler(w http.ResponseWriter, r *http.Request) {

	w.Header().Set("Content-Type", "application/json")
	id := chi.URLParam(r, "id")

	err := config.App.Repository.DeleteMenuById(id)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		_, _ = w.Write(helpers.NewResultJSON(http.StatusBadRequest, err.Error()))
		return
	}

	_, _ = w.Write(helpers.NewResultJSON(http.StatusOK, "Deleted menu."))

}
