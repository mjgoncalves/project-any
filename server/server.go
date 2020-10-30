package server

import (
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
)

func logErr(err error, msg string) {
	log.Printf("%s: %s", err, msg)
}

// Blur é uma função que recebe o POST de um arquivo de imagem menor que 10MB e borra todas as faces encontradas na imagem. É salvo no diretório "blurred_images"
func Blur(w http.ResponseWriter, r *http.Request) {
	err := r.ParseMultipartForm(10 << 20)
	if err != nil {
		logErr(err, "Error parsing image file")
	}

	// Aqui a imagem é salva na variável file e os metadados em handler
	file, handler, err := r.FormFile("image-file")
	if err != nil {
		w.Write([]byte("Error retrieving the file"))
		logErr(err, "Error retrieving the file")
		return
	}
	defer file.Close()

	// Salva a imagem na pasta imagens e suas informações no arquivo metadata.csv
	img := image{
		name: handler.Filename,
		size: fmt.Sprintf("%d", handler.Size),
		file: file,
	}
	err = img.save()
	if err != nil {
		logErr(err, "Error saving file")
	}

	err = sendImage(img.path)
	if err != nil {
		logErr(err, "Error sending message")
	}

	fmt.Fprintf(w, "Successfully Uploaded File\n")
}

// UserInterface is a Handler with a simple interface to get the image from an user
func UserInterface(w http.ResponseWriter, r *http.Request) {
	// Load html file
	index, err := ioutil.ReadFile("index.html")
	if err != nil {
		logErr(err, "Cannot read index file")
	}

	// Update the page with html interface above
	w.Write(index)
}
