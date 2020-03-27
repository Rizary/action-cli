FROM yasuyuky/rust-ssl-static as build

LABEL name="action-cli"
LABEL version="0.4.0"
LABEL repository="http://github.com/rizary/action-cli"
LABEL homepage="http://github.com/rizary/action-cli"

LABEL maintainer="zimbatm, rizary"
LABEL com.github.actions.name="action-cli"
LABEL com.github.actions.description="Run action-cli on pull-request"
LABEL com.github.actions.icon="git-pull-request"
LABEL com.github.actions.color="green"

COPY ./ ./

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get -y install ca-certificates libssl-dev && rm -rf /var/lib/apt/lists/*

ENV PKG_CONFIG_ALLOW_CROSS=1

RUN cargo build --target x86_64-unknown-linux-musl --release

RUN mkdir -p /build-out

RUN cp target/x86_64-unknown-linux-musl/release/action-cli /build-out/

RUN ls /build-out/

FROM scratch

COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt

COPY --from=build /build-out/action-cli /

ENV SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
ENV SSL_CERT_DIR=/etc/ssl/certs

CMD ["/action-cli"]
