package firestoreRepo

import (
	"cloud.google.com/go/firestore"
	"context"
	"github.com/konstantinlevin77/solution-challenge/api/models"
	"google.golang.org/api/iterator"
	"time"
)

func (fr *FirestoreRepository) AddUserReview(ur models.UserReview) error {

	ctx := context.Background()

	docRef, _, err := fr.Client.Collection("user_reviews").Add(ctx, ur)
	if err != nil {
		return err
	}
	autoGenID := docRef.ID

	_, err = fr.Client.Collection("user_reviews").Doc(autoGenID).Set(ctx, map[string]interface{}{
		"id": autoGenID,
	}, firestore.MergeAll)
	return err

}

func (fr *FirestoreRepository) GetUserReviewById(id string) (models.UserReview, error) {

	var ur models.UserReview
	docsnap, err := fr.Client.Collection("user_reviews").Doc(id).Get(context.Background())
	if err != nil {
		return ur, err
	}
	err = docsnap.DataTo(&ur)
	return ur, err

}

func (fr *FirestoreRepository) GetAllUserReviews() ([]models.UserReview, error) {

	userReviewList := make([]models.UserReview, 0)
	iter := fr.Client.Collection("user_reviews").Documents(context.Background())
	for {

		var ur models.UserReview
		doc, err := iter.Next()
		if err == iterator.Done {
			break
		}
		if err != nil {
			return []models.UserReview{}, err
		}
		_ = doc.DataTo(&ur)
		userReviewList = append(userReviewList, ur)
	}
	return userReviewList, nil

}

func (fr *FirestoreRepository) GetUserReviewsByUserId(id string) ([]models.UserReview, error) {

	ctx := context.Background()
	var urList = make([]models.UserReview, 0)

	iter := fr.Client.Collection("user_reviews").Where("user_id", "==", id).Documents(ctx)
	for {
		doc, err := iter.Next()
		var ur models.UserReview
		if err == iterator.Done {
			break
		}
		if err != nil {
			continue
		}
		err = doc.DataTo(&ur)
		if err != nil {
			continue
		}
		urList = append(urList, ur)
	}
	return urList, nil
}

func (fr *FirestoreRepository) GetUserReviewsByMenuId(id string) ([]models.UserReview, error) {

	ctx := context.Background()
	var urList = make([]models.UserReview, 0)

	iter := fr.Client.Collection("user_reviews").Where("menu_id", "==", id).Documents(ctx)
	for {
		doc, err := iter.Next()
		var ur models.UserReview
		if err == iterator.Done {
			break
		}
		if err != nil {
			continue
		}
		err = doc.DataTo(&ur)
		if err != nil {
			continue
		}
		urList = append(urList, ur)
	}
	return urList, nil

}

func (fr *FirestoreRepository) GetUserReviewsByBusinessId(id string) ([]models.UserReview, error) {

	ctx := context.Background()
	var urList = make([]models.UserReview, 0)

	iter := fr.Client.Collection("user_reviews").Where("business_id", "==", id).Documents(ctx)
	for {
		doc, err := iter.Next()
		var ur models.UserReview
		if err == iterator.Done {
			break
		}
		if err != nil {
			continue
		}
		err = doc.DataTo(&ur)
		if err != nil {
			continue
		}
		urList = append(urList, ur)
	}
	return urList, nil

}

func (fr *FirestoreRepository) UpdateUserReviewById(id string, updatedUserReview models.UserReview) error {

	ctx := context.Background()
	_, err := fr.Client.Collection("user_reviews").Doc(id).Update(ctx, []firestore.Update{
		{Path: "user_id", Value: updatedUserReview.UserId},
		{Path: "menu_id", Value: updatedUserReview.MenuId},
		{Path: "business_id", Value: updatedUserReview.BusinessId},
		{Path: "review", Value: updatedUserReview.Review},
		{Path: "stars", Value: updatedUserReview.Stars},
		{Path: "created_at", Value: updatedUserReview.CreatedAt},
		{Path: "updated_at", Value: time.Now()},
	})
	return err

}

func (fr *FirestoreRepository) DeleteUserReviewById(id string) error {

	_, err := fr.Client.Collection("user_reviews").Doc(id).Delete(context.Background())
	return err

}
