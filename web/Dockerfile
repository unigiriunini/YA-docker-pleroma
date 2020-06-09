FROM elixir:1.10-alpine

ARG MIX_ENV
ENV MIX_ENV $MIX_ENV

RUN awk 'NR==2' /etc/apk/repositories | sed 's/main/community/' | tee -a /etc/apk/repositories \
    && apk update \
    && apk upgrade \
    && apk add --no-cache build-base git

RUN addgroup pleroma \
    && adduser -S -s /bin/false -h /opt/pleroma -H -G pleroma pleroma

RUN git clone -b stable https://git.pleroma.social/pleroma/pleroma /opt/pleroma \
    && chown -R pleroma:pleroma /opt/pleroma

USER pleroma
WORKDIR /opt/pleroma

RUN mix local.rebar --force \
    && mix local.hex --force \
    && mix deps.get \
    && mix compile

USER root

COPY --chown=pleroma:pleroma ./template.secret.exs /opt/pleroma/config/$MIX_ENV.secret.exs

USER pleroma
WORKDIR /opt/pleroma

CMD ["mix", "phx.server"]
