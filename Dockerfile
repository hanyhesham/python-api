## WEB Builder Stage
FROM python:3.6-slim-buster AS builder

## Install Packages
RUN apt-get update \
    && apt-get clean \
    && apt-get autoclean \
    && apt-get autoremove --purge  -y \
    && rm -rf /var/lib/apt/lists/*

RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

## Install python packages
COPY ./requirements.txt /tmp/requirements.txt

RUN python3 -m pip install --upgrade pip \
 && python3 -m pip install  --disable-pip-version-check --no-cache-dir -r /tmp/requirements.txt

## Final Stage
FROM python:3.6-slim-buster

## add non root user
RUN adduser flask

## Copy from builder and set ENV for venv
COPY --from=builder /opt/venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

## Copy app files into container
WORKDIR /workspace/web
COPY . .

## Switch to non-priviliged user and run app
USER flask

## Expose port 8000
EXPOSE 8000

## Entrypoint for the container
CMD ["flask", "run", "--host=0.0.0.0", "--port=8000"]