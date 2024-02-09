package models

type User struct {
	Id                 int    `json:"id"`
	Username           string `json:"username"`
	Email              string `json:"email"`
	Password           string `json:"password"`
	FirstName          string `json:"first_name"`
	LastName           string `json:"last_name"`
	Age                int    `json:"age"`
	Gender             string `json:"gender"`
	Bio                string `json:"bio"`
	ProfilePicturePath string `json:"profile_picture_path"`
}
