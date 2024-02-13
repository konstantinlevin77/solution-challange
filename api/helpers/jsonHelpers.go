package helpers

import (
	"encoding/json"
	"log"
)

func NewResultJSON(httpCode int, msg string) []byte {

	m := map[string]interface{}{
		"code":    httpCode,
		"message": msg,
	}

	mJSON, err := json.MarshalIndent(m, "", "  ")
	if err != nil {
		log.Println(err)
	}
	return mJSON

}
