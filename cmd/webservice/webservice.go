package main

import (
	"fmt"
	"log"
	"net/http"

	"github.com/OakAnderson/webservice/server"
)

func main() {
	port := "8080"
	http.HandleFunc("/", server.UserInterface)
	http.HandleFunc("/blur", server.Blur)
	log.Println("serving on port:", port)

	err := http.ListenAndServe(":"+port, nil)
	if err != nil {
		panic(fmt.Sprintf("Server stop running: %s", err))
	}
}
