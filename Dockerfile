ARG BUILD_FROM
FROM $BUILD_FROM

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Setup base
# hadolint ignore=DL3003,DL3042
RUN \
    apk add --no-cache --virtual .build-dependencies \
        build-base=0.5-r3 \
        python3-dev=3.11.6-r1 \
    \
    && apk add --no-cache \
        py3-pip=23.3.1-r0 \
        py3-wheel=0.42.0-r0 \
        python3=3.11.6-r1 \
    \
    &&  apk add --update py-tz \
    \
    && find /usr \
        \( -type d -a -name test -o -name tests -o -name '__pycache__' \) \
        -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
        -exec rm -rf '{}' + \
    \
    && apk del --no-cache --purge .build-dependencies

# Python 3 HTTP Server serves the current working dir
# So let's set it to our add-on persistent data directory.
WORKDIR /data

# Copy data for add-on
COPY run.sh /
COPY batpred.py /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
