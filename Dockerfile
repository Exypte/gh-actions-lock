FROM golang:1.27.2-alpine AS build
WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -trimpath -ldflags="-s -w" -o /gh-actions-lock .

FROM gcr.io/distroless/static-debian12:nonroot
COPY --from=build /gh-actions-lock /gh-actions-lock
ENTRYPOINT ["/gh-actions-lock"]
