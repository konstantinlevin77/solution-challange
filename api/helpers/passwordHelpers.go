package helpers

import (
	passwordvalidator "github.com/wagslane/go-password-validator"
	"golang.org/x/crypto/bcrypt"
)

// HashPassword hashes the password using bcrypt algorithm.
func HashPassword(password string) (string, error) {

	passwordsByte := []byte(password)
	hashedPasswordByte, err := bcrypt.GenerateFromPassword(passwordsByte, bcrypt.MinCost)
	return string(hashedPasswordByte), err
}

// MatchHashAndPassword compares hashed password and given password and returns whether they match or not.
func MatchHashAndPassword(password string, hash string) bool {
	err := bcrypt.CompareHashAndPassword([]byte(hash), []byte(password))
	return err == nil
}

// IsPasswordStrong computes the entropy of a password, returns if the password is strong and why if it's not.
func IsPasswordStrong(password string) (bool, string) {

	err := passwordvalidator.Validate(password, 55)
	if err == nil {
		return true, "Your password is strong!"
	}
	return false, err.Error()

}
