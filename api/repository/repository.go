package repository

import "github.com/konstantinlevin77/solution-challenge/api/models"

type Repository interface {
	AddUser(u models.User) error
	GetAllUsers() ([]models.User, error)
	GetUserByUsername(username string) (models.User, error)
	DeleteUserByUsername(username string) error
	UpdateUserByUsername(username string, updatedUser models.User) error

	AddBusinessAccount(b models.BusinessAccount) error
	GetAllBusinessAccounts() ([]models.BusinessAccount, error)
	GetBusinessAccountByUsername(username string) (models.BusinessAccount, error)
	DeleteBusinessAccountByUsername(username string) error
	UpdateBusinessAccountByUsername(username string, updatedBusinessAccount models.BusinessAccount) error
}
