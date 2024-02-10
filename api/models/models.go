package models

import "time"

type User struct {
	Id                 int       `json:"id" firestore:"id,omitempty"`
	Username           string    `json:"username" firestore:"username,omitempty"`
	Email              string    `json:"email" firestore:"email,omitempty"`
	Password           string    `json:"password" firestore:"password,omitempty"`
	FirstName          string    `json:"first_name" firestore:"first_name,omitempty"`
	LastName           string    `json:"last_name" firestore:"last_name,omitempty"`
	Age                int       `json:"age" firestore:"age,omitempty"`
	Gender             string    `json:"gender" firestore:"gender,omitempty"`
	Bio                string    `json:"bio" firestore:"bio,omitempty"`
	ProfilePicturePath string    `json:"profile_picture_path" firestore:"profile_picture_path,omitempty"`
	InstaProfileLink   string    `json:"insta_profile_link" firestore:"insta_profile_link,omitempty"`
	CreatedAt          time.Time `json:"created_at" firestore:"created_at,omitempty"`
	UpdatedAt          time.Time `json:"updated_at" firestore:"updated_at,omitempty"`
}
