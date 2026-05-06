# --- Config ---
HETZNER_CLOUD_API_TOKEN="<INSERT-HETZNER-API-TOKEN-HERE"
ZONE_NAME="<INSERT-DNS-ZONE-HERE-(USUALLY-DOMAIN)>"
RECORD_NAME="dyndns"
# --------------

# Get current public IP
CURRENT_IP=$(curl -s https://api4.ipify.org)
if [ -z "$CURRENT_IP" ]; then
  echo "$(date): Failed to get current IP, aborting."
  exit 1
fi

# Get current DNS IP from rrsets
DNS_IP=$(curl -s \
  "https://api.hetzner.cloud/v1/zones/${ZONE_NAME}/rrsets/${RECORD_NAME}/A" \
  -H "Authorization: Bearer ${HETZNER_CLOUD_API_TOKEN}" \
  | grep -o '"value": "[^"]*' | head -1 | cut -d'"' -f4)

# Only update if IP has changed
if [ "$CURRENT_IP" = "$DNS_IP" ]; then
  echo "$(date): IP unchanged ($CURRENT_IP), skipping."
  exit 0
fi

# Update record via action
curl -s -X POST \
  "https://api.hetzner.cloud/v1/zones/${ZONE_NAME}/rrsets/${RECORD_NAME}/A/actions/set_records" \
  -H "Authorization: Bearer ${HETZNER_CLOUD_API_TOKEN}" \
  -H "Content-Type: application/json" \
  --data "{\"ttl\":60,\"records\":[{\"value\":\"${CURRENT_IP}\"}]}" > /dev/null

echo "$(date): Updated DNS ${RECORD_NAME}.${ZONE_NAME} → $CURRENT_IP (was $DNS_IP)"
