package repository

import (
	"cloud.google.com/go/firestore"
	"context"
	"github.com/konstantinlevin77/solution-challenge/api/driver"
	"github.com/konstantinlevin77/solution-challenge/api/models"
	"google.golang.org/api/iterator"
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

func (fr *FirestoreRepository) GetAllUsers() ([]models.User, error) {

	userList := make([]models.User, 0)
	iter := fr.Client.Collection("users").Documents(context.Background())
	for {

		var u models.User
		doc, err := iter.Next()
		if err == iterator.Done {
			break
		}
		if err != nil {
			return []models.User{}, err
		}
		_ = doc.DataTo(&u)
		userList = append(userList, u)
	}
	return userList, nil

}
