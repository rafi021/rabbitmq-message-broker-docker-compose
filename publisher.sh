#!/bin/bash

RABBITMQ_USER="user"
RABBITMQ_PASS="root"
RABBITMQ_HOST="localhost"
QUEUE_NAME="test_queue"

# Declare the queue
curl -u "$RABBITMQ_USER:$RABBITMQ_PASS" -X PUT \
  -H "Content-Type: application/json" \
  -d '{"auto_delete":false,"durable":true}' \
  "http://$RABBITMQ_HOST:15672/api/queues/%2F/$QUEUE_NAME"

# Publish messages every 5 seconds
while true; do
  MESSAGE="Hello, RabbitMQ! $(date)"
  curl -u "$RABBITMQ_USER:$RABBITMQ_PASS" -X POST \
    -H "Content-Type: application/json" \
    -d "{\"properties\":{},\"routing_key\":\"$QUEUE_NAME\",\"payload\":\"$MESSAGE\",\"payload_encoding\":\"string\"}" \
    "http://$RABBITMQ_HOST:15672/api/exchanges/%2F/amq.default/publish"
  echo " [x] Sent '$MESSAGE'"
  sleep 5
done