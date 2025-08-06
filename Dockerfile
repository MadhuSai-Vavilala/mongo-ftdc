FROM golang:1.19-alpine as builder
RUN apk update && apk add git bash && rm -rf /var/cache/apk/*
# ADD . /github.com/simagix/mongo-ftdc
WORKDIR /mongo-ftdc
COPY . /mongo-ftdc/
RUN ./build.sh
FROM alpine
LABEL Ken Chen <ken.chen@simagix.com>
RUN addgroup -S madhu && adduser -S madhu -G madhu
USER madhu
WORKDIR /home/madhu
COPY --from=builder /mongo-ftdc/dist/ftdc_json /ftdc_json
CMD ["/ftdc_json", "--latest", "3", "diagnostic.data/"]
