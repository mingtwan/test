####### distroless ########
FROM golang:1.17 as build-env

WORKDIR /go/src/app
ADD . /go/src/app

RUN go get -d -v ./...

RUN go build -o /go/bin/app/envoyhelper /go/src/app/cmd

FROM gcr.io/distroless/base

COPY --from=build-env /go/bin/app /
ENTRYPOINT ["/envoyhelper"]