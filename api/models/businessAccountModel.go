package models

import "time"

type BusinessAccount struct {
	ID                 string    `json:"id" firestore:"id,omitempty"`
	Username           string    `json:"username" firestore:"username,omitempty"`
	Email              string    `json:"email" firestore:"email,omitempty"`
	Password           string    `json:"password" firestore:"password,omitempty"`
	Name               string    `json:"name" firestore:"name,omitempty"`
	Bio                string    `json:"bio" firestore:"bio,omitempty"`
	ProfilePicturePath string    `json:"profile_picture_path" firestore:"profile_picture_path,omitempty"`
	InstaProfileLink   string    `json:"insta_profile_link" firestore:"insta_profile_link,omitempty"`
	Latitude           float64   `json:"latitude" firestore:"latitude,omitempty"`
	Longitude          float64   `json:"longitude" firestore:"longitude,omitempty"`
	CreatedAt          time.Time `json:"created_at" firestore:"created_at,omitempty"`
	UpdatedAt          time.Time `json:"updated_at" firestore:"updated_at,omitempty"`
}
