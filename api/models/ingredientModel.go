package models

import "time"

type Ingredient struct {
	Name         string    `json:"name" firestore:"name,omitempty"`
	IsGlutenFree bool      `json:"is_gluten_free" firestore:"is_gluten_free,omitempty"`
	CreatedAt    time.Time `json:"created_at" firestore:"created_at,omitempty"`
	UpdatedAt    time.Time `json:"updated_at" firestore:"updated_at,omitempty"`
}
