package handlers

import (
	"encoding/json"
	"github.com/go-chi/chi/v5"
	"github.com/konstantinlevin77/solution-challange-dummyapi/mockData"
	"net/http"
	"strconv"
)

func GetAllUsersHandler(w http.ResponseWriter, r *http.Request) {

	w.Header().Set("Content-Type", "application/json")
	usersJSON, err := json.MarshalIndent(mockData.NewUsersData(), "", " ")
	if err != nil {
		_, _ = w.Write([]byte("{}"))
		return
	}
	_, _ = w.Write(usersJSON)

}

func GetUserByIdHandler(w http.ResponseWriter, r *http.Request) {

	w.Header().Set("Content-Type", "application/json")

	id, err := strconv.Atoi(chi.URLParam(r, "id"))
	if err != nil {
		_, _ = w.Write([]byte("{}"))
		return
	}

	users := mockData.NewUsersData()

	for _, el := range users {
		if el.Id == id {
			userJSON, _ := json.MarshalIndent(el, "", "  ")
			_, _ = w.Write(userJSON)
			return
		}
	}
	_, _ = w.Write([]byte("{}"))

}

func GetUserByUsernameHandler(w http.ResponseWriter, r *http.Request) {

	w.Header().Set("Content-Type", "application/json")

	uname := chi.URLParam(r, "username")

	users := mockData.NewUsersData()

	for _, el := range users {
		if el.Username == uname {
			userJSON, _ := json.MarshalIndent(el, "", "  ")
			_, _ = w.Write(userJSON)
			return
		}
	}
	_, _ = w.Write([]byte("{}"))

}
