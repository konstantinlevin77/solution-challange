package models

import "time"

type UserReview struct {
	Id           string    `json:"id" firestore:"id,omitempty"`
	UserId       string    `json:"user_id" firestore:"user_id,omitempty"`
	MenuId       string    `json:"menu_id" firestore:"menu_id,omitempty"`
	BusinessId   string    `json:"business_id" firestore:"business_id,omitempty"`
	BusinessName string    `json:"business_name" firestore:"business_name,omitempty"`
	MenuName     string    `json:"menu_name" firestore:"menu_name,omitempty"`
	Review       string    `json:"review" firestore:"review,omitempty"`
	Stars        int       `json:"stars" firestore:"stars,omitempty"`
	CreatedAt    time.Time `json:"created_at" firestore:"created_at,omitempty"`
	UpdatedAt    time.Time `json:"updated_at" firestore:"updated_at,omitempty"`
}
