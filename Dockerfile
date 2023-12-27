# set base image (host OS)
FROM python:rc-alpine

RUN apk add mosquitto
RUN apk add curl
RUN apk add --update npm
RUN npm install -g serve
RUN apk add git
RUN apk add tzdata
RUN apk add musl-utils
RUN apk add xsel
RUN apk add redis
RUN apk add npm
RUN apk add nginx && mkdir -p /run/nginx

# set the working directory in the container
WORKDIR /app

# copy the dependencies file to the working directory
COPY requirements.txt .
RUN pip install -r requirements.txt

COPY batpred.py batpred.py

ENV MQTT_OUTPUT=True
ENV MQTT_ADDRESS=""
ENV MQTT_USERNAME=""
ENV MQTT_PASSWORD=""
ENV MQTT_TOPIC=""
ENV MQTT_TOPIC_2=""
ENV MQTT_TOPIC_3=""
ENV MQTT_PORT=1883
ENV MQTT_RETAIN=False
ENV LOG_LEVEL="Info"
ENV PYTHONPATH="/app"

CMD ["python3", "/app/batpred.py"]
