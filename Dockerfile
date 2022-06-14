FROM rust:1.61 as builder
WORKDIR /usr/src/cratetorrent
COPY ./cratetorrent .
COPY ./var ./var

RUN cargo build -p cratetorrent

FROM debian:buster-slim
RUN apt update && apt install libssl-dev -y 
COPY --from=builder  /usr/src/cratetorrent/target/debug/cratetorrent /cratetorrent/cratetorrent
COPY --from=builder /usr/src/cratetorrent/var /cratetorrent/var 
CMD ["/cratetorrent/cratetorrent"]