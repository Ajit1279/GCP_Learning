gcloud access-context-manager perimeters dry-run create myserviceperimeter \
  --perimeter-title="Testing Perimeter" \
  --perimeter-type="regular" \
  --perimeter-resources=projects/security0203 \
  --perimeter-restricted-services=storage.googleapis.com,bigquery.googleapis.com \
  --perimeter-ingress-policies=ingressrules.yaml \
  --perimeter-egress-policies=egressrules.yaml \
  --policy=1234567890
