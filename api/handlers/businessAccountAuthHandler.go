package handlers

import (
	"encoding/json"
	"github.com/konstantinlevin77/solution-challenge/api/config"
	"github.com/konstantinlevin77/solution-challenge/api/helpers"
	"github.com/konstantinlevin77/solution-challenge/api/models"
	"log"
	"net/http"
)

func BusinessAccountRegisterHandler(w http.ResponseWriter, r *http.Request) {

	w.Header().Set("Content-Type", "application/json")
	var ba models.BusinessAccount
	err := json.NewDecoder(r.Body).Decode(&ba)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		_, _ = w.Write(helpers.NewResultJSON(http.StatusBadRequest, "Invalid request payload."))
		return
	}

	ba.Password, err = helpers.HashPassword(ba.Password)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		_, _ = w.Write(helpers.NewResultJSON(http.StatusBadRequest, "Invalid request payload."))
		return
	}

	if !helpers.IsEmailValid(ba.Email) {
		w.WriteHeader(http.StatusBadRequest)
		_, _ = w.Write(helpers.NewResultJSON(http.StatusBadRequest, "Email not valid."))
		return
	}

	if config.App.Repository.BusinessAccountDoesUsernameExist(ba.Username) {
		w.WriteHeader(http.StatusBadRequest)
		_, _ = w.Write(helpers.NewResultJSON(http.StatusBadRequest, "Username is taken."))
		return
	}

	err = config.App.Repository.AddBusinessAccount(ba)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		_, _ = w.Write(helpers.NewResultJSON(http.StatusBadRequest, "Invalid request payload."))
		return
	}

	w.WriteHeader(http.StatusCreated)
	_, _ = w.Write(helpers.NewResultJSON(http.StatusCreated, "Business account is added."))

}

func BusinessAccountLoginHandler(w http.ResponseWriter, r *http.Request) {

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
	b, err := config.App.Repository.GetBusinessAccountByUsername(credentials.Username)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		_, _ = w.Write(helpers.NewResultJSON(http.StatusBadRequest, "Invalid username or password."))
		log.Println(err)
		return
	}
	if !helpers.MatchHashAndPassword(credentials.Password, b.Password) {
		w.WriteHeader(http.StatusBadRequest)
		_, _ = w.Write(helpers.NewResultJSON(http.StatusBadRequest, "Invalid username or password."))
		return
	}

	// Generate a JWT token
	token, err := helpers.GenerateToken("business_account", b.ID)
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
