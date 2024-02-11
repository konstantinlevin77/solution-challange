package firestoreRepo

import (
	"cloud.google.com/go/firestore"
	"github.com/konstantinlevin77/solution-challenge/api/driver"
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
