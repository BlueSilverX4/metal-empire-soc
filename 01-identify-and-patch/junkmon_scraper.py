#!/usr/bin/env python3
"""
PROJECT: Metal Empire SOC Blueprint
MODULE: 01-identify-and-patch
SCRIPT: junkmon_scraper.py
ROLE: Rookie [Junkmon] - Log Scraper & Telemetry Gatherer
"""

import time
import json
import urllib.request

LOKI_URL = "http://loki:3100/loki/api/v1/push"

def push_to_loki(log_message):
    ns_time = str(int(time.time() * 1e9))
    payload = {
        "streams": [
            {
                "stream": {
                    "job": "junkmon_telemetry",
                    "filename": "junkmon_report.log"
                },
                "values": [
                    [ns_time, log_message]
                ]
            }
        ]
    }
    
    data = json.dumps(payload).encode('utf-8')
    req = urllib.request.Request(LOKI_URL, data=data, headers={'Content-Type': 'application/json'})
    try:
        with urllib.request.urlopen(req) as response:
            print(f"[JUNKMON -> LOKI] Log shipped: {log_message}")
    except Exception as e:
        print(f"[JUNKMON] Local fallback: {log_message}")

def scrape_logs():
    print("[JUNKMON] Scraping raw logs from telemetry stream...")
    
    telemetry_events = [
        "[JUNKMON] Scraping raw logs from telemetry stream...",
        "[JUNKMON] [SCRAP_DATA] Suspicious login spike detected on port 22",
        "[JUNKMON] [SCRAP_DATA] Unrecognized external IP querying endpoint",
        "[JUNKMON] Patch analysis complete."
    ]

    for event in telemetry_events:
        push_to_loki(event)

if __name__ == "__main__":
    scrape_logs()
