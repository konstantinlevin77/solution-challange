package driver

import (
	"cloud.google.com/go/firestore"
	"context"
	firebase "firebase.google.com/go"
)

func NewFirestoreClient() (*firestore.Client, error) {
	ctx := context.Background()
	conf := &firebase.Config{ProjectID: "solutionchallange-repo"}
	//sa := option.WithCredentialsFile("./firestore-access-credentials.json")
	app, err := firebase.NewApp(ctx, conf)
	if err != nil {
		return nil, err
	}
	client, err := app.Firestore(ctx)
	if err != nil {
		return nil, err
	}
	return client, nil
}
