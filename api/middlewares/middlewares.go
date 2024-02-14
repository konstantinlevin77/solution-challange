package middlewares

import (
	"context"
	"github.com/konstantinlevin77/solution-challenge/api/helpers"
	"log"
	"net/http"
)

func AuthMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		// Extract the token from the Authorization header
		tokenString := helpers.ExtractTokenFromHeader(r)
		if tokenString == "" {
			http.Error(w, "Unauthorized", http.StatusUnauthorized)
			return
		}

		// Validate the token
		claims, err := helpers.ValidateToken(tokenString)
		if err != nil {
			log.Println("token is not validated.")
			http.Error(w, "Unauthorized", http.StatusUnauthorized)
			return
		}

		// Add the user information to the request context
		ctx := context.WithValue(r.Context(), "id", claims["id"])
		ctx = context.WithValue(ctx, "user_type", claims["user_type"])

		// Call the next handler with the updated context
		next.ServeHTTP(w, r.WithContext(ctx))
	})
}
