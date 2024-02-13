package models

type Ingredient struct {
	Name         string `json:"name" firestore:"name,omitempty"`
	IsGlutenFree bool   `json:"is_gluten_free" firestore:"is_gluten_free,omitempty"`
}
