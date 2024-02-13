package config

import (
	"github.com/konstantinlevin77/solution-challenge/api/repository/firestoreRepo"
)

var App *AppConfig

func NewApp(repo *firestoreRepo.FirestoreRepository) {
	App = &AppConfig{Repository: repo}
}

type AppConfig struct {
	Repository *firestoreRepo.FirestoreRepository
}
