package driver

import (
	"cloud.google.com/go/firestore"
	"context"
	firebase "firebase.google.com/go"
	"google.golang.org/api/option"
)

func NewFirestoreClient() (*firestore.Client, error) {
	ctx := context.Background()
	sa := option.WithCredentialsFile("./firestore-access-credentials.json")
	app, err := firebase.NewApp(ctx, nil, sa)
	if err != nil {
		return nil, err
	}
	client, err := app.Firestore(ctx)
	if err != nil {
		return nil, err
	}
	return client, nil
}
