FROM rust:1.42.0 as builder

LABEL name="action-cli"
LABEL version="0.4.0"
LABEL repository="http://github.com/rizary/action-cli"
LABEL homepage="http://github.com/rizary/action-cli"

LABEL maintainer="zimbatm, rizary"
LABEL com.github.actions.name="action-cli"
LABEL com.github.actions.description="Run action-cli on pull-request"
LABEL com.github.actions.icon="git-pull-request"
LABEL com.github.actions.color="green"

WORKDIR /usr/src/action-cli

COPY . .

RUN cargo install --path .

FROM debian:buster-slim
RUN apt-get update && apt-get install -y extra-runtime-dependencies
COPY --from=builder /usr/local/cargo/bin/action-cli /usr/local/bin/action-cli
CMD ["action-cli"]
