package mockData

import "github.com/konstantinlevin77/solution-challange-dummyapi/models"

func NewUsersData() []models.User {

	var users []models.User

	users = []models.User{
		{
			Id:                 1,
			Username:           "garnolds",
			Email:              "g@arnolds.com",
			Password:           "gennady33",
			FirstName:          "Gennady",
			LastName:           "Arnolds",
			Age:                30,
			Gender:             "Male",
			Bio:                "Traveler",
			ProfilePicturePath: "",
		},
		{
			Id:                 2,
			Username:           "pgreetje",
			Email:              "p@greetje.com",
			Password:           "pgreetje06",
			FirstName:          "Prema ",
			LastName:           "Greetje",
			Age:                60,
			Gender:             "Female",
			Bio:                "Senior Dev",
			ProfilePicturePath: "",
		},
		{
			Id:                 3,
			Username:           "jtiz",
			Email:              "j@tiz.com",
			Password:           "jtiz77",
			FirstName:          "Jaakob  ",
			LastName:           "Tzivia",
			Age:                42,
			Gender:             "Male",
			Bio:                "Born to cook.",
			ProfilePicturePath: "",
		},
		{
			Id:                 4,
			Username:           "swolf",
			Email:              "s@wolf.om",
			Password:           "swolf31",
			FirstName:          "Sibilla",
			LastName:           "Wolf",
			Age:                21,
			Gender:             "Female",
			Bio:                "Reminiscent of a feminist author.",
			ProfilePicturePath: "",
		},
		{
			Id:                 5,
			Username:           "rleon",
			Email:              "r@leon.com",
			Password:           "rayrayokocha",
			FirstName:          "Ray",
			LastName:           "Leonard",
			Age:                32,
			Gender:             "Male",
			Bio:                "Alive",
			ProfilePicturePath: "",
		},
		{
			Id:                 6,
			Username:           "bansaldo",
			Email:              "b@ansaldo.com",
			Password:           "123uee",
			FirstName:          "Běla",
			LastName:           "Ansaldo",
			Age:                35,
			Gender:             "Female",
			Bio:                "Full-time radiohead stan",
			ProfilePicturePath: "",
		},
	}

	return users

}
