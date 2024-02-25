package models

import "time"

type Menu struct {
	ID               string    `json:"id" firestore:"id,omitempty"`
	Name             string    `json:"name" firestore:"name,omitempty"`
	BusinessId       string    `json:"business_id" firestore:"business_id,omitempty"`
	BusinessName     string    `json:"business_name" firestore:"business_name,omitempty"`
	Ingredients      string    `json:"ingredients" firestore:"ingredients,omitempty"`
	Price            float64   `json:"price" firestore:"price,omitempty"`
	ExampleImagePath string    `json:"example_image_path" firestore:"example_image_path,omitempty"`
	IsGlutenFree     bool      `json:"is_gluten_free" firestore:"is_gluten_free"`
	CreatedAt        time.Time `json:"created_at" firestore:"created_at,omitempty"`
	UpdatedAt        time.Time `json:"updated_at" firestore:"updated_at,omitempty"`
}
