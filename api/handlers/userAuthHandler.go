package handlers

import (
	"encoding/json"
	"github.com/konstantinlevin77/solution-challenge/api/config"
	"github.com/konstantinlevin77/solution-challenge/api/helpers"
	"github.com/konstantinlevin77/solution-challenge/api/models"
	"log"
	"net/http"
)

func UserRegisterHandler(w http.ResponseWriter, r *http.Request) {

	w.Header().Set("Content-Type", "application/json")
	var u models.User
	err := json.NewDecoder(r.Body).Decode(&u)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		_, _ = w.Write(helpers.NewResultJSON(http.StatusBadRequest, "Invalid request payload."))
		return
	}

	u.Password, err = helpers.HashPassword(u.Password)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		_, _ = w.Write(helpers.NewResultJSON(http.StatusBadRequest, "Invalid request payload."))
		return
	}

	if !helpers.IsEmailValid(u.Email) {
		w.WriteHeader(http.StatusBadRequest)
		_, _ = w.Write(helpers.NewResultJSON(http.StatusBadRequest, "Email not valid."))
		return
	}

	err = config.App.Repository.AddUser(u)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		_, _ = w.Write(helpers.NewResultJSON(http.StatusBadRequest, "Invalid request payload."))
		return
	}

	w.WriteHeader(http.StatusCreated)
	_, _ = w.Write(helpers.NewResultJSON(http.StatusCreated, "User is added."))

}

func UserLoginHandler(w http.ResponseWriter, r *http.Request) {
	// Parse request body to get user credentials
	var credentials struct {
		Username string `json:"username"`
		Password string `json:"password"`
	}

	if err := json.NewDecoder(r.Body).Decode(&credentials); err != nil {
		http.Error(w, "Invalid request payload", http.StatusBadRequest)
		return
	}

	// Retrieve the user from the database
	u, err := config.App.Repository.GetUserByUsername(credentials.Username)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		_, _ = w.Write(helpers.NewResultJSON(http.StatusBadRequest, "Invalid username or password."))
		log.Println(err)
		return
	}
	if !helpers.MatchHashAndPassword(credentials.Password, u.Password) {
		w.WriteHeader(http.StatusBadRequest)
		_, _ = w.Write(helpers.NewResultJSON(http.StatusBadRequest, "Invalid username or password."))
		return
	}

	// Generate a JWT token
	token, err := helpers.GenerateToken(u.ID)
	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		log.Println(err)
		_, _ = w.Write(helpers.NewResultJSON(http.StatusInternalServerError, "Token couldn't be generated."))
		return
	}

	// Respond with the token
	w.WriteHeader(http.StatusOK)
	_ = json.NewEncoder(w).Encode(map[string]string{"token": token})
}
