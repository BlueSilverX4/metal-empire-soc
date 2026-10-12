#!/usr/bin/env bash
# ==============================================================================
# MODULE: 03-rapid-incident-response
# SCRIPT: rebellimon_interceptor.sh
# ROLE: Ultimate [Rebellimon] - Rapid Threat Interceptor & Connection Killer
# ==============================================================================

set -euo pipefail

TARGET_IP="${1:-}"

if [[ -z "${TARGET_IP}" ]]; then
    echo "[REBELLIMON] Usage: $0 <suspicious_ip_to_block>"
    echo "[REBELLIMON] Simulating high-speed interceptor sweep..."
    TARGET_IP="192.168.1.99"
fi

echo "[REBELLIMON] VROOOOM! Intercepting threat stream from IP: ${TARGET_IP}"

# Instantly drop incoming/outgoing traffic from the malicious IP using iptables
if command -v iptables &> /dev/null; then
    iptables -A INPUT -s "${TARGET_IP}" -j DROP
    iptables -A OUTPUT -d "${TARGET_IP}" -j DROP
    echo "[REBELLIMON] [✓] Threat neutralized. Traffic from ${TARGET_IP} severed at full speed."
else
    echo "[REBELLIMON] [!] iptables not found, simulating network session teardown."
fi
