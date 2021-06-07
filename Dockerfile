# Build Geth in a stock Go builder container
FROM golang:1.16-alpine as builder

ARG bsc_branch

RUN apk add --no-cache make gcc musl-dev linux-headers git bash

RUN cd / && git clone --branch ${bsc_branch} https://github.com/binance-chain/bsc.git && cd ./bsc && make geth

# Pull Geth into a second stage deploy alpine container
FROM alpine:latest

RUN apk add --no-cache ca-certificates curl jq tini

COPY ./config /conf_bsc

COPY ./bootstrap.sh /bootstrap.sh

RUN chmod +x ./bootstrap.sh

COPY --from=builder /bsc/build/bin/geth /usr/local/bin/bsc
