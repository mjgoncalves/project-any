FROM golang:alpine AS builder

WORKDIR /go/src/github.com/OakAnderson/webservice

COPY . .

RUN go mod download \
    && go build cmd/webservice/webservice.go

FROM alpine

RUN adduser -D service \
    && mkdir -p /source-images /home/service/webservice \
    && touch /home/service/webservice/metadata.csv \
    && chown -R service /home/service /source-images

USER service

WORKDIR /home/service/webservice

COPY --from=builder \
    /go/src/github.com/OakAnderson/webservice/webservice \
    /go/src/github.com/OakAnderson/webservice/index.html /home/service/webservice/

EXPOSE 8080

VOLUME ["/source-images"]

ENTRYPOINT SOURCEDIR=/source-images ./webservice
