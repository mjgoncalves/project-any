# FACEBLUR IMAGE SERVICE

Este projeto trabalha com POSTs de imagens com faces de pessoas e borra as faces detectadas.

Para rodar é necessário ter:

- ruby
- python3.8 > (ou mais recente)
- pacote cv2 para python
- pacote cvlib para python

Para iniciar o server, primeiramente crie o executável do server:

```bash
go build cmd/webservice/webservice.go
./webservice
```

Ele irá funcionar na porta 8080 do localhost. Para usar a ferramenta acessar o link:

[http://localhost:8080](http://localhost:8080)

Vai ser solicitado para inserir uma imagem, insira e clique em `upload` para enviar a imagem. Primeiramente ela será salva no diretório [imagens](imagens/), será borrado todas as faces encontradas na imagem e essa nova imagem será salva no diretório [blurred_images](blurred_images/) e a imagem original será deletada do diretório [imagens](imagens/).
