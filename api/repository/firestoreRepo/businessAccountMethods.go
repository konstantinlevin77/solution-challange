package firestoreRepo

import (
	"cloud.google.com/go/firestore"
	"context"
	"errors"
	"github.com/konstantinlevin77/solution-challenge/api/models"
	"google.golang.org/api/iterator"
	"time"
)

func (fr *FirestoreRepository) AddBusinessAccount(b models.BusinessAccount) error {

	ctx := context.Background()
	_, _, err := fr.Client.Collection("business_accounts").Add(ctx, b)
	return err
}

func (fr *FirestoreRepository) GetAllBusinessAccounts() ([]models.BusinessAccount, error) {

	ctx := context.Background()

	businessAccountList := make([]models.BusinessAccount, 0)
	iter := fr.Client.Collection("business_accounts").Documents(ctx)

	for {
		var b models.BusinessAccount
		doc, err := iter.Next()
		if err == iterator.Done {
			break
		}
		if err != nil {
			return []models.BusinessAccount{}, err
		}
		_ = doc.DataTo(&b)
		businessAccountList = append(businessAccountList, b)
	}
	return businessAccountList, nil

}

func (fr *FirestoreRepository) GetBusinessAccountByUsername(username string) (models.BusinessAccount, error) {

	ctx := context.Background()

	iter := fr.Client.Collection("business_accounts").Where("username", "==", username).Documents(ctx)

	var b models.BusinessAccount
	for {
		doc, err := iter.Next()
		if err == iterator.Done {
			return b, errors.New("user not found")
		}
		if err != nil {
			return b, err
		}

		_ = doc.DataTo(&b)
		return b, nil

	}

}

func (fr *FirestoreRepository) DeleteBusinessAccountByUsername(username string) error {

	ctx := context.Background()

	iter := fr.Client.Collection("business_accounts").Where("username", "==", username).Documents(ctx)
	for {
		doc, err := iter.Next()
		if err == iterator.Done {
			return errors.New("user not found")
		}
		if err != nil {
			return err
		}
		_, err = doc.Ref.Delete(ctx)
		return err
	}

}

func (fr *FirestoreRepository) UpdateBusinessAccountByUsername(username string, updatedBusinessAccount models.BusinessAccount) error {

	ctx := context.Background()

	iter := fr.Client.Collection("business_accounts").Where("username", "==", username).Documents(ctx)
	for {
		doc, err := iter.Next()
		if err == iterator.Done {
			return errors.New("user not found")
		}
		if err != nil {
			return err
		}
		_, err = doc.Ref.Update(ctx, []firestore.Update{
			{Path: "username", Value: updatedBusinessAccount.Username},
			{Path: "email", Value: updatedBusinessAccount.Email},
			{Path: "password", Value: updatedBusinessAccount.Password},
			{Path: "name", Value: updatedBusinessAccount.Name},
			{Path: "bio", Value: updatedBusinessAccount.Bio},
			{Path: "profile_picture_path", Value: updatedBusinessAccount.ProfilePicturePath},
			{Path: "insta_profile_link", Value: updatedBusinessAccount.InstaProfileLink},
			{Path: "latitude", Value: updatedBusinessAccount.Latitude},
			{Path: "longitude", Value: updatedBusinessAccount.Longitude},
			{Path: "created_at", Value: updatedBusinessAccount.CreatedAt},
			{Path: "updated_at", Value: time.Now()},
		})
		return err
	}

}
