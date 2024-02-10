package config

import "github.com/konstantinlevin77/solution-challenge/api/repository"

var App *AppConfig

func NewApp(repo *repository.FirestoreRepository) {
	App = &AppConfig{Repository: repo}
}

type AppConfig struct {
	Repository *repository.FirestoreRepository
}
