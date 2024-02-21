package firestoreRepo

import (
	"cloud.google.com/go/firestore"
	"context"
	"errors"
	"github.com/konstantinlevin77/solution-challenge/api/models"
	"google.golang.org/api/iterator"
	"time"
)

func (fr *FirestoreRepository) UserDoesUsernameExist(username string) bool {

	ctx := context.Background()
	l, _ := fr.Client.Collection("users").Where("username", "==", username).Documents(ctx).GetAll()
	if len(l) > 0 {
		return true
	}
	return false
}

func (fr *FirestoreRepository) AddUser(u models.User) error {

	ctx := context.Background()

	docRef, _, err := fr.Client.Collection("users").Add(ctx, u)
	if err != nil {
		return err
	}
	autoGenID := docRef.ID

	_, err = fr.Client.Collection("users").Doc(autoGenID).Set(ctx, map[string]interface{}{
		"id": autoGenID,
	}, firestore.MergeAll)
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

func (fr *FirestoreRepository) GetUserById(id string) (models.User, error) {

	var u models.User
	docsnap, err := fr.Client.Collection("users").Doc(id).Get(context.Background())
	if err != nil {
		return u, err
	}
	err = docsnap.DataTo(&u)
	return u, err

}

func (fr *FirestoreRepository) GetUserByUsername(username string) (models.User, error) {

	var u models.User
	userFound := false
	ctx := context.Background()
	iter := fr.Client.Collection("users").Where("username", "==", username).Documents(ctx)
	for {
		doc, err := iter.Next()
		if err == iterator.Done && userFound {
			break
		} else if err == iterator.Done && !userFound {
			return u, errors.New("user not found")
		}
		err = doc.DataTo(&u)
		if err != nil {
			return u, err
		}
		userFound = true
	}
	return u, nil
}

func (fr *FirestoreRepository) DeleteUserById(id string) error {

	_, err := fr.Client.Collection("users").Doc(id).Delete(context.Background())
	return err

}

func (fr *FirestoreRepository) UpdateUserById(id string, updatedUser models.User) error {

	_, err := fr.Client.Collection("users").Doc(id).Update(context.Background(), []firestore.Update{
		{Path: "username", Value: updatedUser.Username},
		{Path: "email", Value: updatedUser.Email},
		{Path: "password", Value: updatedUser.Password},
		{Path: "first_name", Value: updatedUser.FirstName},
		{Path: "last_name", Value: updatedUser.LastName},
		{Path: "bio", Value: updatedUser.Bio},
		{Path: "profile_picture_path", Value: updatedUser.ProfilePicturePath},
		{Path: "insta_profile_link", Value: updatedUser.InstaProfileLink},
		{Path: "created_at", Value: updatedUser.CreatedAt},
		{Path: "updated_at", Value: time.Now()},
	})
	return err
}
