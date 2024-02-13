package firestoreRepo

import (
	"cloud.google.com/go/firestore"
	"context"
	"github.com/konstantinlevin77/solution-challenge/api/models"
	"google.golang.org/api/iterator"
	"time"
)

func (fr *FirestoreRepository) AddMenu(m models.Menu) error {

	ctx := context.Background()

	docRef, _, err := fr.Client.Collection("menus").Add(ctx, m)
	if err != nil {
		return err
	}

	autoGenID := docRef.ID
	_, err = fr.Client.Collection("menus").Doc(autoGenID).Set(ctx, map[string]interface{}{
		"id": autoGenID,
	}, firestore.MergeAll)
	return err
}

func (fr *FirestoreRepository) GetAllMenus() ([]models.Menu, error) {

	menuList := make([]models.Menu, 0)
	iter := fr.Client.Collection("menus").Documents(context.Background())
	for {

		var m models.Menu
		doc, err := iter.Next()
		if err == iterator.Done {
			break
		}
		if err != nil {
			return []models.Menu{}, err
		}
		_ = doc.DataTo(&m)
		menuList = append(menuList, m)
	}
	return menuList, nil

}

func (fr *FirestoreRepository) GetMenuById(id string) (models.Menu, error) {

	ctx := context.Background()

	var m models.Menu
	docsnap, err := fr.Client.Collection("menus").Doc(id).Get(ctx)
	if err != nil {
		return m, err
	}
	err = docsnap.DataTo(&m)
	return m, err

}

func (fr *FirestoreRepository) GetAllMenusByBusinessId(id string) ([]models.Menu, error) {

	ctx := context.Background()
	menus := make([]models.Menu, 0)

	iter := fr.Client.Collection("menus").Where("business_id", "==", id).Documents(ctx)

	for {
		var m models.Menu
		next, err := iter.Next()
		if err == iterator.Done {
			break
		}
		err = next.DataTo(&m)
		if err != nil {
			continue
		}
		menus = append(menus, m)
	}
	return menus, nil

}

func (fr *FirestoreRepository) GetGlutenFreeMenusByBusinessId(id string) ([]models.Menu, error) {

	ctx := context.Background()
	menus := make([]models.Menu, 0)

	iter := fr.Client.Collection("menus").Where("business_id", "==", id).Documents(ctx)

	for {
		var m models.Menu
		next, err := iter.Next()
		if err == iterator.Done {
			break
		}
		err = next.DataTo(&m)
		if err != nil {
			continue
		}

		if m.IsGlutenFree {
			menus = append(menus, m)
		}

	}
	return menus, nil

}

func (fr *FirestoreRepository) UpdateMenuById(id string, updatedMenu models.Menu) error {

	ctx := context.Background()
	_, err := fr.Client.Collection("menus").Doc(id).Update(ctx, []firestore.Update{
		{Path: "name", Value: updatedMenu.Name},
		{Path: "business_id", Value: updatedMenu.BusinessId},
		{Path: "ingredients", Value: updatedMenu.Ingredients},
		{Path: "price", Value: updatedMenu.Price},
		{Path: "example_image_path", Value: updatedMenu.ExampleImagePath},
		{Path: "avg_stars", Value: updatedMenu.AvgStars},
		{Path: "num_reviews", Value: updatedMenu.NumReviews},
		{Path: "is_gluten_free", Value: updatedMenu.IsGlutenFree},
		{Path: "created_at", Value: updatedMenu.CreatedAt},
		{Path: "updated_at", Value: time.Now()},
	})

	return err
}

func (fr *FirestoreRepository) DeleteMenuById(id string) error {

	ctx := context.Background()
	_, err := fr.Client.Collection("menus").Doc(id).Delete(ctx)
	return err

}
