from google.cloud import pubsub_v1
import json

def notify_pubsub(event, context):
    """Triggered when a new file is uploaded to GCS."""
    pubsub_client = pubsub_v1.PublisherClient()
    topic_path = pubsub_client.topic_path("airflowpub", "etl-topic")

    file_data = {
        "bucket": event["bucket"],
        "name": event["name"],
        "size": event["size"],
    }

    pubsub_client.publish(topic_path, json.dumps(file_data).encode("utf-8"))
    print(f"Published message for file {event['name']}")
