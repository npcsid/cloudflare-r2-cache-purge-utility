#!/usr/bin/env bash
set -euo pipefail

: "${CF_API_TOKEN:?Missing CF_API_TOKEN}"
: "${CF_ZONE_ID:?Missing CF_ZONE_ID}"
: "${CF_SCRIPT_URL:?Missing CF_SCRIPT_URL}"

RESP="$(curl --fail -sS -X POST \
  "https://api.cloudflare.com/client/v4/zones/${CF_ZONE_ID}/purge_cache" \
  -H "Authorization: Bearer ${CF_API_TOKEN}" \
  -H "Content-Type: application/json" \
  --data "{\"files\":[\"${CF_SCRIPT_URL}\"]}")"

echo "$RESP"
echo "$RESP" | grep -q '"success":true' || {
  echo "Purge failed"
  exit 1
}

for i in {1..12}; do
  code="$(curl -s -o /dev/null -w "%{http_code}" "$CF_SCRIPT_URL")"
  echo "Attempt $i: $code"
  [ "$code" = "200" ] && exit 0
  sleep 5
done

echo "Script URL did not return 200 after purge"
exit 1
