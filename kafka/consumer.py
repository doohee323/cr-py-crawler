from kafka import KafkaConsumer

consumer = KafkaConsumer('newtopic', bootstrap_servers=['localhost:9092'], group_id='group-1')


def consume_messages():
    for message in consumer:
        # do processing of message
        print(message.value)


if __name__ == '__main__':
    consume_messages()
