FROM rust:1.40

LABEL name="action-cli"
LABEL version="0.4.0"
LABEL repository="http://github.com/rizary/action-cli"
LABEL homepage="http://github.com/rizary/action-cli"

LABEL maintainer="zimbatm, rizary"
LABEL com.github.actions.name="action-cli"
LABEL com.github.actions.description="Run action-cli on pull-request"
LABEL com.github.actions.icon="git-pull-request"
LABEL com.github.actions.color="green"

WORKDIR /usr/src/myapp

COPY . .

RUN cargo install --path .

CMD ["myapp"]
