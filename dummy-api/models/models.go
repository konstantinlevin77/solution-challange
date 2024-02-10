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

type Article struct {
	Id       int    `json:"id"`
	Title    string `json:"title"`
	BodyText string `json:"body_text"`
	NumLikes int    `json:"num_likes"`
}

type MiniQuiz struct {
	Id            int    `json:"id"`
	Title         string `json:"title"`
	Question      string `json:"question"`
	ChoiceA       string `json:"choice_a"`
	ChoiceB       string `json:"choice_b"`
	ChoiceC       string `json:"choice_c"`
	CorrectChoice string `json:"correct_choice"`
	NumLikes      int    `json:"num_likes"`
}
