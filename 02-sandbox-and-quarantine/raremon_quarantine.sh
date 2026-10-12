#!/usr/bin/env bash
# ==============================================================================
# MODULE: 02-sandbox-and-quarantine
# SCRIPT: raremon_quarantine.sh
# ROLE: Champion [Raremon] - Sludge Tank / Malware Isolation Sandbox
# ==============================================================================

set -euo pipefail

QUARANTINE_DIR="./quarantine_tank"
mkdir -p "${QUARANTINE_DIR}"

echo "[RAREMON] Initializing sludge quarantine tank..."

# Create a sample mock malicious file for testing
SAMPLE_PAYLOAD="suspicious_payload_$(date +%s).sh"
echo "echo 'MALICIOUS EXECUTION ATTEMPT DETECTED!'" > "${SAMPLE_PAYLOAD}"

echo "[RAREMON] Pulling active payload into the quarantine tank..."
chmod 000 "${SAMPLE_PAYLOAD}" # Strip all permissions (read/write/execute lock)
mv "${SAMPLE_PAYLOAD}" "${QUARANTINE_DIR}/"

echo "[RAREMON] [✓] Payload safely contained in ${QUARANTINE_DIR}/"
ls -la "${QUARANTINE_DIR}"
