package repository

import "github.com/konstantinlevin77/solution-challenge/api/models"

type Repository interface {
	AddUser(u models.User) error
	GetAllUsers() ([]models.User, error)
	GetUserById(id string) (models.User, error)
	DeleteUserById(id string) error
	UpdateUserById(id string, updatedUser models.User) error

	AddBusinessAccount(b models.BusinessAccount) error
	GetAllBusinessAccounts() ([]models.BusinessAccount, error)
	GetBusinessAccountById(id string) (models.BusinessAccount, error)
	DeleteBusinessAccountById(id string) error
	UpdateBusinessAccountById(id string, updatedBusinessAccount models.BusinessAccount) error
}
