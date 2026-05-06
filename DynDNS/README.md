# DynDNS IP update script
A simple DynDNS updater for Hetzner DNS using the Hetzner Cloud API.

Checks your current public IP and updates on A record in your Hetzner DNS zone if it has changed - a self-hosted DynDNS.

## How it works
1. Fetches the current public IPv4 via `api4.ipify.org`
2. Compares it to the current value of the configured A record
3. Updates the record via the Hetzner Cloud API if the IP has changed

The **systemd timer interval** or **cron** (that you have to create by yourself) controls how quickly an IP change is detected. The **DNS TTL** of the A record controls how long resolvers cache the old value. For minimal delay, keep both low (e.g. 60 seconds) — otherwise clients may still see the old IP long after the record has been updated.

## Requirements
- Any linux distribution with `bash` and `curl` (AlpineOS, Debian, ...)
- A Hetzner account with a DNS zone migrated to Hetzner Console
- A Hetzner Cloud API token with DNS read/write permissions (open DNS zone > "Security" > "API tokens")

## Configuration
Set the following variables at the top of `dyndns-update.sh`:

| Variable | Description |
|---|---|
| `HETZNER_CLOUD_API_TOKEN` | Your Hetzner Cloud API token |
| `ZONE_NAME` | Your DNS zone, e.g. `example.com` |
| `RECORD_NAME` | The A record name to update, e.g. `dyndns` |

## Usage
Once set up, `dyndns.example.com` always resolves to your current public IP.
Other domains can point to it via a CNAME record.
