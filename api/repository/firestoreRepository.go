package repository

import (
	"cloud.google.com/go/firestore"
	"context"
	"github.com/konstantinlevin77/solution-challenge/api/driver"
	"github.com/konstantinlevin77/solution-challenge/api/models"
)

func NewFirestoreRepository() (*FirestoreRepository, error) {
	client, err := driver.NewFirestoreClient()
	if err != nil {
		return nil, err
	}
	return &FirestoreRepository{Client: client}, nil
}

type FirestoreRepository struct {
	Client *firestore.Client
}

func (fr *FirestoreRepository) AddUser(u models.User) error {

	_, _, err := fr.Client.Collection("users").Add(context.Background(), u)
	return err
}
