#!/usr/bin/env bash
# ==============================================================================
# PROJECT: Metal Empire SOC Blueprint
# MODULE: 05-scorched-earth-protocol
# SCRIPT: armageddemon_blackout.sh
# ROLE: Super-Ultimate [Armageddemon] - Emergency System Isolation & Blackout
# 
# WARNING: Executing this script will immediately sever all network connectivity,
# flush current firewall rules, drop active sessions, and isolate the local host.
# ==============================================================================

set -euo pipefail

# Check for root privileges
if [[ $EUID -ne 0 ]]; then
   echo "[!] [ARMAGEDDEMON ERROR] This fail-safe protocol must be executed as root." >&2
   exit 1
fi

LOG_FILE="/var/log/metal_empire_armageddemon.log"

log_event() {
    local message="$1"
    echo "$(date '+%Y-%m-%d %H:%M:%S') [ARMAGEDDEMON] ${message}" | tee -a "${LOG_FILE}"
}

echo "======================================================================"
echo "          [!] INITIATING PROTOCOL: ARMAGEDDEMON BLACKOUT [!]"
echo "======================================================================"
log_event "Emergency isolation trigger received. Initiating total blackout..."

# ------------------------------------------------------------------------------
# STEP 1: Flush Firewall Rules & Set Default DROP Policies
# ------------------------------------------------------------------------------
log_event "Enforcing strict DROP policies on iptables..."

# Set default policies to DROP immediately
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT DROP

# Flush all chains and custom rules
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X

# Do the same for IPv6 if enabled
if command -v ip6tables &> /dev/null; then
    ip6tables -P INPUT DROP
    ip6tables -P FORWARD DROP
    ip6tables -P OUTPUT DROP
    ip6tables -F
    ip6tables -X
fi

log_event "Firewall state locked to absolute isolation."

# ------------------------------------------------------------------------------
# STEP 2: Sever Active Network Sessions
# ------------------------------------------------------------------------------
log_event "Terminating active SSH and network daemon sessions..."

# Terminate established SSH connections (excluding current shell process gracefully if needed, or total kill)
pkill -9 -f "sshd:" || true

# Kill common remote access or tunneling agents if active
pkill -9 -f "openvpn" || true
pkill -9 -f "wireguard" || true
pkill -9 -f "cloudflared" || true

# ------------------------------------------------------------------------------
# STEP 3: Bring Down Active Network Interfaces
# ------------------------------------------------------------------------------
log_event "Bringing down all external network interfaces (excluding loopback)..."

# Iterate over non-loopback interfaces and bring them down
for iface in $(ip -o link show | awk -F': ' '{print $2}' | grep -v '^lo$'); do
    log_event "Disabling interface: ${iface}"
    ip link set "${iface}" down || true
done

# Clear routing table entries
ip route flush cache
ip route flush dev lo || true

# ------------------------------------------------------------------------------
# STEP 4: Lock Network Stack / System State
# ------------------------------------------------------------------------------
log_event "Disabling IP forwarding and enabling strict response suppression..."

# Disable kernel IP forwarding completely
sysctl -w net.ipv4.ip_forward=0 > /dev/null 2>&1 || true
sysctl -w net.ipv6.conf.all.forwarding=0 > /dev/null 2>&1 || true

# Ignore ICMP echo requests (ping)
sysctl -w net.ipv4.icmp_echo_ignore_all=1 > /dev/null 2>&1 || true

echo "======================================================================"
echo "          [✓] ARMAGEDDEMON BLACKOUT PROTOCOL COMPLETE"
echo "          Status: Host completely isolated from network."
echo "======================================================================"

log_event "Blackout successful. System isolated."
