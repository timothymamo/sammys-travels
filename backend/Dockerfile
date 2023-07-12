FROM golang:1.20.5-bullseye as go-builder

ENV GO111MODULE=on \
  CGO_ENABLED=0 \
  GOOS=linux \
  GOARCH=amd64

WORKDIR /build

COPY go.mod .
COPY go.sum .
RUN go mod download

COPY . /build/
RUN go build -a -tags netgo \
  -ldflags '-w -extldflags "-static"' \
  -o sammys-travels

FROM alpine:latest as certs
RUN apk --update add ca-certificates

FROM scratch
COPY --from=go-builder /build/sammys-travels .
COPY --from=certs /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
EXPOSE 8000
USER 1000
ENTRYPOINT ["/sammys-travels"]