# vps-cleanup-lite

my personal script to declutter and streamline my Ubuntu VPS. (for DigitalOcean droplets or any lightweight server setup.)

## What It Does

- Disables unneeded services:
  - `do-agent` (DigitalOcean monitoring)
  - `udisks2` (disk management)
  - `polkit` (GUI privilege mgmt, useless on headless)
- Cleans up the ugly SSH login messages (MOTD, reboot warnings)
- Installs useful CLI tools (`htop`, `glances`)

## Tested On

- Ubuntu 22.04 LTS
- Ubuntu 24.04 LTS

## Usage:

```bash
wget https://raw.githubusercontent.com/ArtinDoroudi/vps-cleanup-lite/main/vps-minimalize.sh
chmod +x vps-minimalize.sh
./vps-minimalize.sh
```
```
