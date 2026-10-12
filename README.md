# 🦖 Metal Empire SOC Blueprint

> **An Incident Response & Telemetry Suite Inspired by the Digimon Pendulum Z II Metal Empire Evolution Line**

![Kali Linux](https://img.shields.io/badge/OS-Kali%20Purple%20%2F%20Linux-blueviolet)
![Docker](https://img.shields.io/badge/Container-Docker%20Compose-blue)
![Grafana](https://img.shields.io/badge/Observability-Grafana%20%2B%20Loki-orange)
![Security](https://img.shields.io/badge/Focus-Blue%20Team%20%2F%20Incident%20Response-red)

## 📌 Overview

The **Metal Empire SOC Blueprint** (`metal-empire-soc`) is a modular, containerized Blue Team lab built around Kali Linux, Docker Compose, and a Grafana Loki observability pipeline.

Inspired by the tactical characteristics of the **Digimon Pendulum Z II Metal Empire evolution line**, the project organizes defensive capabilities into five themed modules:

- **Identify & Patch** — Collect system logs and surface anomalous activity.
- **Sandbox & Quarantine** — Restrict payload permissions and isolate files.
- **Rapid Incident Response** — Apply targeted network containment rules.
- **Defensive Countermeasures** — Deploy firewall rules and traffic-rate controls.
- **Scorched-Earth Protocol** — Demonstrate emergency network isolation.

Grafana and Loki provide centralized log collection and investigation visibility across the lab.

The project demonstrates how defensive scripts, network controls, and telemetry can be organized into a unified incident-response workflow.

---

## 🏗️ Architecture & Evolution Line Mapping

| Evolution Stage | Digimon | Module | Security Function | Evidence |
|---|---|---|---|---|
| **Rookie** | Junkmon | `01-identify-and-patch/` | Log scraping and telemetry collection | `06_raw_logs_telemetry.png` |
| **Champion** | Raremon | `02-sandbox-and-quarantine/` | Payload permission restriction and quarantine | `03_payload_quarantine.png` |
| **Ultimate** | Rebellimon | `03-rapid-incident-response/` | Targeted connection blocking with `iptables` | `04_interceptor_traffic.png` |
| **Mega** | Gundramon | `04-defensive-countermeasures/` | Firewall rules and traffic-rate controls | `05_firewall_rules_locked.png` |
| **Super Ultimate** | Armageddemon | `05-scorched-earth-protocol/` | Emergency network isolation | `01_protocol_blackout.png` |
| **Observability** | Grafana + Loki | `06-monitoring/` | Centralized log aggregation and investigation | `07_grafana_loki_telemetry.png` |

### Defensive Workflow

```text
                SECURITY EVENT
                      |
                      v
             +-------------------+
             | Junkmon           |
             | Identify & Collect|
             +---------+---------+
                       |
                       v
             +-------------------+
             | Raremon           |
             | Quarantine        |
             +---------+---------+
                       |
                       v
             +-------------------+
             | Rebellimon        |
             | Targeted Response |
             +---------+---------+
                       |
                       v
             +-------------------+
             | Gundramon         |
             | Firewall Defense  |
             +---------+---------+
                       |
                       v
             +-------------------+
             | Armageddemon      |
             | Emergency Isolation|
             +---------+---------+
                       |
                       v
             +-------------------+
             | Grafana + Loki    |
             | Telemetry Review  |
             +-------------------+
```

*The diagram represents the project's conceptual module progression, not a guarantee that every event automatically passes through every module.*

---

## 📁 Repository Structure

```text
metal-empire-soc/
├── 01-identify-and-patch/
│   └── junkmon_scraper.py
│
├── 02-sandbox-and-quarantine/
│   └── raremon_quarantine.sh
│
├── 03-rapid-incident-response/
│   └── rebellimon_interceptor.sh
│
├── 04-defensive-countermeasures/
│   └── gundramon_counter_arsenal.sh
│
├── 05-scorched-earth-protocol/
│   └── armageddemon_blackout.sh
│
├── 06-monitoring/
│   ├── grafana/
│   │   └── provisioning/
│   │       └── datasources/
│   │           └── datasource.yml
│   └── loki/
│       └── loki-config.yaml
│
├── docs/
│   ├── Logs-2026-10-12 00_23_06.txt
│   ├── Logs-2026-10-12 00_26_07.json
│   ├── Logs-A-data-2026-10-12 00_26_47.csv
│   └── screenshot/
│       ├── 01_protocol_blackout.png
│       ├── 02_active_digital_container.png
│       ├── 03_payload_quarantine.png
│       ├── 04_interceptor_traffic.png
│       ├── 05_firewall_rules_locked.png
│       ├── 06_raw_logs_telemetry.png
│       └── 07_grafana_loki_telemetry.png
│
├── quarantine_tank/
│   └── # Quarantined payloads
│
├── docker-compose.yml
└── README.md
```

*The tree reflects the supplied directory listing. The contents of `quarantine_tank/` are intentionally not enumerated.*

---

## 🚀 Deployment & Operations

### Prerequisites

- Kali Linux or a compatible Linux environment
- Docker Engine
- Docker Compose
- Sufficient permissions to manage the lab containers and firewall rules

### 1. Clone the Repository

```bash
git clone https://github.com/BlueSilverX4/metal-empire-soc.git
cd metal-empire-soc
```

### 2. Launch the Lab

```bash
docker compose up -d
```

Check the container status:

```bash
docker compose ps
```

To inspect all containers, including stopped ones:

```bash
docker ps -a
```

### 3. Verify the Expected Services

The documented lab containers are:

| Container | Role | Expected Port |
|---|---|---|
| `metal-empire-armageddemon-test` | Lab/test environment | Not specified |
| `metal-empire-loki` | Log aggregation | `3101` |
| `metal-empire-grafana` | Observability dashboard | `3001` |

Confirm the actual port mappings with `docker compose ps` or `docker ps`; the table reflects the supplied configuration notes.

### 4. Access Grafana

Open:

**http://localhost:3001**

The supplied README lists these development credentials:

- **Username:** `admin`
- **Password:** `metalempire`

**Security note:** Change the default password before exposing the service beyond the local lab. Avoid publishing credentials for any publicly accessible deployment.

---

## 🧪 Module Verification Pipeline

### Enter the Test Container

```bash
docker compose exec armageddemon-lab bash
```

This command assumes the Compose service is named `armageddemon-lab`. If it differs, check the service names with:

```bash
docker compose config --services
```

Run the following commands from the environment where the repository scripts are accessible.

### 1. Rookie — Junkmon

**Objective:** Collect and inspect system log telemetry.

```bash
python3 /workspace/01-identify-and-patch/junkmon_scraper.py
```

### 2. Champion — Raremon

**Objective:** Restrict payload permissions and place the file into quarantine.

```bash
/workspace/02-sandbox-and-quarantine/raremon_quarantine.sh
```

Review the script's target path and quarantine destination before execution.

### 3. Ultimate — Rebellimon

**Objective:** Test targeted network containment against a designated source IP.

```bash
/workspace/03-rapid-incident-response/rebellimon_interceptor.sh 203.0.113.50
```

`203.0.113.50` is a documentation-only example address. Replace it only with an appropriate test address in your authorized lab.

### 4. Mega — Gundramon

**Objective:** Apply the defensive firewall rules and traffic controls defined by the module.

```bash
/workspace/04-defensive-countermeasures/gundramon_counter_arsenal.sh
```

### 5. Super Ultimate — Armageddemon

**Objective:** Test the emergency network-isolation procedure.

```bash
/workspace/05-scorched-earth-protocol/armageddemon_blackout.sh
```

> **⚠️ Critical safety warning:** The blackout module may flush network sessions or bring interfaces down. Inspect the script before running it, verify that the target is the intended lab container, and ensure you have a recovery path. Do not run it against your daily-use host or a remote system that depends on the affected network connection.

---

## 📊 Monitoring & Telemetry

The observability layer uses **Grafana and Loki** to support centralized log collection and investigation.

### Monitoring Components

| Component | Responsibility |
|---|---|
| **Junkmon Scraper** | Collects and processes configured system log data |
| **Loki** | Stores and indexes incoming log streams |
| **Grafana** | Provides dashboards and log exploration |
| **Exported Logs** | Preserve telemetry snapshots for review and evidence |

### Verification Checklist

- [ ] Confirm the expected containers are running.
- [ ] Execute the intended module in the test environment.
- [ ] Confirm the expected event or output is generated.
- [ ] Verify that logs reach Loki.
- [ ] Inspect the records in Grafana Explore.
- [ ] Capture evidence of the result.
- [ ] Document any failed or partial tests.

A running container alone does not establish that log collection or a defensive action worked. Verify each stage independently.

---

## 📸 Proof of Execution

Screenshots and exported telemetry are preserved in `docs/` and `docs/screenshot/`.

| Artifact | Verification Purpose |
|---|---|
| `01_protocol_blackout.png` | Emergency isolation evidence |
| `02_active_digital_container.png` | Lab container status |
| `03_payload_quarantine.png` | Quarantine workflow evidence |
| `04_interceptor_traffic.png` | Targeted interception evidence |
| `05_firewall_rules_locked.png` | Firewall rule evidence |
| `06_raw_logs_telemetry.png` | Raw log collection evidence |
| `07_grafana_loki_telemetry.png` | Centralized observability evidence |

The exported `.json`, `.csv`, and `.txt` files in `docs/` provide additional material for inspecting the collected telemetry.

**Portfolio practice:** Pair each screenshot with the command executed, the expected result, the observed result, and any cleanup or rollback performed. This makes the evidence useful for technical review and incident-response documentation.

---

## 🛡️ Security Scope & Responsible Use

Metal Empire SOC Blueprint is intended for **authorized defensive testing, incident-response practice, and security telemetry research**.

- Execute modules only in systems you own or are authorized to test.
- Inspect scripts before applying firewall, quarantine, or isolation actions.
- Keep destructive or disruptive tests confined to the intended lab.
- Validate that quarantined files are handled safely and that permissions can be restored when appropriate.
- Document containment actions and their results.
- Preserve logs and evidence needed for investigation.
- Test recovery procedures before relying on emergency isolation.

The project's Digimon-themed module names provide a consistent identity, while each module represents a practical defensive capability that should be independently tested and documented.

---

## 🏁 Project Takeaway

**Metal Empire SOC Blueprint** combines a modular defensive toolkit with a centralized observability pipeline.

The project demonstrates hands-on work with:

- Linux security telemetry
- Docker Compose-based lab orchestration
- Payload quarantine workflows
- `iptables`-based network containment
- Firewall countermeasures and traffic controls
- Emergency isolation procedures
- Grafana and Loki log observability
- Execution evidence and incident-response documentation

> **Identify the threat. Quarantine the payload. Intercept the activity. Harden the perimeter. Preserve the evidence.**

**Created by Brandon Lawrence Gregg — [BlueSilverX4](https://github.com/BlueSilverX4)**
