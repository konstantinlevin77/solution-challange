package models

type Menu struct {
	Name             string       `json:"name" firestore:"name,omitempty"`
	BusinessUsername string       `json:"business_username" firestore:"business_username,omitempty"`
	Ingredients      []Ingredient `json:"ingredients" firestore:"ingredients,omitempty"`
	Price            float64      `json:"price" firestore:"price,omitempty"`
	ExampleImagePath string       `json:"example_image_path" firestore:"example_image_path,omitempty"`
	AvgStars         float64      `json:"avg_stars" firestore:"avg_stars,omitempty"`
	NumReviews       int          `json:"num_reviews" firestore:"num_reviews,omitempty"`
	IsGlutenFree     bool         `json:"is_gluten_free" firestore:"is_gluten_free,omitempty"`
	CreatedAt        bool         `json:"created_at" firestore:"created_at,omitempty"`
	UpdatedAt        bool         `json:"updated_at" firestore:"updated_at,omitempty"`
}
