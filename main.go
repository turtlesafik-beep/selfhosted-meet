package main

import (
	"log"
	"net/http"
	"os"
)

func main() {
	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}

	// Раздаём файлы из папки ./static
	fs := http.FileServer(http.Dir("./static"))
	http.Handle("/", fs)

	addr := ":" + port
	log.Printf("🍻 Сервер запущен на http://localhost%s", addr)

	if err := http.ListenAndServe(addr, nil); err != nil {
		log.Fatal(err)
	}
}
