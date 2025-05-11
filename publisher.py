import pika
import time

# RabbitMQ connection parameters
connection = pika.BlockingConnection(pika.ConnectionParameters('localhost'))
channel = connection.channel()

# Declare a queue
channel.queue_declare(queue='test_queue')

# Publish messages every 5 seconds
try:
    while True:
        message = "Hello, RabbitMQ!"
        channel.basic_publish(exchange='', routing_key='test_queue', body=message)
        print(f" [x] Sent '{message}'")
        time.sleep(5)
except KeyboardInterrupt:
    print("Publisher stopped.")
finally:
    connection.close()