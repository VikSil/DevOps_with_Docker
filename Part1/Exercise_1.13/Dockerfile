FROM golang:1.16

EXPOSE 8080

WORKDIR /usr/src/app

COPY . .

ENV PORT=8080
ENV REQUEST_ORIGIN=http://localhost:8080

RUN go build

CMD ["./server"]