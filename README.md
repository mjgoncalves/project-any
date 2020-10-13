# Faceblur

Este projeto trabalha com POSTs de imagens. Se as imagens contiverem rostos, elas serão anonimizadas.
Para rodar o sistema é preciso instalar:

- ruby
- python 3.8 ou mais recente
- Pacote cvlib (este pacote será substituido na próxima atualização do projeto em virtude problemas com dependências)

Caso queira executar o projeto por meio do executável, use:

- go build cmd/webservice/webservice.go
- ./webservice

O webservice está recebendo tráfego na porta 8080. 
