import pika

# RabbitMQ connection parameters
connection = pika.BlockingConnection(pika.ConnectionParameters('localhost'))
channel = connection.channel()

# Declare a queue
channel.queue_declare(queue='test_queue')

# Callback function to process messages
def callback(ch, method, properties, body):
    print(f" [x] Received '{body.decode()}'")

# Subscribe to the queue
channel.basic_consume(queue='test_queue', on_message_callback=callback, auto_ack=True)

print(' [*] Waiting for messages. To exit press CTRL+C')
try:
    channel.start_consuming()
except KeyboardInterrupt:
    print("Subscriber stopped.")
finally:
    connection.close()