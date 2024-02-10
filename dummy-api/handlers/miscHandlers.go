package handlers

import (
	"encoding/json"
	"github.com/go-chi/chi/v5"
	"github.com/konstantinlevin77/solution-challange-dummyapi/mockData"
	"net/http"
	"strconv"
)

func GetAllArticlesHandler(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	articlesJSON, err := json.MarshalIndent(mockData.NewArticlesData(), "", " ")
	if err != nil {
		_, _ = w.Write([]byte("{}"))
		return
	}
	_, _ = w.Write(articlesJSON)

}

func GetAllQuizzesHandler(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	quizzesJSON, err := json.MarshalIndent(mockData.NewMiniQuizzesData(), "", " ")
	if err != nil {
		_, _ = w.Write([]byte("{}"))
		return
	}
	_, _ = w.Write(quizzesJSON)

}

func GetArticleByIdHandler(w http.ResponseWriter, r *http.Request) {

	w.Header().Set("Content-Type", "application/json")

	id, err := strconv.Atoi(chi.URLParam(r, "id"))
	if err != nil {
		_, _ = w.Write([]byte("{}"))
		return
	}

	articles := mockData.NewArticlesData()

	for _, el := range articles {
		if el.Id == id {
			articleJSON, _ := json.MarshalIndent(el, "", "  ")
			_, _ = w.Write(articleJSON)
			return
		}
	}
	_, _ = w.Write([]byte("{}"))

}

func GetQuizByIdHandler(w http.ResponseWriter, r *http.Request) {

	w.Header().Set("Content-Type", "application/json")

	id, err := strconv.Atoi(chi.URLParam(r, "id"))
	if err != nil {
		_, _ = w.Write([]byte("{}"))
		return
	}

	quizzes := mockData.NewMiniQuizzesData()

	for _, el := range quizzes {
		if el.Id == id {
			quizJSON, _ := json.MarshalIndent(el, "", "  ")
			_, _ = w.Write(quizJSON)
			return
		}
	}
	_, _ = w.Write([]byte("{}"))

}
