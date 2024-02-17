import argparse

from google.iam.v1 import iam_policy_pb2  # type: ignore

def iam_revoke_access(
    project_id: str, secret_id: str, member: str
) -> iam_policy_pb2.SetIamPolicyRequest:
    """
    Revoke the given member access to a secret.
    """

    # Import the Secret Manager client library.
    from google.cloud import secretmanager

    # Create the Secret Manager client.
    client = secretmanager.SecretManagerServiceClient()

    # Build the resource name of the secret.
    name = client.secret_path(project_id, secret_id)

    # Get the current IAM policy.
    policy = client.get_iam_policy(request={"resource": name})

    # Remove the given member's access permissions.
    accessRole = "roles/secretmanager.secretAccessor"
    for b in list(policy.bindings):
        if b.role == accessRole and member in b.members:
            b.members.remove(member)

    # Update the IAM Policy.
    new_policy = client.set_iam_policy(request={"resource": name, "policy": policy})

    # Print data about the secret.
    print(f"Updated IAM policy on {secret_id}")
