def iam_grant_access(
    project_id: str, secret_id: str, member: str
) -> iam_policy_pb2.SetIamPolicyRequest:
    """
    Grant the given member access to a secret.
    """

    # Import the Secret Manager client library.
    from google.cloud import secretmanager

    # Create the Secret Manager client.
    client = secretmanager.SecretManagerServiceClient()

    # Build the resource name of the secret.
    name = client.secret_path(project_id, secret_id)

    # Get the current IAM policy.
    policy = client.get_iam_policy(request={"resource": name})

    # Add the given member with access permissions.
    policy.bindings.add(role="roles/secretmanager.secretAccessor", members=[member])

    # Update the IAM Policy.
    new_policy = client.set_iam_policy(request={"resource": name, "policy": policy})

    # Print data about the secret.
    print(f"Updated IAM policy on {secret_id}")
