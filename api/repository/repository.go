package repository

import "github.com/konstantinlevin77/solution-challenge/api/models"

type Repository interface {
	AddUser(u models.User) error
	GetAllUsers() ([]models.User, error)
	GetUserByUsername(username string) (models.User, error)
}
