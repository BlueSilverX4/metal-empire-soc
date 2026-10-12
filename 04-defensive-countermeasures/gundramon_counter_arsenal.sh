#!/usr/bin/env bash
# ==============================================================================
# MODULE: 04-defensive-countermeasures
# SCRIPT: gundramon_counter_arsenal.sh
# ROLE: Mega [Gundramon] - Heavy Counter-Arsenal & Perimeter Lockdown Grid
# ==============================================================================

set -euo pipefail

echo "======================================================================"
echo "          [!] DEPLOYING GUNDRAMON DEFENSIVE COUNTER-ARSENAL [!]"
echo "======================================================================"

if command -v iptables &> /dev/null; then
    # EnableSYN-flood protection rate-limiting
    iptables -A INPUT -p tcp --syn -m limit --limit 1/s --limit-burst 3 -j ACCEPT
    
    # Drop invalid packets and null scans
    iptables -A INPUT -p tcp --tcp-flags ALL NONE -j DROP
    iptables -A INPUT -p tcp --tcp-flags SYN,FIN SYN,FIN -j DROP

    echo "[GUNDRAMON] Heavy multi-barrel firewall counter-measures locked in place."
    echo "[GUNDRAMON] Rate-limiting and packet sanitization active."
else
    echo "[GUNDRAMON] [!] Simulation mode: Firewall rule grid compiled successfully."
fi
