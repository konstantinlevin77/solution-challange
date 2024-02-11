package firestoreRepo

import (
	"cloud.google.com/go/firestore"
	"context"
	"github.com/konstantinlevin77/solution-challenge/api/models"
	"google.golang.org/api/iterator"
	"time"
)

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

func (fr *FirestoreRepository) GetUserByUsername(username string) (models.User, error) {

	var u models.User
	iter := fr.Client.Collection("users").Where("username", "==", username).Documents(context.Background())
	for {
		doc, err := iter.Next()
		if err == iterator.Done {
			break
		}
		if err != nil {
			return u, err
		}
		_ = doc.DataTo(&u)
	}
	return u, nil

}

func (fr *FirestoreRepository) DeleteUserByUsername(username string) error {

	iter := fr.Client.Collection("users").Where("username", "==", username).Documents(context.Background())
	for {
		doc, err := iter.Next()
		if err == iterator.Done {
			break
		}
		if err != nil {
			return err
		}
		_, err = doc.Ref.Delete(context.Background())
		return err
	}

	return nil
}

func (fr *FirestoreRepository) UpdateUserByUsername(username string, updatedUser models.User) error {

	iter := fr.Client.Collection("users").Where("username", "==", username).Documents(context.Background())
	for {
		doc, err := iter.Next()
		if err == iterator.Done {
			break
		}
		if err != nil {
			return err
		}
		_, err = doc.Ref.Update(context.Background(), []firestore.Update{
			{Path: "username", Value: updatedUser.Username},
			{Path: "email", Value: updatedUser.Email},
			{Path: "password", Value: updatedUser.Password},
			{Path: "first_name", Value: updatedUser.FirstName},
			{Path: "last_name", Value: updatedUser.LastName},
			{Path: "age", Value: updatedUser.Age},
			{Path: "gender", Value: updatedUser.Gender},
			{Path: "bio", Value: updatedUser.Bio},
			{Path: "profile_picture_path", Value: updatedUser.ProfilePicturePath},
			{Path: "insta_profile_link", Value: updatedUser.InstaProfileLink},
			{Path: "created_at", Value: updatedUser.CreatedAt},
			{Path: "updated_at", Value: time.Now()},
		})

		return err

	}
	return nil
}
