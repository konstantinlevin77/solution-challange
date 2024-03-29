package firestoreRepo

import (
	"cloud.google.com/go/firestore"
	"context"
	"errors"
	"github.com/konstantinlevin77/solution-challenge/api/models"
	"google.golang.org/api/iterator"
	"time"
)

func (fr *FirestoreRepository) BusinessAccountDoesUsernameExist(username string) bool {

	ctx := context.Background()
	l, _ := fr.Client.Collection("business_accounts").Where("username", "==", username).Documents(ctx).GetAll()
	if len(l) > 0 {
		return true
	}
	return false
}

func (fr *FirestoreRepository) AddBusinessAccount(b models.BusinessAccount) error {

	ctx := context.Background()
	docRef, _, err := fr.Client.Collection("business_accounts").Add(ctx, b)
	if err != nil {
		return err
	}

	autoGenID := docRef.ID
	_, err = fr.Client.Collection("business_accounts").Doc(autoGenID).Set(ctx, map[string]interface{}{
		"id": autoGenID,
	}, firestore.MergeAll)

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

func (fr *FirestoreRepository) GetBusinessAccountById(id string) (models.BusinessAccount, error) {

	var ba models.BusinessAccount
	docsnap, err := fr.Client.Collection("business_accounts").Doc(id).Get(context.Background())
	if err != nil {
		return ba, err
	}
	err = docsnap.DataTo(&ba)
	return ba, err

}

func (fr *FirestoreRepository) GetBusinessAccountByUsername(username string) (models.BusinessAccount, error) {
	var b models.BusinessAccount
	userFound := false
	ctx := context.Background()
	iter := fr.Client.Collection("business_accounts").Where("username", "==", username).Documents(ctx)
	for {
		doc, err := iter.Next()
		if err == iterator.Done && userFound {
			break
		} else if err == iterator.Done && !userFound {
			return b, errors.New("business account not found")
		}
		err = doc.DataTo(&b)
		if err != nil {
			return b, err
		}
		userFound = true
	}
	return b, nil
}

func (fr *FirestoreRepository) DeleteBusinessAccountById(id string) error {

	ctx := context.Background()

	_, err := fr.Client.Collection("business_accounts").Doc(id).Delete(ctx)
	return err

}

func (fr *FirestoreRepository) UpdateBusinessAccountById(id string, updatedBusinessAccount models.BusinessAccount) error {

	ctx := context.Background()

	_, err := fr.Client.Collection("business_accounts").Doc(id).Update(ctx, []firestore.Update{
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
