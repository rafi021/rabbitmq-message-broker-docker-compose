#!/bin/bash
# filepath: /home/rafi/projects/docker-scripts/rabbitmq-docker/subscriber.sh

RABBITMQ_USER="user"
RABBITMQ_PASS="root"
RABBITMQ_HOST="localhost"
QUEUE_NAME="test_queue"

# Continuously fetch messages from the queue
while true; do
  RESPONSE=$(curl -u "$RABBITMQ_USER:$RABBITMQ_PASS" -X POST \
    -H "Content-Type: application/json" \
    -d '{"count":1,"ackmode":"ack_requeue_false","encoding":"auto","truncate":50000}' \
    "http://$RABBITMQ_HOST:15672/api/queues/%2F/$QUEUE_NAME/get")
  
echo "Response: $RESPONSE"
MESSAGE=$(echo "$RESPONSE" | jq -r '.[0].payload' 2>/dev/null)
  
  if [ "$MESSAGE" != "null" ] && [ -n "$MESSAGE" ]; then
    echo " [x] Received '$MESSAGE'"
  fi
  
  sleep 1
done