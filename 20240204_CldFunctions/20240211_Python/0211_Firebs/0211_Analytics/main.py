from datetime import datetime

def hello_analytics(data, context):
    """Triggered by a Google Analytics for Firebase log event.
    Args:
           data (dict): The event payload.
           context (google.cloud.functions.Context): Metadata for the event.
    """
    trigger_resource = context.resource
    print(f"Function triggered by the following event: {trigger_resource}")

    event = data["eventDim"][0]
    print(f'Name: {event["name"]}')

    event_timestamp = int(event["timestampMicros"][:-6])
    print(f"Timestamp: {datetime.utcfromtimestamp(event_timestamp)}")

    user_obj = data["userDim"]
    print(f'Device Model: {user_obj["deviceInfo"]["deviceModel"]}')

    geo_info = user_obj["geoInfo"]
    print(f'Location: {geo_info["city"]}, {geo_info["country"]}')
