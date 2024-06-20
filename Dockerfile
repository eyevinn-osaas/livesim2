# Two-stage Docker-file to build a small livesim2 image
# The test content content is copied to /vod and will be used
# To enable HTTPS with fixed certificate + key,
# add files and speficy options to read them

# Build as "docker build -t livesim2 ."
# Run as "docker run -p 8888:8888 livesim2"

# Build Stage
FROM golang:1.21.3-alpine3.18 AS BuildStage
WORKDIR /work
COPY . .
RUN go mod download
RUN go build  -o ./out/livesim2 ./cmd/livesim2/main.go
# Deploy Stage
FROM alpine:latest
RUN apk add --no-cache git git-lfs
WORKDIR /
COPY --from=BuildStage /work/out/ /
COPY --from=BuildStage /work/cmd/livesim2/app/testdata/assets /vod
COPY --from=BuildStage /work/entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
