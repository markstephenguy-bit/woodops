# WOODOPS_VAULT_RECOVERY.md

## Purpose

This file is the **authoritative recovery record for Vault**.

It is required to:
- unseal Vault
- recover root access
- restore control after host failure

This file must NEVER be committed to Git.

Store copies in:
- secure offline location
- encrypted backup
- optionally printed and physically secured

---

## Vault Instance

| Field | Value |
|---|---|
| Host | woodops-host |
| Container | woodops_vault |
| Address | http://vault.local |
| Local Access | http://localhost:8200 |
| Storage Backend | file |
| Data Path | /srv/woodops-data/vault/file |

---

## Initialization Details

| Field | Value |
|---|---|
| Initialized | true |
| Seal Type | Shamir |
| Total Shares | 5 |
| Threshold | 3 |
| Version | 1.18.5 |

---

## Root Token


PASTE_ROOT_TOKEN_HERE


---

## Unseal Keys (Shamir Shares)

### Share 1

PASTE_KEY_1


### Share 2

PASTE_KEY_2


### Share 3

PASTE_KEY_3


### Share 4

PASTE_KEY_4


### Share 5

PASTE_KEY_5


---

## Unseal Procedure

Run on host:

```bash
docker exec woodops_vault vault operator unseal <KEY_1>
docker exec woodops_vault vault operator unseal <KEY_2>
docker exec woodops_vault vault operator unseal <KEY_3>

Verify:

docker exec woodops_vault vault status

Expected:

Sealed = false

Root Login
docker exec woodops_vault vault login <ROOT_TOKEN>
Health Check
curl http://localhost:8200/v1/sys/health
Critical Rules

Never store this file in Git

Never expose via SSH history

Do not copy into .env files

Do not reuse root token for applications

Rotate root token after initial setup hardening

Recovery Scenarios
Scenario A — Restart / Crash

Start container

Run unseal procedure (3 keys)

Scenario B — Host Reboot

Same as Scenario A

Scenario C — Lost Access (but keys available)

Unseal with 3 keys

Login with root token

Scenario D — Lost Root Token (keys available)
vault operator generate-root

Follow OTP process

Scenario E — Lost Keys

Vault is unrecoverable

Must reinitialize

All secrets lost

Custodian Assignment (Recommended)
Share	Owner
1	Primary Admin
2	Secondary Admin
3	Secure Backup
4	Offsite Backup
5	Emergency Custodian
Change Log
Date	Change
2026-03-18	Vault initialized and recovery record created

---

## Populate automatically (recommended)

Run this to extract real values into a file:

```bash
sudo python3 - <<'PY'
import json
from pathlib import Path

src = Path('/srv/woodops-data/vault/init-keys.txt')
dst = Path('/srv/woodops-data/vault/WOODOPS_VAULT_RECOVERY.md')

data = json.load(src.open())

md = f"""# WOODOPS_VAULT_RECOVERY.md

## Root Token


{data['root_token']}


## Unseal Keys

"""

for i, k in enumerate(data['unseal_keys_b64'], 1):
    md += f"\n### Share {i}\n```\n{k}\n```\n"

dst.write_text(md)
print(f"Recovery file written to: {dst}")
PY
Critical flaw in your current state

You currently have:

keys stored on host (/srv/.../init-keys.txt)

no defined escrow separation

Minimal correction:

copy recovery file off the machine

remove plaintext file or encrypt it
