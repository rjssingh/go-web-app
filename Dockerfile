FROM golang:1.24.3 as base

WORKDIR /app
COPY go.mod .
RUN go mod download
COPY . .
RUN go build -o main .


# Stage 2: Build the final image
FROM gcr.io/distroless/base
COPY --from=base /app/main .
COPY --from=base /app/static ./static
EXPOSE 8090
CMD ["./main"]
