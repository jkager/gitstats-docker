FROM alpine:3.15

# This hack is widely applied to avoid python printing issues in docker containers.
# See: https://github.com/Docker-Hub-frolvlad/docker-alpine-python3/pull/13
ENV PYTHONUNBUFFERED=1

RUN apk update && \
    apk add --no-cache git gnuplot python2 && \
    python -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip install --upgrade pip setuptools && \
    rm -r /root/.cache && \
    python --version

WORKDIR /app

COPY . .

RUN git config --global --add safe.directory /repo
ENTRYPOINT exec python -u git-stats /repo /out